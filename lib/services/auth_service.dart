import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl;

  // Konstruktor menerima baseUrl sebagai parameter
  AuthService(this.baseUrl);

  // Fungsi login
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login'); // Endpoint login API
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    // Periksa status code dari response
    if (response.statusCode == 200) {
      // Berhasil login
      final data = jsonDecode(response.body);
      return {'success': true, 'data': data};
    } else {
      // Gagal login, decode response body
      final data = jsonDecode(response.body);
      return {'success': false, 'message': data['message'] ?? 'Login Gagal'};
    }
  }

  // Fungsi register dengan tambahan field 'name'
  Future<Map<String, dynamic>> register(
      String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Registrasi berhasil'};
      } else {
        final data = jsonDecode(response.body);
        return {
          'success': false,
          'message': data['message'] ?? 'Registrasi gagal'
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Terjadi kesalahan: $e'};
    }
  }
}
