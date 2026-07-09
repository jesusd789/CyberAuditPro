package modelo;

import config.Conexion;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AmenazaDAO {

    // READ - lista todas las amenazas, con el dispositivo asociado (INNER JOIN)
    public List<Amenaza> listar() {
        List<Amenaza> lista = new ArrayList<>();
        String sql = "SELECT a.id, a.id_dispositivo, a.archivo, a.tipo, a.nivel_riesgo, a.tamano, " +
                     "       a.fecha_deteccion, a.estado, d.nombre_host, d.direccion_ip " +
                     "FROM amenazas a " +
                     "INNER JOIN dispositivos d ON a.id_dispositivo = d.id " +
                     "ORDER BY a.fecha_deteccion DESC";

        try (Connection con = new Conexion().getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Amenaza am = new Amenaza();
                am.setId(rs.getInt("id"));
                am.setIdDispositivo(rs.getInt("id_dispositivo"));
                am.setArchivo(rs.getString("archivo"));
                am.setTipo(rs.getString("tipo"));
                am.setNivelRiesgo(rs.getString("nivel_riesgo"));
                am.setTamano(rs.getString("tamano"));
                am.setFechaDeteccion(rs.getString("fecha_deteccion"));
                am.setEstado(rs.getString("estado"));
                am.setNombreHost(rs.getString("nombre_host"));
                am.setDireccionIp(rs.getString("direccion_ip"));
                lista.add(am);
            }
        } catch (SQLException e) {
            System.err.println("Error al listar amenazas: " + e.getMessage());
        }
        return lista;
    }

    // CREATE - toda amenaza nueva entra en estado 'Cuarentena' (valor DEFAULT de la tabla)
    public boolean agregar(Amenaza am) {
        String sql = "INSERT INTO amenazas (id_dispositivo, archivo, tipo, nivel_riesgo, tamano, fecha_deteccion) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection con = new Conexion().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, am.getIdDispositivo());
            ps.setString(2, am.getArchivo());
            ps.setString(3, am.getTipo());
            ps.setString(4, am.getNivelRiesgo());
            ps.setString(5, am.getTamano());
            ps.setString(6, am.getFechaDeteccion());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.err.println("Error al insertar amenaza: " + e.getMessage());
            return false;
        }
    }

    // UPDATE - cambia el estado de una amenaza (Cuarentena <-> Restaurado)
    public boolean actualizarEstado(int id, String nuevoEstado) {
        String sql = "UPDATE amenazas SET estado = ? WHERE id = ?";

        try (Connection con = new Conexion().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, nuevoEstado);
            ps.setInt(2, id);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.err.println("Error al actualizar el estado de la amenaza: " + e.getMessage());
            return false;
        }
    }

    // DELETE - elimina definitivamente el registro de la amenaza
    // Nota: como historial_acciones tiene FK a amenazas con ON DELETE CASCADE,
    // borrar una amenaza también borra su historial asociado.
    public boolean eliminar(int id) {
        String sql = "DELETE FROM amenazas WHERE id = ?";

        try (Connection con = new Conexion().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.err.println("Error al eliminar la amenaza: " + e.getMessage());
            return false;
        }
    }
}
