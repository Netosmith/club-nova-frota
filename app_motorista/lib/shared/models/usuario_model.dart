class UsuarioModel {
  const UsuarioModel({
    required this.id,
    required this.nome,
    required this.email,
    required this.perfil,
    required this.ativo,
  });

  final String id;
  final String nome;
  final String email;
  final String perfil;
  final bool ativo;

  factory UsuarioModel.fromMap(String id, Map<String, dynamic> map) {
    return UsuarioModel(
      id: id,
      nome: map['nome'] ?? '',
      email: map['email'] ?? '',
      perfil: map['perfil'] ?? 'motorista',
      ativo: map['ativo'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'email': email,
      'perfil': perfil,
      'ativo': ativo,
    };
  }
}
