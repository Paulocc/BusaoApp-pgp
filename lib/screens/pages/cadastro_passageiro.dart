import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_cep/search_cep.dart';

import '../../models/endereco_model.dart';
import '../../models/passageiro_model.dart';
import '../../utils/consts/consts_colors.dart';
import '../bloc/passageiros/passageiros_bloc.dart';
import '../components/container_endereco.dart';
import '../components/text_form_field_padrao.dart';

class CadastroPassageiro extends StatefulWidget {
  const CadastroPassageiro({super.key});

  @override
  State<CadastroPassageiro> createState() => _CadastroPassageiroState();
}

class _CadastroPassageiroState extends State<CadastroPassageiro> {
  ViaCepInfo _infoCepEmbarque = ViaCepInfo();
  ViaCepInfo _infoCepDesembarque = ViaCepInfo();

  TextEditingController nomeController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();
  TextEditingController numeroEmbarqueController = TextEditingController();
  TextEditingController numeroDesembarqueController = TextEditingController();
  TextEditingController logradouroEmbarqueController = TextEditingController();
  TextEditingController logradouroDesembarqueController =
      TextEditingController();
  TextEditingController bairroEmbarqueController = TextEditingController();
  TextEditingController bairroDesembarqueController = TextEditingController();
  TextEditingController cidadeEmbarqueController = TextEditingController();
  TextEditingController cidadeDesembarqueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size sizeOf = MediaQuery.of(context).size;

    return BlocListener<PassageirosBloc, PassageirosState>(
      listener: (context, state) {
        if (state is PassageirosSave) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Cadastro de Passageiros',
            style: TextStyle(
              color: ConstColor.pinkVS,
            ),
          ),
          backgroundColor: ConstColor.pinkDM,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: sizeOf.height * .85,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextFormFieldPadrao(
                        titulo: 'Nome',
                        subTitulo: 'Digite seu nome...',
                        controller: nomeController,
                      ),
                      const SizedBox(height: 16),
                      TextFormFieldPadrao(
                        titulo: 'Telefone',
                        subTitulo: 'Digite seu número de telefone...',
                        controller: telefoneController,
                        textInputType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(11),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ContainerEndereco(
                        titulo: 'Endereço do ponto de embarque',
                        numeroController: numeroEmbarqueController,
                        logradouroController: logradouroEmbarqueController,
                        bairroController: bairroEmbarqueController,
                        cidadeController: cidadeEmbarqueController,
                        onChanged: _onChangedEmbarque,
                      ),
                      const SizedBox(height: 16),
                      ContainerEndereco(
                        titulo: 'Endereço do ponto de desembarque',
                        numeroController: numeroDesembarqueController,
                        logradouroController: logradouroDesembarqueController,
                        bairroController: bairroDesembarqueController,
                        cidadeController: cidadeDesembarqueController,
                        onChanged: _onChangedDesembarque,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xFFE8A2C0)),
                      ),
                      onPressed: () {
                        BlocProvider.of<PassageirosBloc>(context).add(
                          PassageirosSalvar(
                            passageiro: Passageiro(
                              nome: nomeController.text,
                              telefone: telefoneController.text,
                              enderecoEmbarque: Endereco.fromToViaCepInfo(
                                  _infoCepEmbarque,
                                  numeroEmbarqueController.text),
                              enderecoDesembarque: Endereco.fromToViaCepInfo(
                                _infoCepDesembarque,
                                numeroDesembarqueController.text,
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

  _onChangedEmbarque(String cepSaida) async {
    if (cepSaida.length == 8) {
      _infoCepEmbarque =
          (await ViaCepSearchCep().searchInfoByCep(cep: cepSaida))
              .fold((_) => ViaCepInfo(), (data) => data);
    }
    setState(() {
      logradouroEmbarqueController.text = _infoCepEmbarque.logradouro ?? '';
      bairroEmbarqueController.text = _infoCepEmbarque.bairro ?? '';
      cidadeEmbarqueController.text = _infoCepEmbarque.localidade != null
          ? '${_infoCepEmbarque.localidade} - ${_infoCepEmbarque.uf}'
          : '';
    });
  }

  _onChangedDesembarque(String cepSaida) async {
    if (cepSaida.length == 8) {
      _infoCepDesembarque =
          (await ViaCepSearchCep().searchInfoByCep(cep: cepSaida))
              .fold((_) => ViaCepInfo(), (data) => data);
    }
    setState(() {
      logradouroDesembarqueController.text =
          _infoCepDesembarque.logradouro ?? '';
      bairroDesembarqueController.text = _infoCepDesembarque.bairro ?? '';
      cidadeDesembarqueController.text = _infoCepDesembarque.localidade != null
          ? '${_infoCepDesembarque.localidade} - ${_infoCepDesembarque.uf}'
          : '';
    });
  }
}
