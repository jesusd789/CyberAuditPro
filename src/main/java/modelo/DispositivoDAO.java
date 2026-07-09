package modelo;

import config.Conexion;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DispositivoDAO {

    // READ - lista todos los dispositivos registrados (para el combo del formulario)
    public List<Dispositivo> listar() {
        List<Dispositivo> lista = new ArrayList<>();
        String sql = "SELECT id, nombre_host, direccion_ip, sistema_operativo, dependencia_area " +
                     "FROM dispositivos ORDER BY nombre_host";

        try (Connection con = new Conexion().getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Dispositivo d = new Dispositivo();
                d.setId(rs.getInt("id"));
                d.setNombreHost(rs.getString("nombre_host"));
                d.setDireccionIp(rs.getString("direccion_ip"));
                d.setSistemaOperativo(rs.getString("sistema_operativo"));
                d.setDependenciaArea(rs.getString("dependencia_area"));
                lista.add(d);
            }
        } catch (SQLException e) {
            System.err.println("Error al listar dispositivos: " + e.getMessage());
        }
        return lista;
    }
}
