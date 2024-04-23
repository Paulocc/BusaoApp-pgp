import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'pages/cadastrar_viagens.dart';
=======
import 'pages/cadastro_passageiro.dart';
import 'pages/listar_viagens.dart';
>>>>>>> 7d4952e5ce624a89cff544920fda419207c81cf5

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rota Bus',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 125, 152, 161)),
        useMaterial3: true,
      ),
<<<<<<< HEAD
      home: const CadastrarViagens(title: 'Rota Bus | Lista de Viagens'),
=======
      //home: const CadastroPassageiro(title: 'Rota Bus | Lista de Viagens'),
      home: const ListarViagem(title: 'Lista'),
>>>>>>> 7d4952e5ce624a89cff544920fda419207c81cf5
    );
  }
}
