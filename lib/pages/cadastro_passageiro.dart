import 'package:flutter/material.dart';

class CadastroPassageiro extends StatefulWidget {
  const CadastroPassageiro({super.key, required this.title});

  final String title;

  @override
  State<CadastroPassageiro> createState() => _CadastroPassageiroState();
}

class _CadastroPassageiroState extends State<CadastroPassageiro> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.blue,
          child: TextFormField(),
        ),
      ),
    );
  }
}
