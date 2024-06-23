import 'endereco_model.dart';

class Viagem {
  int? id;
  String? titulo;
  Endereco? enderecoSaida;
  Endereco? enderecoRetorno;

  Viagem({this.id, this.titulo, this.enderecoSaida, this.enderecoRetorno});

  Map<String, dynamic> toMapBD() {
    return {
      'titulo': titulo,
      'endereco_inicio': enderecoSaida!.toStringByMap(),
      'endereco_fim': enderecoRetorno!.toStringByMap(),
    };
  }

  factory Viagem.fromMap(Map<String, dynamic> map) {
    return Viagem(
      id: map['id'],
      titulo: map['titulo'],
      enderecoSaida: Endereco.fromToStringByMap(map['endereco_inicio']),
      enderecoRetorno: Endereco.fromToStringByMap(map['endereco_fim']),
    );
  }

  static List<Viagem> fromMapList(List<Map<String, dynamic>> mapList) {
    return mapList.map((map) => Viagem.fromMap(map)).toList();
  }

  @override
  String toString() {
    return "Viagem"
        "{ Id: $id"
        ", Titulo: $titulo"
        ", Saída: $enderecoSaida"
        ", Retorno: $enderecoRetorno"
        "}";
  }
}
