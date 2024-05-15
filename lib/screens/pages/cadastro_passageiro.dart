import 'package:flutter/material.dart';
import 'package:giuse_app/screens/bloc/passageiros_cubit.dart';

import '../../utils/consts/consts_colors.dart';
import '../components/text_form_field_padrao.dart';

class CadastroPassageiro extends StatefulWidget {
  const CadastroPassageiro({super.key});

  @override
  State<CadastroPassageiro> createState() => _CadastroPassageiroState();
}

class _CadastroPassageiroState extends State<CadastroPassageiro> {
  //Nome, embarque, desembarque, celular, cpf, email
  TextEditingController nomeController = TextEditingController();
  TextEditingController embarqueController = TextEditingController();
  TextEditingController desembarqueController = TextEditingController();
  TextEditingController celularController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    late final PassageirosCubit cubitPassageiros;
    Size sizeOf = MediaQuery.of(context).size;

    @override
    initState(){
      super.initState();
      cubitPassageiros = BlocProvider.of<PassageirosCubit>;
    };

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
                    SizedBox(height: 16),
                    TextFormFieldPadrao(
                      titulo: 'Endereço',
                      subTitulo: 'Digite seu endereço...',
                      controller: embarqueController,
                    ),
                    SizedBox(height: 16),
                    TextFormFieldPadrao(
                      titulo: 'Endereço de desembarque',
                      subTitulo: 'Digite seu endereço desembarque...',
                      controller: desembarqueController,
                    ),
                    SizedBox(height: 16),
                    TextFormFieldPadrao(
                      titulo: 'Celular',
                      subTitulo: 'Digite seu celular...',
                      controller: celularController,
                    ),
                    SizedBox(height: 16),
                    TextFormFieldPadrao(
                      titulo: 'CPF',
                      subTitulo: 'Digite seu CPF...',
                      controller: cpfController,
                    ),
                    SizedBox(height: 16),
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
