class RankingAdminModel {
  const RankingAdminModel({
    required this.id,
    required this.motoristaId,
    required this.nomeMotorista,
    required this.pontos,
    required this.viagens,
    required this.indicacoes,
    required this.comprovantes,
    required this.medalha,
  });

  final String id;
  final String motoristaId;
  final String nomeMotorista;
  final int pontos;
  final int viagens;
  final int indicacoes;
  final int comprovantes;
  final String medalha;

  factory RankingAdminModel.fromMap(String id, Map<String, dynamic> map) {
    return RankingAdminModel(
      id: id,
      motoristaId: map['motoristaId'] ?? '',
      nomeMotorista: map['nomeMotorista'] ?? '',
      pontos: (map['pontos'] ?? 0).toInt(),
      viagens: (map['viagens'] ?? 0).toInt(),
      indicacoes: (map['indicacoes'] ?? 0).toInt(),
      comprovantes: (map['comprovantes'] ?? 0).toInt(),
      medalha: map['medalha'] ?? 'bronze',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'motoristaId': motoristaId,
      'nomeMotorista': nomeMotorista,
      'pontos': pontos,
      'viagens': viagens,
      'indicacoes': indicacoes,
      'comprovantes': comprovantes,
      'medalha': medalha,
    };
  }
}
