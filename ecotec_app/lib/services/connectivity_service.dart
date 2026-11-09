import 'package:connectivity_plus/connectivity_plus.dart';

/// Traduce los cambios de interfaces de red a un stream simple de conectividad.
/// Nota: una interfaz disponible no garantiza que Internet responda; solo detecta
/// si el dispositivo tiene alguna conexión de red distinta de `none`.
class ConnectivityService {
  ConnectivityService({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity();

  final Connectivity _connectivity;

  bool _hasNetwork(List<ConnectivityResult> results) =>
      results.any((result) => result != ConnectivityResult.none);

  Stream<bool> get onlineStream => _connectivity.onConnectivityChanged
      .map(_hasNetwork)
      .distinct();

  Future<bool> checkInitialStatus() async {
    final results = await _connectivity.checkConnectivity();
    return _hasNetwork(results);
  }
}
