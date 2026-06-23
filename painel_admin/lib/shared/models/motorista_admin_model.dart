class MotoristaAdminModel {
  const MotoristaAdminModel({
    required this.id,
    required this.usuarioId,
    required this.nome,
    required this.cpf,
    required this.telefone,
    required this.email,
    required this.placa,
    required this.categoria,
    required this.cidade,
    required this.uf,
    required this.ativo,
    required this.pontos,
    required this.medalha,
  });

  final String id;
  final String usuarioId;
  final String nome;
  final String cpf;
  final String telefone;
  final String email;
  final String placa;
  final String categoria;
  final String cidade;
  final String uf;
  final bool ativo;
  final int pontos;
  final String medalha;

  factory MotoristaAdminModel.fromMap(String id, Map<String, dynamic> map) {
    return MotoristaAdminModel(
      id: id,
      usuarioId: map['usuarioId'] ?? '',
      nome: map['nome'] ?? '',
      cpf: map['cpf'] ?? '',
      telefone: map['telefone'] ?? '',
      email: map['email'] ?? '',
      placa: map['placa'] ?? '',
      categoria: map['categoria'] ?? '',
      cidade: map['cidade'] ?? '',
      uf: map['uf'] ?? '',
      ativo: map['ativo'] ?? true,
      pontos: (map['pontos'] ?? 0).toInt(),
      medalha: map['medalha'] ?? 'bronze',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'usuarioId': usuarioId,
      'nome': nome,
      'cpf': cpf,
      'telefone': telefone,
      'email': email,
      'placa': placa,
      'categoria': categoria,
      'cidade': cidade,
      'uf': uf,
      'ativo': ativo,
      'pontos': pontos,
      'medalha': medalha,
    };
  }
}
