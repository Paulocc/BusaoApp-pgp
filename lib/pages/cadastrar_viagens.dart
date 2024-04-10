import 'package:flutter/material.dart';

import 'widgets/text_form_field_padrao.dart';

class CadastrarViagens extends StatefulWidget {
  const CadastrarViagens({super.key, required this.title});
  final String title;

  @override
  State<CadastrarViagens> createState() => _CadastrarViagensState();
}

class _CadastrarViagensState extends State<CadastrarViagens> {
  @override
  Widget build(BuildContext context) {
    Size sizeOf = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastra de Viagem'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: sizeOf.height * .9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    TextFormFieldPadrao(
                      titulo: 'Titulo',
                      subTitulo: 'Digite o Titulo da viagem...',
                    ),
                    SizedBox(height: 16),
                    TextFormFieldPadrao(
                      titulo: 'Local Saida',
                      subTitulo: 'Digite o local da saida..',
                    ),
                    SizedBox(height: 16),
                    TextFormFieldPadrao(
                      titulo: 'Horario de saida',
                      subTitulo: 'Digite o horario da saida...',
                    ),
                    SizedBox(height: 16),
                    TextFormFieldPadrao(
                      titulo: 'Local Retorno',
                      subTitulo: 'Digite o local do retorno...',
                    ),
                    SizedBox(height: 16),
                    TextFormFieldPadrao(
                      titulo: 'Horario de retorno',
                      subTitulo: 'Digite o horario da retorno...',
                    ),
                    SizedBox(height: 16),
                    TextFormFieldPadrao(
                      titulo: 'Dias de viagem',
                      subTitulo: 'Digite os dias que acontecerar a viagem...',
                    ),
                    SizedBox(height: 16),
                    TextFormFieldPadrao(
                      titulo: 'Horiaro disparo',
                      subTitulo: 'Digite o horario de diparo dos lembretes...',
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 64),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Salvar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
