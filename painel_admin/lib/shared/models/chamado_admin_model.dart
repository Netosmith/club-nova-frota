class ChamadoAdminModel {
  const ChamadoAdminModel({
    required this.id,
    required this.motoristaId,
    required this.nomeMotorista,
    required this.telefone,
    required this.assunto,
    required this.descricao,
    required this.prioridade,
    required this.status,
    required this.responsavel,
  });

  final String id;
  final String motoristaId;
  final String nomeMotorista;
  final String telefone;
  final String assunto;
  final String descricao;
  final String prioridade;
  final String status;
  final String responsavel;

  factory ChamadoAdminModel.fromMap(String id, Map<String, dynamic> map) {
    return ChamadoAdminModel(
      id: id,
      motoristaId: map['motoristaId'] ?? '',
      nomeMotorista: map['nomeMotorista'] ?? '',
      telefone: map['telefone'] ?? '',
      assunto: map['assunto'] ?? '',
      descricao: map['descricao'] ?? '',
      prioridade: map['prioridade'] ?? 'normal',
      status: map['status'] ?? 'aberto',
      responsavel: map['responsavel'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'motoristaId': motoristaId,
      'nomeMotorista': nomeMotorista,
      'telefone': telefone,
      'assunto': assunto,
      'descricao': descricao,
      'prioridade': prioridade,
      'status': status,
      'responsavel': responsavel,
    };
  }
}
