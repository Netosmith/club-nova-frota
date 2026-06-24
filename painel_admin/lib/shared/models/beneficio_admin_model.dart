class BeneficioAdminModel {
  const BeneficioAdminModel({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.categoria,
    required this.parceiro,
    required this.pontosNecessarios,
    required this.estoque,
    required this.imagemUrl,
    required this.ativo,
  });

  final String id;
  final String titulo;
  final String descricao;
  final String categoria;
  final String parceiro;
  final int pontosNecessarios;
  final int estoque;
  final String imagemUrl;
  final bool ativo;

  factory BeneficioAdminModel.fromMap(String id, Map<String, dynamic> map) {
    return BeneficioAdminModel(
      id: id,
      titulo: map['titulo'] ?? '',
      descricao: map['descricao'] ?? '',
      categoria: map['categoria'] ?? '',
      parceiro: map['parceiro'] ?? '',
      pontosNecessarios: (map['pontosNecessarios'] ?? 0).toInt(),
      estoque: (map['estoque'] ?? 0).toInt(),
      imagemUrl: map['imagemUrl'] ?? '',
      ativo: map['ativo'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'descricao': descricao,
      'categoria': categoria,
      'parceiro': parceiro,
      'pontosNecessarios': pontosNecessarios,
      'estoque': estoque,
      'imagemUrl': imagemUrl,
      'ativo': ativo,
    };
  }
}
