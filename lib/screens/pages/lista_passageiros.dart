import 'package:flutter/material.dart';
import 'package:giuse_app/database/sql_helper.dart';

import '../../utils/consts/consts_colors.dart';
import '../bloc/passageiros/passageiros_cubit.dart';
import 'cadastro_passageiro.dart';

class ListaPassageiros extends StatefulWidget {
  const ListaPassageiros({super.key});

  @override
  State<ListaPassageiros> createState() => _ListaPassageirosState();
}

class _ListaPassageirosState extends State<ListaPassageiros> {
  List<Map<String, dynamic>> listaPassageiros = [];
  int cont = 0;

  bool isLoading = true;

  void refreshPassageiros() async {
    final data = await SQLHelper.getPassageiros(1);
    setState(() {
      listaPassageiros = data;
      isLoading = false;
    });
  }

  late final PassageirosCubit _cubitPassageiros;

  @override
  initState() {
    super.initState();
    refreshPassageiros();
    _cubitPassageiros = PassageirosCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Passageiros',
          style: TextStyle(color: ConstColor.pinkVS),
        ),
        backgroundColor: ConstColor.pinkDM,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: listaPassageiros.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {},
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
                    children: [
                      Container(
                        height: 50,
                        width: 10,
                        decoration: BoxDecoration(
                          color: Colors.green, // Cor do container
                          borderRadius:
                              BorderRadius.circular(10.0), // Arredondar cantos
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(listaPassageiros[index]['nome']),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CadastroPassageiro()),
          ).then((value) => setState(() {
                cont++;
                //listaViagens.add('teste $cont');
              }));
        },
        label: const Text('Passageiro'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
