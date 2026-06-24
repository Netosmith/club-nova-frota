class MonitoramentoAdminModel {
  const MonitoramentoAdminModel({
    required this.id,
    required this.motoristaId,
    required this.nomeMotorista,
    required this.ordemId,
    required this.freteId,
    required this.origem,
    required this.destino,
    required this.posicaoAtual,
    required this.status,
    required this.ultimaAtualizacao,
  });

  final String id;
  final String motoristaId;
  final String nomeMotorista;
  final String ordemId;
  final String freteId;
  final String origem;
  final String destino;
  final String posicaoAtual;
  final String status;
  final String ultimaAtualizacao;

  factory MonitoramentoAdminModel.fromMap(String id, Map<String, dynamic> map) {
    return MonitoramentoAdminModel(
      id: id,
      motoristaId: map['motoristaId'] ?? '',
      nomeMotorista: map['nomeMotorista'] ?? '',
      ordemId: map['ordemId'] ?? '',
      freteId: map['freteId'] ?? '',
      origem: map['origem'] ?? '',
      destino: map['destino'] ?? '',
      posicaoAtual: map['posicaoAtual'] ?? '',
      status: map['status'] ?? 'em_viagem',
      ultimaAtualizacao: map['ultimaAtualizacao'] ?? '',
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
      'posicaoAtual': posicaoAtual,
      'status': status,
      'ultimaAtualizacao': ultimaAtualizacao,
    };
  }
}
