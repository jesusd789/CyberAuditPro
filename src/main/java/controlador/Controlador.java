package controlador;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Amenaza;
import modelo.AmenazaDAO;
import modelo.Dispositivo;
import modelo.DispositivoDAO;

@WebServlet(name = "Controlador", urlPatterns = {"/Controlador"})
public class Controlador extends HttpServlet {

    private final AmenazaDAO amenazaDAO = new AmenazaDAO();
    private final DispositivoDAO dispositivoDAO = new DispositivoDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String accion = request.getParameter("accion");
        if (accion == null) {
            accion = "listar";
        }

        switch (accion) {

            case "Guardar": {
                Amenaza am = new Amenaza();
                am.setIdDispositivo(Integer.parseInt(request.getParameter("txtDispositivo")));
                am.setArchivo(request.getParameter("txtArchivo"));
                am.setTipo(request.getParameter("txtTipo"));
                am.setNivelRiesgo(request.getParameter("txtRiesgo"));
                am.setTamano(request.getParameter("txtTamano"));

                // El input HTML datetime-local envía "AAAA-MM-DDTHH:MM" -> MySQL espera "AAAA-MM-DD HH:MM:SS"
                String fecha = request.getParameter("txtFecha");
                if (fecha != null && fecha.contains("T")) {
                    fecha = fecha.replace("T", " ");
                    if (fecha.length() == 16) {
                        fecha += ":00";
                    }
                }
                am.setFechaDeteccion(fecha);

                amenazaDAO.agregar(am);
                response.sendRedirect("Controlador?accion=listar");
                break;
            }

            case "ActualizarEstado": {
                int id = Integer.parseInt(request.getParameter("id"));
                String nuevoEstado = request.getParameter("estado");
                amenazaDAO.actualizarEstado(id, nuevoEstado);
                response.sendRedirect("Controlador?accion=listar");
                break;
            }

            case "Eliminar": {
                int id = Integer.parseInt(request.getParameter("id"));
                amenazaDAO.eliminar(id);
                response.sendRedirect("Controlador?accion=listar");
                break;
            }

            default: { // "listar"
                List<Amenaza> listaAmenazas = amenazaDAO.listar();
                List<Dispositivo> listaDispositivos = dispositivoDAO.listar();
                request.setAttribute("listaAmenazas", listaAmenazas);
                request.setAttribute("listaDispositivos", listaDispositivos);
                request.getRequestDispatcher("amenazas.jsp").forward(request, response);
                break;
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
