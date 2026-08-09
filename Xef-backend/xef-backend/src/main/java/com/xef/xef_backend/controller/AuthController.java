package com.xef.xef_backend.controller;

import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import com.xef.xef_backend.config.JwtService;
import com.xef.xef_backend.dto.LoginRequest;
import com.xef.xef_backend.dto.LoginResponse;
import com.xef.xef_backend.dto.UsuarioResponse;
import com.xef.xef_backend.model.Usuario;
import com.xef.xef_backend.repository.UsuarioRepository;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    private final UsuarioRepository usuarioRepository;
    private final JwtService jwtService;
    private final PasswordEncoder passwordEncoder;

    public AuthController(
            UsuarioRepository usuarioRepository,
            JwtService jwtService,
            PasswordEncoder passwordEncoder) {

        this.usuarioRepository = usuarioRepository;
        this.jwtService = jwtService;
        this.passwordEncoder = passwordEncoder;
    }

    @PostMapping("/login")
    public LoginResponse login(
            @Valid @RequestBody LoginRequest request) {

        Usuario usuario = usuarioRepository
                .findByEmail(request.getEmail())
                .orElseThrow(() ->
                        new ResponseStatusException(
                                HttpStatus.UNAUTHORIZED,
                                "Correo o contraseña incorrectos"
                        ));

        if (!passwordEncoder.matches(
                request.getPassword(),
                usuario.getPassword())) {

            throw new ResponseStatusException(
                    HttpStatus.UNAUTHORIZED,
                    "Correo o contraseña incorrectos"
            );
        }

        String token = jwtService.generarToken(usuario);

        UsuarioResponse usuarioResponse =
                new UsuarioResponse(
                        usuario.getId(),
                        usuario.getNombre(),
                        usuario.getEmail()
                );

        return new LoginResponse(token, usuarioResponse);
    }
}