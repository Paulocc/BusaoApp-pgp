import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/endereco_model.dart';
import '../../models/viagem_model.dart';
import '../../utils/busca_endereco_cep.dart';
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
  Endereco _enderecoSaida = Endereco();
  Endereco _enderecoRetorno = Endereco();

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
            'Cadastro de Viagem',
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
                        _enderecoSaida.numero = numeroSaidaController.text;
                        _enderecoRetorno.numero = numeroRetornoController.text;
                        BlocProvider.of<ViagemBloc>(context).add(
                          ViagemSalvar(
                            viagem: Viagem(
                              titulo: tituloController.text,
                              enderecoSaida: _enderecoSaida,
                              enderecoRetorno: _enderecoRetorno,
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
      _enderecoSaida = await buscaEnderecoCep(
        cepSaida,
        numeroSaidaController.text,
      );
    }
    setState(() {
      logradouroSaidaController.text = _enderecoSaida.logradouro ?? '';
      bairroSaidaController.text = _enderecoSaida.bairro ?? '';
      cidadeSaidaController.text = _enderecoSaida.localidade != null
          ? '${_enderecoSaida.localidade} - ${_enderecoSaida.uf}'
          : '';
    });
  }

  _onChangedRetorno(String cepRetorno) async {
    if (cepRetorno.length == 10) {
      _enderecoRetorno = await buscaEnderecoCep(
        cepRetorno,
        numeroRetornoController.text,
      );
    }
    setState(() {
      logradouroRetornoController.text = _enderecoRetorno.logradouro ?? '';
      bairroRetornoController.text = _enderecoRetorno.bairro ?? '';
      cidadeRetornoController.text = _enderecoRetorno.localidade != null
          ? '${_enderecoRetorno.localidade} - ${_enderecoRetorno.uf}'
          : '';
    });
  }
}
