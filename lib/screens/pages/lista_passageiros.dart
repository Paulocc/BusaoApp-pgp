import 'package:flutter/material.dart';

import '../../utils/consts/consts_colors.dart';
import 'cadastro_passageiro.dart';

class ListaPassageiros extends StatelessWidget {
  const ListaPassageiros({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Passageiros',
          style: TextStyle(color: ConstColor.pinkVS),
        ),
        backgroundColor: ConstColor.pinkDM,
      ),
      //body: ,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CadastroPassageiro()),
          );
        },
        label: const Text('Passageiro'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
