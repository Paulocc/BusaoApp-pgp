part of 'viagem_passageiros_bloc.dart';

sealed class ViagemPassageirosState extends Equatable {
  final ViagemPassageiros? viagemPassageiros;

  const ViagemPassageirosState({this.viagemPassageiros});

  @override
  List<Object> get props => [viagemPassageiros ?? []];
}

final class ViagemPassageirosInitial extends ViagemPassageirosState {}

final class ViagemPassageirosLoading extends ViagemPassageirosState {
  const ViagemPassageirosLoading({super.viagemPassageiros});
}

final class ViagemPassageirosLoaded extends ViagemPassageirosState {
  const ViagemPassageirosLoaded({super.viagemPassageiros});
}

final class ViagemPassageirosAdd extends ViagemPassageirosState {
  const ViagemPassageirosAdd({super.viagemPassageiros});
}

final class ViagemPassageirosRotaGerada extends ViagemPassageirosState {
  final String urlIda;
  final String urlVolta;

  const ViagemPassageirosRotaGerada(
      {super.viagemPassageiros, required this.urlIda, required this.urlVolta});
}
