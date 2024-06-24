import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/passageiro_model.dart';
import '../../utils/consts/consts_colors.dart';
import '../bloc/passageiros/passageiros_bloc.dart';
import '../bloc/viagem_passageiros/viagem_passageiros_bloc.dart';
import 'cadastro_passageiro.dart';

class ListaPassageirosCadastrados extends StatefulWidget {
  const ListaPassageirosCadastrados({super.key});

  @override
  State<ListaPassageirosCadastrados> createState() =>
      _ListaPassageirosCadastradosState();
}

class _ListaPassageirosCadastradosState
    extends State<ListaPassageirosCadastrados> {
  List<Passageiro> passageiros = [];

  @override
  void initState() {
    BlocProvider.of<PassageirosBloc>(context).add(PassageirosCarregar());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ViagemPassageirosBloc, ViagemPassageirosState>(
      listener: (context, state) {
        if (state is ViagemPassageirosAdd) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Passageiros Cadastrados',
            style: TextStyle(color: ConstColor.pinkVS),
          ),
          backgroundColor: ConstColor.pinkDM,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.person_add,
                color: ConstColor.pinkVS,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CadastroPassageiro()),
                ).then((value) => BlocProvider.of<PassageirosBloc>(context)
                    .add(PassageirosCarregar()));
              },
            )
          ],
        ),
        body: BlocBuilder<PassageirosBloc, PassageirosState>(
          builder: (context, state) {
            if (state is PassageirosLoading) {
              const CircularProgressIndicator();
            } else {
              bool listaVazia = state.listaPassageiros == null ||
                  state.listaPassageiros!.isEmpty;

              return listaVazia
                  ? const Center(
                      child: Text(
                      'Nenhum passageiro\ncadastrado',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: ConstColor.pinkDM,
                        fontWeight: FontWeight.w500,
                      ),
                    ))
                  : ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount:
                          listaVazia ? 0 : state.listaPassageiros?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () => setState(() {
                            if (passageiros
                                .contains(state.listaPassageiros![index])) {
                              passageiros
                                  .remove(state.listaPassageiros![index]);
                            } else {
                              passageiros.add(state.listaPassageiros![index]);
                            }
                          }),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4.0,
                              horizontal: 8.0,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: passageiros.contains(
                                        state.listaPassageiros![index])
                                    ? Colors.green.shade300
                                    : Colors.white, // Cor do container
                                borderRadius: BorderRadius.circular(
                                    10.0), // Arredondar cantos
                                border: Border.all(
                                  color: ConstColor.pinkVS, // Cor da borda
                                  width: 2.0, // Espessura da borda
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.person_outlined,
                                          color: ConstColor.pinkDM,
                                          size: 32,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8),
                                          child: Text(
                                            state.listaPassageiros?[index]
                                                    .nome ??
                                                '',
                                            style: const TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.red, // Cor do container
                                        borderRadius: BorderRadius.circular(
                                          24.0,
                                        ), // Arredondar cantos
                                      ),
                                      child: IconButton(
                                        onPressed: () => BlocProvider.of<
                                                PassageirosBloc>(context)
                                            .add(PassageirosDeletar(
                                                passageiro: state
                                                    .listaPassageiros![index])),
                                        icon: const Icon(
                                          Icons.delete_outline,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
            }
            return const SizedBox();
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            BlocProvider.of<ViagemPassageirosBloc>(context)
                .add(ViagemPassageirosAddPassageiro(
              passageiros: passageiros,
            ));
          },
          backgroundColor: ConstColor.pinkDM,
          label: const Text(
            'Adicionar a Viagem',
            style: TextStyle(color: ConstColor.pinkVS),
          ),
          icon: const Icon(
            Icons.group_add,
            color: ConstColor.pinkVS,
          ),
        ),
      ),
    );
  }
}
