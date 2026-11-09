import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductApiService {
  ProductApiService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;
  static final Uri _endpoint =
      Uri.parse('https://dummyjson.com/products?limit=20');

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await _client
          .get(_endpoint, headers: {'Accept': 'application/json'})
          .timeout(const Duration(seconds: 15));

      if (response.statusCode != 200) {
        throw Exception('El servidor respondió con código ${response.statusCode}.');
      }

      final decoded = jsonDecode(response.body) as Map<String, dynamic>;
      final items = decoded['products'] as List<dynamic>?;
      if (items == null) {
        throw const FormatException('La respuesta no contiene la lista products.');
      }

      return items
          .whereType<Map<String, dynamic>>()
          .map(Product.fromJson)
          .toList();
    } on http.ClientException {
      throw Exception('No se pudo conectar con el servicio. Verifica tu red.');
    } on SocketException {
      throw Exception('No hay conexión de red. Comprueba Wi-Fi o datos móviles.');
    } on TimeoutException {
      throw Exception('La solicitud tardó demasiado. Intenta nuevamente.');
    } on FormatException {
      throw Exception('La respuesta del servidor tiene un formato inválido.');
    }
  }

  void dispose() => _client.close();
}
