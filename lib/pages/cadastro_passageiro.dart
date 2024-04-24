import 'package:GiuseApp/pages/widgets/text_form_field_padrao.dart';
import 'package:flutter/material.dart';

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

  void _salvar() {
    print('Se apareceu no vscode é sucesso');
    print(nomeController.text);
  }

  @override
  Widget build(BuildContext context) {
    Size sizeOf = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cadastro de Passageiros',
          style: TextStyle(
            color: Color(0xFF844662),
          ),
        ),
        backgroundColor: Color(0xFFE8A2C0),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Container(
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
                    ),
                    SizedBox(height: 16),
                    TextFormFieldPadrao(
                      titulo: 'Endereço',
                      subTitulo: 'Digite seu endereço...',
                    ),
                    SizedBox(height: 16),
                    TextFormFieldPadrao(
                      titulo: 'Endereço de desembarque',
                      subTitulo: 'Digite seu endereço desembarque...',
                    ),
                    SizedBox(height: 16),
                    TextFormFieldPadrao(
                      titulo: 'Celular',
                      subTitulo: 'Digite seu celular...',
                    ),
                    SizedBox(height: 16),
                    TextFormFieldPadrao(
                      titulo: 'CPF',
                      subTitulo: 'Digite seu CPF...',
                    ),
                    SizedBox(height: 16),
                    TextFormFieldPadrao(
                      titulo: 'Email',
                      subTitulo: 'Digite seu Email...',
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFFE8A2C0)),
                    ),
                    onPressed: () {},
                    child: Padding(
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
