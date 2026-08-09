package com.xef.xef_backend.config;

import java.util.Date;

import javax.crypto.SecretKey;

import org.springframework.stereotype.Service;

import com.xef.xef_backend.model.Usuario;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;

@Service
public class JwtService {
    private static final String SECRET_KEY = "XefProyectoMovilClaveSecreta2026SeguraParaJWTClaveSuperSegura";
    private static final long EXPIRATION_TIME = 1000 * 60 * 60 * 24;
    private final SecretKey key = Keys.hmacShaKeyFor(SECRET_KEY.getBytes());
    public String generarToken(Usuario usuario){
        Date ahora = new Date();
        Date expiracion = new Date(ahora.getTime() + EXPIRATION_TIME);

        return Jwts.builder()
            .subject(usuario.getEmail())
            .issuedAt(ahora)
            .expiration(expiracion)
            .signWith(key)
            .compact();
    }

    public String obtenerEmail(String token){
        return Jwts.parser()
            .verifyWith(key)
            .build()
            .parseSignedClaims(token)
            .getPayload()
            .getSubject();
    }
}
