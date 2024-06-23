import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/consts/consts_colors.dart';
import '../bloc/viagem_passageiros/viagem_passageiros_bloc.dart';

class RotasGeradas extends StatefulWidget {
  const RotasGeradas({super.key});

  @override
  State<RotasGeradas> createState() => _RotasGeradasState();
}

class _RotasGeradasState extends State<RotasGeradas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Suas rotas',
          style: TextStyle(color: ConstColor.pinkVS),
        ),
        backgroundColor: ConstColor.pinkDM,
      ),
      body: BlocBuilder<ViagemPassageirosBloc, ViagemPassageirosState>(
        builder: (context, state) {
          if (state is ViagemPassageirosLoading) {
            return const CircularProgressIndicator();
          }
          if (state is ViagemPassageirosRotaGerada) {
            return Container(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: ConstColor.pinkVS, // Cor da borda
                      width: 2.0, // Espessura da borda
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        state.viagemPassageiros?.viagem?.titulo ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 40,
                          color: ConstColor.pinkDM,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Column(
                        children: [
                          TextButton(
                            onPressed: () async {
                              await launchUrl(
                                Uri.parse(state.urlIda),
                                mode: LaunchMode.externalApplication,
                              );
                            },
                            child: const Text(
                              'Rote de ida',
                              style: TextStyle(
                                fontSize: 28,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blue,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: () async {
                              await launchUrl(
                              Uri.parse(state.urlVolta),
                              mode: LaunchMode.externalApplication,
                              );
                            },
                            child: const Text(
                              'Rote de volta',
                              style: TextStyle(
                                fontSize: 28,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blue,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
