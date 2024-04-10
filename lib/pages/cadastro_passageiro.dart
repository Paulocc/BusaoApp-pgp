import 'package:flutter/material.dart';

class CadastroPassageiro extends StatefulWidget {
  const CadastroPassageiro({super.key, required this.title});

  final String title;

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextFormField(
              controller: embarqueController,
              decoration: InputDecoration(labelText: 'Endereço de embarque'),
            ),
            TextFormField(
              controller: desembarqueController,
              decoration: InputDecoration(labelText: 'Endereço de desembarque'),
            ),
            TextFormField(
              controller: celularController,
              decoration: InputDecoration(labelText: 'Celular'),
            ),
            TextFormField(
              controller: cpfController,
              decoration: InputDecoration(labelText: 'CPF'),
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _salvar,
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
