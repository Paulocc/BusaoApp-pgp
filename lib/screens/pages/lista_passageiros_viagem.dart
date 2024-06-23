import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/passageiro_model.dart';
import '../../models/passageiros_status.dart';
import '../../utils/consts/consts_colors.dart';
import '../bloc/viagem_passageiros/viagem_passageiros_bloc.dart';
import 'lista_passageiros_cadastrados.dart';

class ListaPassageirosViagem extends StatefulWidget {
  const ListaPassageirosViagem({super.key, required this.vistoriaId});

  final int vistoriaId;

  @override
  State<ListaPassageirosViagem> createState() => _ListaPassageirosViagemState();
}

class _ListaPassageirosViagemState extends State<ListaPassageirosViagem> {
  @override
  void initState() {
    BlocProvider.of<ViagemPassageirosBloc>(context)
        .add(ViagemPassageirosCarregar(
      viagemId: widget.vistoriaId,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista de passageiros',
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
                    builder: (context) => const ListaPassageirosCadastrados()),
              ).then((value) =>
                  BlocProvider.of<ViagemPassageirosBloc>(context).add(
                    ViagemPassageirosCarregar(viagemId: widget.vistoriaId),
                  ));
            },
          )
        ],
      ),
      body: BlocBuilder<ViagemPassageirosBloc, ViagemPassageirosState>(
        builder: (context, state) {
          if (state is ViagemPassageirosLoading) {
            const CircularProgressIndicator();
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: state.viagemPassageiros != null &&
                      state.viagemPassageiros?.listaPassageirosStatus != null
                  ? state.viagemPassageiros?.listaPassageirosStatus?.length
                  : 0,
              itemBuilder: (BuildContext context, int index) {
                PassageirosStatus pasStatus =
                    state.viagemPassageiros?.listaPassageirosStatus![index] ??
                        PassageirosStatus();
                Passageiro passageiro =
                    state.viagemPassageiros?.listaPassageiros?[index] ??
                        Passageiro();

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 8.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Cor do container
                      borderRadius:
                          BorderRadius.circular(10.0), // Arredondar cantos
                      border: Border.all(
                        color: ConstColor.pinkVS, // Cor da borda
                        width: 2.0, // Espessura da borda
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: InkWell(
                        onTap: () =>
                            BlocProvider.of<ViagemPassageirosBloc>(context)
                                .add(ViagemPassageirosUpadateStatus(
                          passageirosStatus: pasStatus,
                        )),
                        child: Row(
                          children: [
                            pasStatus.status == 1
                                ? const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 32,
                                  )
                                : const Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                    size: 32,
                                  ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                passageiro.nome ?? '',
                                style: const TextStyle(
                                  fontSize: 18,
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
        onPressed: () {},
        label: const Text('Gerar rota'),
        icon: const Icon(Icons.route),
      ),
    );
  }
}
