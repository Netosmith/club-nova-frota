class NotificacaoAdminModel {
  const NotificacaoAdminModel({
    required this.id,
    required this.titulo,
    required this.mensagem,
    required this.publico,
    required this.tipo,
    required this.status,
    required this.criadoPor,
  });

  final String id;
  final String titulo;
  final String mensagem;
  final String publico;
  final String tipo;
  final String status;
  final String criadoPor;

  factory NotificacaoAdminModel.fromMap(String id, Map<String, dynamic> map) {
    return NotificacaoAdminModel(
      id: id,
      titulo: map['titulo'] ?? '',
      mensagem: map['mensagem'] ?? '',
      publico: map['publico'] ?? 'todos',
      tipo: map['tipo'] ?? 'informativo',
      status: map['status'] ?? 'rascunho',
      criadoPor: map['criadoPor'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'mensagem': mensagem,
      'publico': publico,
      'tipo': tipo,
      'status': status,
      'criadoPor': criadoPor,
    };
  }
}
