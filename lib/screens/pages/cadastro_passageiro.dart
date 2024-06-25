import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/endereco_model.dart';
import '../../models/passageiro_model.dart';
import '../../utils/busca_endereco_cep.dart';
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
  Endereco _enderecoEmbarque = Endereco();
  Endereco _enderecoDesembarque = Endereco();

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
                          TelefoneInputFormatter(),
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
                        _enderecoEmbarque.numero =
                            numeroEmbarqueController.text;
                        _enderecoEmbarque.logradouro =
                            logradouroEmbarqueController.text;
                        _enderecoEmbarque.bairro =
                            bairroEmbarqueController.text;

                        _enderecoDesembarque.numero =
                            numeroDesembarqueController.text;
                        _enderecoEmbarque.logradouro =
                            logradouroDesembarqueController.text;
                        _enderecoEmbarque.bairro =
                            bairroDesembarqueController.text;


                        BlocProvider.of<PassageirosBloc>(context).add(
                          PassageirosSalvar(
                            passageiro: Passageiro(
                              nome: nomeController.text,
                              telefone: telefoneController.text,
                              enderecoEmbarque: _enderecoEmbarque,
                              enderecoDesembarque: _enderecoDesembarque,
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

  _onChangedEmbarque(String cep) async {
    if (cep.length == 10) {
      _enderecoEmbarque = await buscaEnderecoCep(
        cep,
        numeroEmbarqueController.text,
      );
    }
    setState(() {
      logradouroEmbarqueController.text = _enderecoEmbarque.logradouro ?? '';
      bairroEmbarqueController.text = _enderecoEmbarque.bairro ?? '';
      cidadeEmbarqueController.text = _enderecoEmbarque.localidade != null
          ? '${_enderecoEmbarque.localidade} - ${_enderecoEmbarque.uf}'
          : '';
    });
  }

  _onChangedDesembarque(String cep) async {
    if (cep.length == 10) {
      _enderecoDesembarque = await buscaEnderecoCep(
        cep,
        numeroDesembarqueController.text,
      );
    }
    setState(() {
      logradouroDesembarqueController.text =
          _enderecoDesembarque.logradouro ?? '';
      bairroDesembarqueController.text = _enderecoDesembarque.bairro ?? '';
      cidadeDesembarqueController.text = _enderecoDesembarque.localidade != null
          ? '${_enderecoDesembarque.localidade} - ${_enderecoDesembarque.uf}'
          : '';
    });
  }
}
