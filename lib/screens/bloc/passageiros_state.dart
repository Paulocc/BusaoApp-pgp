part of 'passageiros_cubit.dart';

sealed class PassageirosState {}

final class PassageirosInitial extends PassageirosState {}

final class PassageirosSave extends PassageirosState {
  final List<String> listaPassageiros;

  PassageirosSave(this.listaPassageiros);
}
