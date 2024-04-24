import 'package:flutter/material.dart';

int a = 0;

class ListarViagem extends StatefulWidget {
  const ListarViagem({super.key, required this.title});

  final String title;

  @override
  State<ListarViagem> createState() => _ListarViagemState();
}

class _ListarViagemState extends State<ListarViagem> {
  late List<int> listaItens = [];

  void _salvar() {
    print('Se apareceu funcionou, até rimou');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: listaItens.length, //aqui vai o número de viagens
          itemBuilder: (BuildContext context, int index) {
            return ElevatedButton(
              onPressed: _salvar,
              child: Text('Viagem ${listaItens[index]}'),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
          setState(() {
            a++;
            listaItens.add(a);
          });
        },
        label: const Text('Nova Viageem'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
