import 'dart:convert';
import 'package:http/http.dart' as http;

import '../storage/auth_storage.dart';

class AuthService {
  final String baseUrl = 'http://192.168.0.22:8080';

  final AuthStorage _authStorage = AuthStorage();

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final token = data['token'];

      if (token != null) {
        await _authStorage.guardarToken(token);
        return null;
      }

      return 'El servidor no devolvió un token.';
    }

    return 'Correo o contraseña incorrectos.';
  }

  Future<String?> registro({
    required String nombre,
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/usuarios/registro'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nombre': nombre,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return null;
    }

    try {
      final data = jsonDecode(response.body);

      return data['message'] ??
          data['mensaje'] ??
          'No fue posible crear la cuenta.';
    } catch (_) {
      return 'No fue posible crear la cuenta.';
    }
  }

  Future<Map<String, dynamic>?> obtenerPerfil() async {
    final token = await _authStorage.obtenerToken();

    if (token == null) {
      return null;
    }

    final response = await http.get(
      Uri.parse('$baseUrl/api/usuarios/me'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    return null;
  }
}
