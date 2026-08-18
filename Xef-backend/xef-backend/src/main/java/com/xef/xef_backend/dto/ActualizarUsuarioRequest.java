package com.xef.xef_backend.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

public class ActualizarUsuarioRequest{
    @NotBlank
    private String nombre;

    @NotBlank
    @Email
    private String email;

    public ActualizarUsuarioRequest() {}

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}