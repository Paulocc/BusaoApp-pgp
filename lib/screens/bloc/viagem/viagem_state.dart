part of 'viagem_bloc.dart';

sealed class ViagemState extends Equatable {
  final List<Viagem>? listaViagens;

  const ViagemState({this.listaViagens});

  @override
  List<Object> get props => [listaViagens ?? []];
}

final class ViagemInitial extends ViagemState {}

final class ViagemLoading extends ViagemState {
  const ViagemLoading({super.listaViagens});
}

final class ViagemLoaded extends ViagemState {
  const ViagemLoaded({super.listaViagens});
}

final class ViagemSave extends ViagemState {
  const ViagemSave({super.listaViagens});
}
