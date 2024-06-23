import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  @override
  void initState() {
    BlocProvider.of<PassageirosBloc>(context).add(PassageirosCarregar());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ViagemPassageirosBloc, ViagemPassageirosState>(
      listener: (context, state) {
        if(state is ViagemPassageirosAdd){
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
        ),
        body: BlocBuilder<PassageirosBloc, PassageirosState>(
          builder: (context, state) {
            if (state is PassageirosLoading) {
              const CircularProgressIndicator();
            } else {
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: state.listaPassageiros != null
                    ? state.listaPassageiros?.length
                    : 0,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () => BlocProvider.of<ViagemPassageirosBloc>(context)
                        .add(ViagemPassageirosAddPassageiro(
                      passageiro: state.listaPassageiros![index],
                    )),
                    child: Padding(
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.person,
                                    color: Colors.black26,
                                    size: 32,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text(
                                      state.listaPassageiros?[index].nome ?? '',
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                onPressed: () =>
                                    BlocProvider.of<PassageirosBloc>(context)
                                        .add(PassageirosDeletar(
                                            passageiro: state
                                                .listaPassageiros![index])),
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 32,
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
              MaterialPageRoute(
                  builder: (context) => const CadastroPassageiro()),
            ).then((value) => BlocProvider.of<PassageirosBloc>(context)
                .add(PassageirosCarregar()));
          },
          label: const Text('Passageiro'),
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }
}
