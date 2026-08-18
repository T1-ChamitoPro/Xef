package com.xef.xef_backend.controller;

import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.xef.xef_backend.dto.ActualizarUsuarioRequest;
import com.xef.xef_backend.dto.RegistroRequest;
import com.xef.xef_backend.dto.UsuarioResponse;
import com.xef.xef_backend.service.UsuarioService;

import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import jakarta.validation.Valid;

@RestController
@RequestMapping("/api/usuarios")
public class UsuarioController {

    private final UsuarioService usuarioService;

    public UsuarioController(UsuarioService usuarioService) {
        this.usuarioService = usuarioService;
    }

    @PostMapping("/registro")
    public UsuarioResponse registrar(@Valid @RequestBody RegistroRequest request) {
        return usuarioService.registrar(request);
    }

    @GetMapping("/me")
    @SecurityRequirement(name = "bearerAuth")
    public UsuarioResponse obtenerUsuarioActual(Authentication authentication) {
        String email = authentication.getName();
        return usuarioService.obtenerPorEmail(email);
    }

    @PutMapping("/me")
    @SecurityRequirement(name = "bearerAuth")
    public UsuarioResponse actualizarUsuario(
        Authentication authentication,
        @Valid @RequestBody ActualizarUsuarioRequest request
    ) {
        String emailActual = authentication.getName();

        return usuarioService.actualizarUsuario(emailActual, request);
    }
}

