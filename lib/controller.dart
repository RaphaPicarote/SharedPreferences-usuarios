import 'package:dados_locais/estados.dart';
import 'package:dados_locais/repository.dart';
import 'package:dados_locais/user.dart';
import 'package:flutter/cupertino.dart';

class Controller extends ChangeNotifier {
  final Repository repository;
  Controller(this.repository);

  Estados _estado = EstadoInicial();

  Estados get estado => _estado;

  List<Usuario> _usuarios = [];

  List<Usuario> get usuarios => _usuarios;

  void updateEstado(Estados newEstado) {
    _estado = newEstado;
    notifyListeners();
  }

  void criarUsuario({
    required String nome,
    required String email,
    required String senha,
  }) async {
    updateEstado(EstadoCarregando());
    try {
      final resultado = await repository.criarUsuario(
        Usuario(nome: nome, email: email, senha: senha),
      );
      if (resultado) {
        updateEstado(EstadoSucesso());
      } else {
        updateEstado(EstadoErro());
      }
    } catch (e) {
      updateEstado(EstadoErro());
    }
  }

  Future<void> getUsuarios() async {
    updateEstado(EstadoCarregando());
    try {
      _usuarios = await repository.getUsuarios();
      if (_usuarios.isNotEmpty) {
        updateEstado(EstadoSucesso());
      } else {
        updateEstado(EstadoInicial());
      }
    } catch (e) {
      updateEstado(EstadoErro());
    }
  }
}
