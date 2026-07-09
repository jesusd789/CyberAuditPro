package modelo;

public class Amenaza {
    private int id;
    private int idDispositivo;
    private String archivo;
    private String tipo;
    private String nivelRiesgo;
    private String tamano;
    private String fechaDeteccion;
    private String estado;

    // Campos de solo lectura que llegan del JOIN con dispositivos
    private String nombreHost;
    private String direccionIp;

    public Amenaza() {
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getIdDispositivo() { return idDispositivo; }
    public void setIdDispositivo(int idDispositivo) { this.idDispositivo = idDispositivo; }

    public String getArchivo() { return archivo; }
    public void setArchivo(String archivo) { this.archivo = archivo; }

    public String getTipo() { return tipo; }
    public void setTipo(String tipo) { this.tipo = tipo; }

    public String getNivelRiesgo() { return nivelRiesgo; }
    public void setNivelRiesgo(String nivelRiesgo) { this.nivelRiesgo = nivelRiesgo; }

    public String getTamano() { return tamano; }
    public void setTamano(String tamano) { this.tamano = tamano; }

    public String getFechaDeteccion() { return fechaDeteccion; }
    public void setFechaDeteccion(String fechaDeteccion) { this.fechaDeteccion = fechaDeteccion; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }

    public String getNombreHost() { return nombreHost; }
    public void setNombreHost(String nombreHost) { this.nombreHost = nombreHost; }

    public String getDireccionIp() { return direccionIp; }
    public void setDireccionIp(String direccionIp) { this.direccionIp = direccionIp; }
}
