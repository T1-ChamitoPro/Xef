package com.xef.xef_backend.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.xef.xef_backend.dto.RegistroRequest;
import com.xef.xef_backend.dto.UsuarioResponse;
import com.xef.xef_backend.model.Usuario;
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

    @SecurityRequirement(name = "bearerAuth")
    @GetMapping("/perfil")
    public UsuarioResponse perfil(
            org.springframework.security.core.Authentication authentication) {

        Usuario usuario = (Usuario) authentication.getPrincipal();

        return new UsuarioResponse(
                usuario.getId(),
                usuario.getNombre(),
                usuario.getEmail()
        );
    }
}

