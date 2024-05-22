import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giuse_app/repositories/passageiro_repository.dart';
import 'package:provider/provider.dart';

import 'screens/bloc/passageiros_cubit.dart';
import 'screens/pages/cadastro_passageiro.dart';
import 'screens/pages/cadastro_viagens.dart';
import 'screens/pages/lista_passageiros.dart';
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
        BlocProvider(create: (context) => PassageirosCubit()),
        ChangeNotifierProvider(create: (context) => PassageiroRepository()),
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
          Routes.listaPassageiros.valor: (context) => const ListaPassageiros(),
          Routes.listaViagens.valor: (context) => const ListaViagens(),
        },
      ),
    );
  }
}
