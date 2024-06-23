import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/bloc/passageiros/passageiros_bloc.dart';
import 'screens/bloc/viagem/viagem_bloc.dart';
import 'screens/bloc/viagem_passageiros/viagem_passageiros_bloc.dart';
import 'screens/pages/cadastro_passageiro.dart';
import 'screens/pages/cadastro_viagens.dart';
import 'screens/pages/lista_passageiros_cadastrados.dart';
import 'screens/pages/lista_passageiros_viagem.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: ViagemBloc()),
        BlocProvider.value(value: PassageirosBloc()),
        BlocProvider.value(value: ViagemPassageirosBloc()),
      ],
      child: MaterialApp(
        title: 'GiuseApp',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: ConstColor.pinkDM),
          useMaterial3: true,
        ),
        initialRoute: Routes.listaViagens.valor,
        routes: {
          Routes.cadastroPassageiro.valor: (context) =>
              const CadastroPassageiro(),
          Routes.cadastroViagens.valor: (context) => const CadastroViagens(),
          Routes.listaPassageirosViagem.valor: (context) =>
              const ListaPassageirosViagem(vistoriaId: 0),
          Routes.listaPassageirosCadastrados.valor: (context) =>
              const ListaPassageirosCadastrados(),
          Routes.listaViagens.valor: (context) => const ListaViagens(),
        },
      ),
    );
  }
}
