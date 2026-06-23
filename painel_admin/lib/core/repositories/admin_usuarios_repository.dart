import '../../shared/models/usuario_admin_model.dart';
import '../services/admin_usuarios_service.dart';

class AdminUsuariosRepository {
  AdminUsuariosRepository({AdminUsuariosService? usuariosService})
      : _usuariosService = usuariosService ?? AdminUsuariosService();

  final AdminUsuariosService _usuariosService;

  Stream<List<UsuarioAdminModel>> listarUsuarios() {
    return _usuariosService.listarUsuarios();
  }

  Future<void> salvarUsuario(UsuarioAdminModel usuario) {
    return _usuariosService.salvarUsuario(usuario);
  }

  Future<void> ativarUsuario(String usuarioId) {
    return _usuariosService.atualizarStatus(
      usuarioId: usuarioId,
      ativo: true,
    );
  }

  Future<void> bloquearUsuario(String usuarioId) {
    return _usuariosService.atualizarStatus(
      usuarioId: usuarioId,
      ativo: false,
    );
  }
}
