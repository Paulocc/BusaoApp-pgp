import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_cep/search_cep.dart';

import '../../models/endereco_model.dart';
import '../../models/viagem_model.dart';
import '../../utils/consts/consts_colors.dart';
import '../bloc/viagem/viagem_bloc.dart';
import '../components/container_endereco.dart';
import '../components/text_form_field_padrao.dart';

class CadastroViagens extends StatefulWidget {
  const CadastroViagens({super.key});

  @override
  State<CadastroViagens> createState() => _CadastroViagensState();
}

class _CadastroViagensState extends State<CadastroViagens> {
  ViaCepInfo _infoCepSaida = ViaCepInfo();
  ViaCepInfo _infoCepRetorno = ViaCepInfo();

  TextEditingController tituloController = TextEditingController();
  TextEditingController numeroSaidaController = TextEditingController();
  TextEditingController numeroRetornoController = TextEditingController();
  TextEditingController logradouroSaidaController = TextEditingController();
  TextEditingController logradouroRetornoController = TextEditingController();
  TextEditingController bairroSaidaController = TextEditingController();
  TextEditingController bairroRetornoController = TextEditingController();
  TextEditingController cidadeSaidaController = TextEditingController();
  TextEditingController cidadeRetornoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size sizeOf = MediaQuery.of(context).size;

    return BlocListener<ViagemBloc, ViagemState>(
      listener: (context, state) {
        if (state is ViagemSave) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Cadastra de Viagem',
            style: TextStyle(
              color: ConstColor.pinkVS,
            ),
          ),
          backgroundColor: ConstColor.pinkDM,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: SizedBox(
              height: sizeOf.height * .85,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        TextFormFieldPadrao(
                          titulo: 'Titulo da viagem',
                          subTitulo: 'Digite o Titulo da viagem...',
                          controller: tituloController,
                        ),
                        const SizedBox(height: 16),
                        ContainerEndereco(
                          titulo: 'Endereço do ponto de saida',
                          numeroController: numeroSaidaController,
                          logradouroController: logradouroSaidaController,
                          bairroController: bairroSaidaController,
                          cidadeController: cidadeSaidaController,
                          onChanged: _onChangedSaida,
                        ),
                        const SizedBox(height: 16),
                        ContainerEndereco(
                          titulo: 'Endereço do ponto de retorno',
                          numeroController: numeroRetornoController,
                          logradouroController: logradouroRetornoController,
                          bairroController: bairroRetornoController,
                          cidadeController: cidadeRetornoController,
                          onChanged: _onChangedRetorno,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xFFE8A2C0)),
                      ),
                      onPressed: () async {
                        BlocProvider.of<ViagemBloc>(context).add(
                          ViagemSalvar(
                            viagem: Viagem(
                              titulo: tituloController.text,
                              enderecoSaida: Endereco.fromToViaCepInfo(
                                _infoCepSaida,
                                numeroSaidaController.text,
                              ),
                              enderecoRetorno: Endereco.fromToViaCepInfo(
                                _infoCepRetorno,
                                numeroRetornoController.text,
                              ),
                            ),
                          ),
                        );
                      },
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        child: Text(
                          'Salvar',
                          style:
                              TextStyle(color: Color(0xFF9D5D7A), fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _onChangedSaida(String cepSaida) async {
    if (cepSaida.length == 10) {
      _infoCepSaida = (await ViaCepSearchCep().searchInfoByCep(
        cep: cepSaida.replaceAll('-', '').replaceAll('.', ''),
      ))
          .fold((_) => ViaCepInfo(), (data) => data);
    }
    setState(() {
      logradouroSaidaController.text = _infoCepSaida.logradouro ?? '';
      bairroSaidaController.text = _infoCepSaida.bairro ?? '';
      cidadeSaidaController.text = _infoCepSaida.localidade != null
          ? '${_infoCepSaida.localidade} - ${_infoCepSaida.uf}'
          : '';
    });
  }

  _onChangedRetorno(String cepSaida) async {
    if (cepSaida.length == 10) {
      _infoCepRetorno = (await ViaCepSearchCep().searchInfoByCep(
        cep: cepSaida.replaceAll('-', '').replaceAll('.', ''),
      ))
          .fold((_) => ViaCepInfo(), (data) => data);
    }
    setState(() {
      logradouroRetornoController.text = _infoCepRetorno.logradouro ?? '';
      bairroRetornoController.text = _infoCepRetorno.bairro ?? '';
      cidadeRetornoController.text = _infoCepRetorno.localidade != null
          ? '${_infoCepRetorno.localidade} - ${_infoCepRetorno.uf}'
          : '';
    });
  }
}
