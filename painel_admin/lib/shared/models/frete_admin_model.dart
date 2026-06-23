class FreteAdminModel {
  const FreteAdminModel({
    required this.id,
    required this.cliente,
    required this.origem,
    required this.destino,
    required this.produto,
    required this.valor,
    required this.pesoEstimado,
    required this.dataCarregamento,
    required this.observacoes,
    required this.status,
    required this.criadoPor,
  });

  final String id;
  final String cliente;
  final String origem;
  final String destino;
  final String produto;
  final double valor;
  final double pesoEstimado;
  final String dataCarregamento;
  final String observacoes;
  final String status;
  final String criadoPor;

  factory FreteAdminModel.fromMap(String id, Map<String, dynamic> map) {
    return FreteAdminModel(
      id: id,
      cliente: map['cliente'] ?? '',
      origem: map['origem'] ?? '',
      destino: map['destino'] ?? '',
      produto: map['produto'] ?? '',
      valor: (map['valor'] ?? 0).toDouble(),
      pesoEstimado: (map['pesoEstimado'] ?? 0).toDouble(),
      dataCarregamento: map['dataCarregamento'] ?? '',
      observacoes: map['observacoes'] ?? '',
      status: map['status'] ?? 'rascunho',
      criadoPor: map['criadoPor'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cliente': cliente,
      'origem': origem,
      'destino': destino,
      'produto': produto,
      'valor': valor,
      'pesoEstimado': pesoEstimado,
      'dataCarregamento': dataCarregamento,
      'observacoes': observacoes,
      'status': status,
      'criadoPor': criadoPor,
    };
  }
}
