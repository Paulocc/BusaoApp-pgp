import 'endereco_model.dart';

class Passageiro {
  int? id;
  String? nome;
  String? telefone;
  Endereco? enderecoEmbarque;
  Endereco? enderecoDesembarque;

  Passageiro({
    this.id,
    this.nome,
    this.telefone,
    this.enderecoEmbarque,
    this.enderecoDesembarque,
  });

  Map<String, dynamic> toMapBD() {
    return {
      'nome': nome,
      'telefone': telefone,
      'endereco_embarque': enderecoEmbarque!.toStringByMap(),
      'endereco_desembarque': enderecoDesembarque!.toStringByMap(),
    };
  }

  factory Passageiro.fromMap(Map<String, dynamic> map) {
    return Passageiro(
      id: map['id'],
      nome: map['nome'],
      telefone: map['telefone'],
      enderecoEmbarque: Endereco.fromToStringByMap(map['endereco_embarque']),
      enderecoDesembarque:
          Endereco.fromToStringByMap(map['endereco_desembarque']),
    );
  }

  static List<Passageiro> fromMapList(List<Map<String, dynamic>> mapList) {
    return mapList.map((map) => Passageiro.fromMap(map)).toList();
  }

  @override
  String toString() {
    return "Viagem"
        "{ id: $id"
        ", nome: $nome"
        ", telefone: $telefone"
        ", enderecoEmbarque: $enderecoEmbarque"
        ", enderecoDesembarque: $enderecoDesembarque"
        "}";
  }
}
