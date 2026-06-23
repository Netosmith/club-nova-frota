class PontosAdminModel {
  const PontosAdminModel({
    required this.id,
    required this.motoristaId,
    required this.nomeMotorista,
    required this.tipo,
    required this.pontos,
    required this.descricao,
    required this.origem,
    required this.referenciaId,
    required this.criadoPor,
  });

  final String id;
  final String motoristaId;
  final String nomeMotorista;
  final String tipo;
  final int pontos;
  final String descricao;
  final String origem;
  final String referenciaId;
  final String criadoPor;

  factory PontosAdminModel.fromMap(String id, Map<String, dynamic> map) {
    return PontosAdminModel(
      id: id,
      motoristaId: map['motoristaId'] ?? '',
      nomeMotorista: map['nomeMotorista'] ?? '',
      tipo: map['tipo'] ?? 'credito',
      pontos: (map['pontos'] ?? 0).toInt(),
      descricao: map['descricao'] ?? '',
      origem: map['origem'] ?? 'manual',
      referenciaId: map['referenciaId'] ?? '',
      criadoPor: map['criadoPor'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'motoristaId': motoristaId,
      'nomeMotorista': nomeMotorista,
      'tipo': tipo,
      'pontos': pontos,
      'descricao': descricao,
      'origem': origem,
      'referenciaId': referenciaId,
      'criadoPor': criadoPor,
    };
  }
}
