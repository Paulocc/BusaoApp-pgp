class Viagem {
  String? titulo;
  String? saida;
  String? retorno;
  String? id;

  Viagem({this.titulo, this.saida, this.retorno, this.id});

  @override
  String toString() {
    return "Viagem"
        "{ Titulo: $titulo"
        ", Saída: $saida"
        ", Retorno: $retorno"
        ", Id: $id"
        "}";
  }
}
