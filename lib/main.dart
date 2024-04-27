import 'package:flutter/material.dart';

import 'pages/cadastro_passageiro.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GiuseApp',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 125, 152, 161)),
        useMaterial3: true,
      ),
      home: const CadastroPassageiro(),
    );
  }
}
