import 'package:flutter/material.dart';

import '../../utils/consts/consts_colors.dart';
import '../components/text_form_field_padrao.dart';

class CadastroViagens extends StatefulWidget {
  const CadastroViagens({super.key});

  @override
  State<CadastroViagens> createState() => _CadastroViagensState();
}

class _CadastroViagensState extends State<CadastroViagens> {
  @override
  Widget build(BuildContext context) {
    Size sizeOf = MediaQuery.of(context).size;

    return Scaffold(
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
                const Padding(
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
                        subTitulo:
                            'Digite o horario de diparo dos lembretes...',
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
                    onPressed: () => Navigator.pop(context),
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
