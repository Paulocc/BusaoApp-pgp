part of 'passageiros_bloc.dart';

sealed class PassageirosState extends Equatable {
  final List<Passageiro>? listaPassageiros;

  const PassageirosState({this.listaPassageiros});

  @override
  List<Object> get props => [listaPassageiros ?? []];
}

final class PassageirosInitial extends PassageirosState {}

final class PassageirosLoading extends PassageirosState {
  const PassageirosLoading({super.listaPassageiros});
}

final class PassageirosLoaded extends PassageirosState {
  const PassageirosLoaded({super.listaPassageiros});
}

final class PassageirosSave extends PassageirosState {
  const PassageirosSave({super.listaPassageiros});
}

final class PassageirosDelete extends PassageirosState {
  const PassageirosDelete({super.listaPassageiros});
}
