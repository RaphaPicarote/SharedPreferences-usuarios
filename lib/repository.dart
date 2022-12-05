import 'package:dados_locais/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class Repository {
  Future<bool> criarUsuario(Usuario model);
  Future<List<Usuario>> getUsuarios();
}

class SharedPreferencesRepository implements Repository {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  @override
  Future<List<Usuario>> getUsuarios() async {
    final prefs = await _prefs;
    try {
      final usuarios = prefs.getStringList('usuarios') ?? [];
      if (usuarios.isEmpty) {
        return [];
      }
      final usuarioList = usuarios.map((e) => Usuario.fromJson(e)).toList();
      return usuarioList;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> criarUsuario(Usuario model) async {
    final prefs = await _prefs;
    final usuarios = prefs.getStringList('usuarios') ?? [];

    try {
      usuarios.add(model.toJson());
      await prefs.setStringList('usuarios', usuarios);
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
