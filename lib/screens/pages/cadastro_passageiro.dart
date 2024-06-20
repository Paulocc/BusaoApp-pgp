import 'package:flutter/material.dart';
import 'package:giuse_app/database/sql_helper.dart';
import 'package:giuse_app/screens/bloc/passageiros_cubit.dart';

import '../../utils/consts/consts_colors.dart';
import '../components/text_form_field_padrao.dart';

class CadastroPassageiro extends StatefulWidget {
  const CadastroPassageiro({super.key});

  @override
  State<CadastroPassageiro> createState() => _CadastroPassageiroState();
}

class _CadastroPassageiroState extends State<CadastroPassageiro> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController embarqueController = TextEditingController();
  TextEditingController celularController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController desembarqueController = TextEditingController();

  late final PassageirosCubit _cubitPassageiros;

  @override
  initState() {
    super.initState();
    _cubitPassageiros = PassageirosCubit();
  }

  Future<void> addPassageiro() async {
    await SQLHelper.createPassageiro(
        nomeController.text,
        cpfController.text,
        celularController.hashCode,
        emailController.text,
        embarqueController.text,
        desembarqueController.text);
  }

  @override
  Widget build(BuildContext context) {
    Size sizeOf = MediaQuery.of(context).size;

    return Scaffold(
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
                      titulo: 'Endereço',
                      subTitulo: 'Digite seu endereço...',
                      controller: embarqueController,
                    ),
                    const SizedBox(height: 16),
                    TextFormFieldPadrao(
                      titulo: 'Celular',
                      subTitulo: 'Digite seu celular...',
                      controller: celularController,
                    ),
                    const SizedBox(height: 16),
                    TextFormFieldPadrao(
                      titulo: 'CPF',
                      subTitulo: 'Digite seu CPF...',
                      controller: cpfController,
                    ),
                    const SizedBox(height: 16),
                    TextFormFieldPadrao(
                      titulo: 'Email',
                      subTitulo: 'Digite seu Email...',
                      controller: emailController,
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
                      _cubitPassageiros.salvarPassageiro(nomeController.text);
                      addPassageiro();
                      Navigator.pop(context);
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
    );
  }
}
