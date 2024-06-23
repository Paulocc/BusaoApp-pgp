import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/consts/consts_colors.dart';

class TextFormFieldPadrao extends StatelessWidget {
  final String titulo;
  final String subTitulo;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final bool enabled;
  final TextInputType textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;

  const TextFormFieldPadrao({
    super.key,
    required this.titulo,
    this.subTitulo = '',
    this.onChanged,
    this.controller,
    this.inputFormatters,
    this.initialValue,
    this.enabled = true,
    this.textInputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      enabled: enabled,
      keyboardType: textInputType,
      inputFormatters: inputFormatters,
      initialValue: initialValue,
      decoration: InputDecoration(
        isDense: true,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ConstColor.pinkSD, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ConstColor.pinkSD, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        hintText: subTitulo,
        labelText: titulo,
        labelStyle: const TextStyle(fontSize: 18.0, color: ConstColor.pinkSD),
      ),
    );
  }
}
