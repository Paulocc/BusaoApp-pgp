class Viagem {
  String? titulo;
  String? saida;
  String? retorno;

  Viagem({
    this.titulo,
    this.saida,
    this.retorno,
  });

  @override
  String toString() {
    return "Viagem"
        "{ Titulo: $titulo"
        ", Saída: $saida"
        ", Retorno: $retorno"
        "}";
  }
}
