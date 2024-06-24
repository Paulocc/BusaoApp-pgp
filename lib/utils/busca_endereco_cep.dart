import 'package:search_cep/search_cep.dart';

import '../models/endereco_model.dart';

Future<Endereco> buscaEnderecoCep(String cepString, String numero) async {
  int cep = int.parse(cepString.replaceAll('-', '').replaceAll('.', ''));

  switch (cep) {
    case 89815899:
      return Endereco(
        cep: '89815-899',
        logradouro: 'Rodovia SC 484 Km 02',
        bairro: 'Fronteira Sul',
        localidade: 'Chapecó',
        uf: 'SC',
        numero: numero,
      );
    case 89820000:
      return Endereco(
        cep: '89820-000',
        logradouro: 'R. Rui Barbosa',
        bairro: 'Centro',
        localidade: 'Xanxerê',
        uf: 'SC',
        numero: numero,
      );
    case 89825000:
      return Endereco(
        cep: '89825-000',
        logradouro: 'Av. Plínio Arlíndo de Nes',
        bairro: 'Centro',
        localidade: 'Xaxim',
        uf: 'SC',
        numero: numero,
      );
    default:
      ViaCepInfo infoCep = ViaCepInfo();
      infoCep = (await ViaCepSearchCep().searchInfoByCep(
        cep: cep.toString(),
      ))
          .fold((_) => ViaCepInfo(), (data) => data);
      return Endereco.fromToViaCepInfo(infoCep, numero);
  }
}