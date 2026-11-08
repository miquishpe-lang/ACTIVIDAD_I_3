import 'package:shared_preferences/shared_preferences.dart';

/// Persistencia pequeña para mantener borradores y el último estado conocido.
/// El contenido principal del portafolio también está empaquetado en la app,
/// por lo que las secciones estáticas siguen disponibles sin conexión.
class LocalRepository {
  static const _draftKey = 'contact_draft';
  static const _lastNetworkKey = 'last_network_status';
  static const _lastImageKey = 'last_selected_image_path';

  Future<void> saveContactDraft(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_draftKey, value);
  }

  Future<String> readContactDraft() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_draftKey) ?? '';
  }

  Future<void> saveNetworkStatus(bool online) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_lastNetworkKey, online);
  }

  Future<bool?> readNetworkStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_lastNetworkKey);
  }

  Future<void> saveImagePath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastImageKey, path);
  }

  Future<String?> readImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_lastImageKey);
  }
}
