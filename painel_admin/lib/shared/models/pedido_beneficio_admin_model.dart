class PedidoBeneficioAdminModel {
  const PedidoBeneficioAdminModel({
    required this.id,
    required this.motoristaId,
    required this.nomeMotorista,
    required this.beneficioId,
    required this.tituloBeneficio,
    required this.pontosUsados,
    required this.situacao,
    required this.observacoes,
  });

  final String id;
  final String motoristaId;
  final String nomeMotorista;
  final String beneficioId;
  final String tituloBeneficio;
  final int pontosUsados;
  final String situacao;
  final String observacoes;

  factory PedidoBeneficioAdminModel.fromMap(String id, Map<String, dynamic> map) {
    return PedidoBeneficioAdminModel(
      id: id,
      motoristaId: map['motoristaId'] ?? '',
      nomeMotorista: map['nomeMotorista'] ?? '',
      beneficioId: map['beneficioId'] ?? '',
      tituloBeneficio: map['tituloBeneficio'] ?? '',
      pontosUsados: (map['pontosUsados'] ?? 0).toInt(),
      situacao: map['situacao'] ?? 'novo',
      observacoes: map['observacoes'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'motoristaId': motoristaId,
      'nomeMotorista': nomeMotorista,
      'beneficioId': beneficioId,
      'tituloBeneficio': tituloBeneficio,
      'pontosUsados': pontosUsados,
      'situacao': situacao,
      'observacoes': observacoes,
    };
  }
}
