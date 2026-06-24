class ViagemAdminModel {
  const ViagemAdminModel({
    required this.id,
    required this.motoristaId,
    required this.nomeMotorista,
    required this.ordemId,
    required this.freteId,
    required this.origem,
    required this.destino,
    required this.status,
    required this.previsaoEntrega,
  });

  final String id;
  final String motoristaId;
  final String nomeMotorista;
  final String ordemId;
  final String freteId;
  final String origem;
  final String destino;
  final String status;
  final String previsaoEntrega;

  factory ViagemAdminModel.fromMap(String id, Map<String, dynamic> map) {
    return ViagemAdminModel(
      id: id,
      motoristaId: map['motoristaId'] ?? '',
      nomeMotorista: map['nomeMotorista'] ?? '',
      ordemId: map['ordemId'] ?? '',
      freteId: map['freteId'] ?? '',
      origem: map['origem'] ?? '',
      destino: map['destino'] ?? '',
      status: map['status'] ?? 'em_viagem',
      previsaoEntrega: map['previsaoEntrega'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'motoristaId': motoristaId,
      'nomeMotorista': nomeMotorista,
      'ordemId': ordemId,
      'freteId': freteId,
      'origem': origem,
      'destino': destino,
      'status': status,
      'previsaoEntrega': previsaoEntrega,
    };
  }
}
