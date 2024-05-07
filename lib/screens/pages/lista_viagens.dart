import 'package:flutter/material.dart';

import '../../utils/consts/consts_colors.dart';
import 'cadastro_viagens.dart';
import 'lista_passageiros.dart';

class ListaViagens extends StatefulWidget {
  const ListaViagens({super.key});

  @override
  State<ListaViagens> createState() => _ListaViagensState();
}

class _ListaViagensState extends State<ListaViagens> {
  List<int> listaViagens = [];
  int cont = 0;

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
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: listaViagens.length, //aqui vai o número de viagens
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ListaPassageiros()),
          ),
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
                        child: Text('trip $index'),
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
            MaterialPageRoute(builder: (context) => const CadastroViagens()),
          ).then((value) => setState(() {
            cont++;
            listaViagens.add(cont);
          }));
        },
        label: const Text('Nova Viagem'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
