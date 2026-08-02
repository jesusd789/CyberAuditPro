package com.cyberaudit.api.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

/**
 * Mapea exactamente tu tabla real "usuarios":
 *   id            int, PK, auto_increment
 *   nombre        varchar(100), not null
 *   correo        varchar(100), not null, unico
 *   contrasena    varchar(255), not null
 *   id_rol        int, not null (FK hacia la tabla roles)
 *
 * Como la tabla ya existe en tu base de datos (creada por tu script
 * original), Hibernate solo la reconoce y trabaja sobre ella gracias
 * a spring.jpa.hibernate.ddl-auto=update. No la vuelve a crear.
 */
@Entity
@Table(name = "usuarios")
public class Usuario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NotBlank(message = "El nombre es obligatorio")
    @Column(nullable = false, length = 100)
    private String nombre;

    @NotBlank(message = "El correo es obligatorio")
    @Email(message = "El correo debe tener un formato valido")
    @Column(nullable = false, unique = true, length = 100)
    private String correo;

    @NotBlank(message = "La contrasena es obligatoria")
    @Column(nullable = false, length = 255)
    private String contrasena;

    @NotNull(message = "El id_rol es obligatorio")
    @Column(name = "id_rol", nullable = false)
    private Integer idRol;

    public Usuario() {
    }

    public Usuario(String nombre, String correo, String contrasena, Integer idRol) {
        this.nombre = nombre;
        this.correo = correo;
        this.contrasena = contrasena;
        this.idRol = idRol;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getContrasena() {
        return contrasena;
    }

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }

    public Integer getIdRol() {
        return idRol;
    }

    public void setIdRol(Integer idRol) {
        this.idRol = idRol;
    }
}
