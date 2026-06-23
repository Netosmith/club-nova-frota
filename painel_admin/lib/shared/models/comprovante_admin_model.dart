class ComprovanteAdminModel {
  const ComprovanteAdminModel({
    required this.id,
    required this.ordemId,
    required this.motoristaId,
    required this.arquivoUrl,
    required this.tipoArquivo,
    required this.status,
    required this.observacoes,
    required this.analisadoPor,
  });

  final String id;
  final String ordemId;
  final String motoristaId;
  final String arquivoUrl;
  final String tipoArquivo;
  final String status;
  final String observacoes;
  final String analisadoPor;

  factory ComprovanteAdminModel.fromMap(String id, Map<String, dynamic> map) {
    return ComprovanteAdminModel(
      id: id,
      ordemId: map['ordemId'] ?? '',
      motoristaId: map['motoristaId'] ?? '',
      arquivoUrl: map['arquivoUrl'] ?? '',
      tipoArquivo: map['tipoArquivo'] ?? '',
      status: map['status'] ?? 'enviado',
      observacoes: map['observacoes'] ?? '',
      analisadoPor: map['analisadoPor'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ordemId': ordemId,
      'motoristaId': motoristaId,
      'arquivoUrl': arquivoUrl,
      'tipoArquivo': tipoArquivo,
      'status': status,
      'observacoes': observacoes,
      'analisadoPor': analisadoPor,
    };
  }
}
