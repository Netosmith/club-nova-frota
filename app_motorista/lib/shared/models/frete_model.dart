class FreteModel {
  const FreteModel({
    required this.id,
    required this.cliente,
    required this.origem,
    required this.destino,
    required this.produto,
    required this.valor,
    required this.status,
    required this.observacoes,
  });

  final String id;
  final String cliente;
  final String origem;
  final String destino;
  final String produto;
  final double valor;
  final String status;
  final String observacoes;

  factory FreteModel.fromMap(String id, Map<String, dynamic> map) {
    return FreteModel(
      id: id,
      cliente: map['cliente'] ?? '',
      origem: map['origem'] ?? '',
      destino: map['destino'] ?? '',
      produto: map['produto'] ?? '',
      valor: (map['valor'] ?? 0).toDouble(),
      status: map['status'] ?? 'disponivel',
      observacoes: map['observacoes'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cliente': cliente,
      'origem': origem,
      'destino': destino,
      'produto': produto,
      'valor': valor,
      'status': status,
      'observacoes': observacoes,
    };
  }
}
