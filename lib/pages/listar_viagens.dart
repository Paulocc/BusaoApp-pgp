import 'package:flutter/material.dart';

class ListarViagem extends StatefulWidget {
  const ListarViagem({super.key, required this.title});

  final String title;

  @override
  State<ListarViagem> createState() => _ListarViagemState();
}

class _ListarViagemState extends State<ListarViagem> {
  void _salvar() {
    print('Se apareceu no vscode é sucesso');
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
          itemCount: 40, //aqui vai o número de viagens
          itemBuilder: (BuildContext context, int index) {
            return ElevatedButton(
              onPressed: _salvar,
              child: Text('trip muito loca'),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
        },
        label: const Text('Nova Viagem'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
