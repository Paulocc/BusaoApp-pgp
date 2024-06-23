import 'package:search_cep/search_cep.dart';

class Endereco {
  String? cep;
  String? logradouro;
  String? bairro;
  String? localidade;
  String? uf;
  String? numero;

  Endereco({
    this.cep,
    this.logradouro,
    this.bairro,
    this.localidade,
    this.uf,
    this.numero,
  });

  String toStringByMap() {
    return "$cep"
        ", $logradouro"
        ", $bairro"
        ", $localidade - $uf"
        ", $numero";
  }

  factory Endereco.fromToStringByMap(String string) {
    List<String> splitted = string.split(',');
    List<String> cidade = splitted[3].split(' - ');
    return Endereco(
      cep: splitted[0],
      logradouro: splitted[1],
      bairro: splitted[2],
      localidade: cidade[0],
      uf: cidade[1],
      numero: splitted[4],
    );
  }

  factory Endereco.fromToViaCepInfo(ViaCepInfo info, String numero) {
    return Endereco(
      cep: info.cep,
      logradouro: info.logradouro,
      bairro: info.bairro,
      localidade: info.localidade,
      uf: info.uf,
      numero: numero,
    );
  }

  @override
  String toString() {
    return "Endereco"
        "{ cep: $cep"
        ", logradouro: $logradouro"
        ", bairro: $bairro"
        ", localidade: $localidade"
        ", uf: $uf"
        ", numero: $numero"
        "}";
  }
}
