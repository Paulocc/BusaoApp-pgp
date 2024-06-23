import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/consts/consts_colors.dart';
import '../bloc/viagem/viagem_bloc.dart';
import 'cadastro_viagens.dart';
import 'lista_passageiros_viagem.dart';

class ListaViagens extends StatefulWidget {
  const ListaViagens({super.key});

  @override
  State<ListaViagens> createState() => _ListaViagensState();
}

class _ListaViagensState extends State<ListaViagens> {
  @override
  void initState() {
    BlocProvider.of<ViagemBloc>(context).add(ViagemCarregar());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Viagens',
          style: TextStyle(
            color: ConstColor.pinkVS,
          ),
        ),
        backgroundColor: ConstColor.pinkDM,
      ),
      body: BlocBuilder<ViagemBloc, ViagemState>(
        builder: (context, state) {
          if (state is ViagemLoading) {
            const CircularProgressIndicator();
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount:
                  state.listaViagens != null ? state.listaViagens?.length : 0,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListaPassageirosViagem(
                              vistoriaId: state.listaViagens?[index].id ?? 0,
                            )),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 8.0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white, // Cor do containLer
                        borderRadius:
                            BorderRadius.circular(10.0), // Arredondar cantos
                        border: Border.all(
                          color: ConstColor.pinkVS, // Cor da borda
                          width: 2.0, // Espessura da borda
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 10,
                                  decoration: BoxDecoration(
                                    color: Colors.green, // Cor do container
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Text(
                                      state.listaViagens?[index].titulo ?? ''),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () =>
                                  BlocProvider.of<ViagemBloc>(context).add(
                                      ViagemDeletar(
                                          viagem: state.listaViagens![index])),
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CadastroViagens()),
          ).then((value) =>
              BlocProvider.of<ViagemBloc>(context).add(ViagemCarregar()));
        },
        label: const Text('Nova Viagem'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
