class ResgateAdminModel {
  const ResgateAdminModel({
    required this.id,
    required this.motoristaId,
    required this.nomeMotorista,
    required this.beneficioId,
    required this.tituloBeneficio,
    required this.pontosUtilizados,
    required this.status,
    required this.observacoes,
  });

  final String id;
  final String motoristaId;
  final String nomeMotorista;
  final String beneficioId;
  final String tituloBeneficio;
  final int pontosUtilizados;
  final String status;
  final String observacoes;

  factory ResgateAdminModel.fromMap(String id, Map<String, dynamic> map) {
    return ResgateAdminModel(
      id: id,
      motoristaId: map['motoristaId'] ?? '',
      nomeMotorista: map['nomeMotorista'] ?? '',
      beneficioId: map['beneficioId'] ?? '',
      tituloBeneficio: map['tituloBeneficio'] ?? '',
      pontosUtilizados: (map['pontosUtilizados'] ?? 0).toInt(),
      status: map['status'] ?? 'solicitado',
      observacoes: map['observacoes'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'motoristaId': motoristaId,
      'nomeMotorista': nomeMotorista,
      'beneficioId': beneficioId,
      'tituloBeneficio': tituloBeneficio,
      'pontosUtilizados': pontosUtilizados,
      'status': status,
      'observacoes': observacoes,
    };
  }
}
