import 'package:flutter/material.dart';
import 'pages/cadastro_passageiro.dart';
import 'pages/listar_viagens.dart';

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
      //home: const CadastroPassageiro(title: 'Rota Bus | Lista de Viagens'),
      home: const ListarViagem(title: 'Lista'),
    );
  }
}
