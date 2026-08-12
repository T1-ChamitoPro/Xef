import '../../storage/auth_storage.dart';

class AuthManager {
  final AuthStorage _storage = AuthStorage();

  Future<bool> estaLogueado() async {
    final token = await _storage.obtenerToken();
    return token != null && token.isNotEmpty;
  }

  Future<void> logout() async {
    await _storage.eliminarToken();
  }
}
