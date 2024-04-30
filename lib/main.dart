import 'package:flutter/material.dart';

import 'screens/pages/cadastro_passageiro.dart';
import 'screens/pages/cadastro_viagens.dart';
import 'screens/pages/lista_viagens.dart';
import 'utils/consts/consts_colors.dart';
import 'utils/enums/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var routes;
    return MaterialApp(
      title: 'GiuseApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ConstColor.pinkDM),
        useMaterial3: true,
      ),
      initialRoute: Routes.listaViagens.valor,
      routes: {
        Routes.cadastroPassageiro.valor: (context) => const CadastroPassageiro(),
        Routes.cadastroViagens.valor: (context) => const CadastroViagens(),
        Routes.listaViagens.valor: (context) => const ListaViagens(),
      }, 

    );
  }
}
