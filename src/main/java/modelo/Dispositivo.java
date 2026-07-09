package modelo;

public class Dispositivo {
    private int id;
    private String nombreHost;
    private String direccionIp;
    private String sistemaOperativo;
    private String dependenciaArea;

    public Dispositivo() {
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNombreHost() { return nombreHost; }
    public void setNombreHost(String nombreHost) { this.nombreHost = nombreHost; }

    public String getDireccionIp() { return direccionIp; }
    public void setDireccionIp(String direccionIp) { this.direccionIp = direccionIp; }

    public String getSistemaOperativo() { return sistemaOperativo; }
    public void setSistemaOperativo(String sistemaOperativo) { this.sistemaOperativo = sistemaOperativo; }

    public String getDependenciaArea() { return dependenciaArea; }
    public void setDependenciaArea(String dependenciaArea) { this.dependenciaArea = dependenciaArea; }
}
