class MotoristaModel {
  const MotoristaModel({
    required this.id,
    required this.nome,
    required this.cpf,
    required this.telefone,
    required this.placa,
    required this.categoria,
    required this.cidade,
    required this.uf,
    required this.ativo,
    required this.pontos,
    required this.medalha,
  });

  final String id;
  final String nome;
  final String cpf;
  final String telefone;
  final String placa;
  final String categoria;
  final String cidade;
  final String uf;
  final bool ativo;
  final int pontos;
  final String medalha;

  factory MotoristaModel.fromMap(String id, Map<String, dynamic> map) {
    return MotoristaModel(
      id: id,
      nome: map['nome'] ?? '',
      cpf: map['cpf'] ?? '',
      telefone: map['telefone'] ?? '',
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
      'nome': nome,
      'cpf': cpf,
      'telefone': telefone,
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
