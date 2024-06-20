part of 'viagem_bloc.dart';

sealed class ViagemEvent extends Equatable {
  const ViagemEvent();

  @override
  List<Object> get props => [];
}

class ViagemSalvar extends ViagemEvent{
  final Viagem viagem;

  const ViagemSalvar({required this.viagem});
}

class ViagemCarregar extends ViagemEvent{}
