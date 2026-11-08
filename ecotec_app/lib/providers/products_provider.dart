import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../services/product_api_service.dart';

enum ProductsStatus { initial, loading, success, error }

class ProductsProvider extends ChangeNotifier {
  ProductsProvider(this._service);

  final ProductApiService _service;
  ProductsStatus _status = ProductsStatus.initial;
  List<Product> _products = [];
  String? _errorMessage;

  ProductsStatus get status => _status;
  List<Product> get products => List.unmodifiable(_products);
  String? get errorMessage => _errorMessage;

  Future<void> loadProducts() async {
    _status = ProductsStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _products = await _service.fetchProducts();
      _status = ProductsStatus.success;
    } catch (error) {
      _errorMessage = error.toString().replaceFirst('Exception: ', '');
      _status = ProductsStatus.error;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _service.dispose();
    super.dispose();
  }
}
