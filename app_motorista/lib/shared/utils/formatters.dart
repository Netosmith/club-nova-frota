class Formatters {
  static String moedaPorTonelada(num valor) {
    return 'R\$ ${valor.toStringAsFixed(2)}/t';
  }

  static String pontos(int pontos) {
    return '$pontos pontos';
  }

  static String rota(String origem, String destino) {
    return '$origem → $destino';
  }
}
