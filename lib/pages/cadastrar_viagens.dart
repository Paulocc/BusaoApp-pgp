import 'package:flutter/material.dart';

class CadastrarViagens extends StatefulWidget {
  const CadastrarViagens({super.key, required this.title});
  final String title;

  @override
  State<CadastrarViagens> createState() => _CadastrarViagensState();
}

class _CadastrarViagensState extends State<CadastrarViagens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding( padding: EdgeInsets.only(top: 80),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32), 
          child: Container(
          child: TextFormField(),
        ),
      ),
      ),
    );
  }
}