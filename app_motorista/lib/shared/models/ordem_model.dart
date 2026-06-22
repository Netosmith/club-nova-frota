class OrdemModel {
  const OrdemModel({
    required this.id,
    required this.motoristaId,
    required this.freteId,
    required this.status,
    required this.comprovanteUrl,
    required this.observacoes,
  });

  final String id;
  final String motoristaId;
  final String freteId;
  final String status;
  final String comprovanteUrl;
  final String observacoes;

  factory OrdemModel.fromMap(String id, Map<String, dynamic> map) {
    return OrdemModel(
      id: id,
      motoristaId: map['motoristaId'] ?? '',
      freteId: map['freteId'] ?? '',
      status: map['status'] ?? 'solicitada',
      comprovanteUrl: map['comprovanteUrl'] ?? '',
      observacoes: map['observacoes'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'motoristaId': motoristaId,
      'freteId': freteId,
      'status': status,
      'comprovanteUrl': comprovanteUrl,
      'observacoes': observacoes,
    };
  }
}
