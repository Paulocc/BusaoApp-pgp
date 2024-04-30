import 'package:flutter/material.dart';

class TextFormFieldPadrao extends StatelessWidget {
  final String titulo;
  final String subTitulo;

  const TextFormFieldPadrao({
    super.key,
    required this.titulo,
    required this.subTitulo,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFB67491), width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFB67491), width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        hintText: subTitulo,
        labelText: titulo,
        labelStyle: const TextStyle(fontSize: 18.0, color: Color(0xFFB67491)),
      ),
    );
  }
}
