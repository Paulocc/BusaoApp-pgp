import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/consts/consts_colors.dart';
import 'text_form_field_padrao.dart';

class ContainerEndereco extends StatefulWidget {
  const ContainerEndereco({
    super.key,
    required this.titulo,
    required this.onChanged,
    required this.numeroController,
    required this.logradouroController,
    required this.bairroController,
    required this.cidadeController,
  });

  final String titulo;
  final Function(String) onChanged;
  final TextEditingController numeroController;
  final TextEditingController logradouroController;
  final TextEditingController bairroController;
  final TextEditingController cidadeController;

  @override
  State<ContainerEndereco> createState() => _ContainerEnderecoState();
}

class _ContainerEnderecoState extends State<ContainerEndereco> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: ConstColor.pinkSD,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              widget.titulo,
              style: const TextStyle(
                fontSize: 20.0,
                color: ConstColor.pinkSD,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 200,
                  child: TextFormFieldPadrao(
                    titulo: 'CEP',
                    subTitulo: 'Digite o CEP..',
                    onChanged: widget.onChanged,
                    textInputType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(8),
                      CepInputFormatter(),
                    ],
                  ),
                ),
                SizedBox(
                  width: 130,
                  child: TextFormFieldPadrao(
                    titulo: 'Número',
                    subTitulo: 'Número..',
                    controller: widget.numeroController,
                    textInputType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: TextFormFieldPadrao(
                titulo: 'Logradouro',
                enabled: false,
                controller: widget.logradouroController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 160,
                    child: TextFormFieldPadrao(
                      titulo: 'Bairro',
                      enabled: false,
                      controller: widget.bairroController,
                    ),
                  ),
                  SizedBox(
                    width: 160,
                    child: TextFormFieldPadrao(
                      titulo: 'Cidade',
                      enabled: false,
                      controller: widget.cidadeController,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
