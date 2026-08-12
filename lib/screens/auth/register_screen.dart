import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nombreController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final AuthService _authService = AuthService();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nombreController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _crearCuenta() async {
    // Evita enviar más de una petición al mismo tiempo.
    if (_isLoading) return;

    final nombre = _nombreController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    // =========================
    // VALIDACIONES
    // =========================

    if (nombre.isEmpty) {
      _mostrarMensaje('Ingresa tu nombre.');
      return;
    }

    if (email.isEmpty) {
      _mostrarMensaje('Ingresa tu correo electrónico.');
      return;
    }

    if (!_emailValido(email)) {
      _mostrarMensaje('Ingresa un correo electrónico válido.');
      return;
    }

    if (password.isEmpty) {
      _mostrarMensaje('Ingresa una contraseña.');
      return;
    }

    if (password.length < 6) {
      _mostrarMensaje('La contraseña debe tener al menos 6 caracteres.');
      return;
    }

    if (confirmPassword.isEmpty) {
      _mostrarMensaje('Confirma tu contraseña.');
      return;
    }

    // IMPORTANTE:
    // Esta validación ocurre antes de llamar al backend.
    if (password != confirmPassword) {
      _mostrarMensaje('Las contraseñas no coinciden.');
      return;
    }

    // =========================
    // REGISTRO
    // =========================

    setState(() {
      _isLoading = true;
    });

    try {
      final error = await _authService.registro(
        nombre: nombre,
        email: email,
        password: password,
      );

      if (!mounted) return;

      if (error != null) {
        _mostrarMensaje(error);
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cuenta creada correctamente.')),
      );

      Navigator.pop(context);
    } catch (_) {
      if (!mounted) return;

      _mostrarMensaje('No se pudo conectar con el servidor.');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  bool _emailValido(String email) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
  }

  void _mostrarMensaje(String mensaje) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(mensaje)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear cuenta')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Crea tu cuenta 🍳',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              const Text(
                'Empieza a descubrir nuevas formas de cocinar.',
                style: TextStyle(color: AppColors.textSecondary),
              ),

              const SizedBox(height: 32),

              const Text(
                'Nombre',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 8),

              TextField(
                controller: _nombreController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  hintText: 'Tu nombre',
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                'Correo electrónico',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 8),

              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'correo@ejemplo.com',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                'Contraseña',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 8),

              TextField(
                controller: _passwordController,
                obscureText: obscurePassword,
                decoration: InputDecoration(
                  hintText: '••••••••',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                'Confirmar contraseña',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 8),

              TextField(
                controller: _confirmPasswordController,
                obscureText: obscureConfirmPassword,
                decoration: InputDecoration(
                  hintText: '••••••••',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscureConfirmPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        obscureConfirmPassword = !obscureConfirmPassword;
                      });
                  },
                  ),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _crearCuenta,
                  child: _isLoading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Crear cuenta'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
