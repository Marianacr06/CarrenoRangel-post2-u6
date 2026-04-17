package com.universidad.mvc.model;

public class Usuario {
    private String username;
    private String email;
    private String rol; // "ADMIN" o "VIEWER"

    public Usuario(String username, String email, String rol) {
        this.username = username;
        this.email = email;
        this.rol = rol;
    }

    public String getUsername() {
        return username;
    }

    public String getEmail() {
        return email;
    }

    public String getRol() {
        return rol;
    }

    @Override
    public String toString() {
        return "Usuario{" +
                "username='" + username + '\'' +
                ", email='" + email + '\'' +
                ", rol='" + rol + '\'' +
                '}';
    }
}
