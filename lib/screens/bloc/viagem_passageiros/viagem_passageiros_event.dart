part of 'viagem_passageiros_bloc.dart';

sealed class ViagemPassageirosEvent extends Equatable {
  const ViagemPassageirosEvent();

  @override
  List<Object> get props => [];
}

class ViagemPassageirosCarregar extends ViagemPassageirosEvent {
  final int viagemId;

  const ViagemPassageirosCarregar({required this.viagemId});
}

class ViagemPassageirosAddPassageiro extends ViagemPassageirosEvent {
  final List<Passageiro> passageiros;

  const ViagemPassageirosAddPassageiro({required this.passageiros});
}

class ViagemPassageirosUpadateStatus extends ViagemPassageirosEvent {
  final PassageirosStatus passageirosStatus;

  const ViagemPassageirosUpadateStatus({required this.passageirosStatus});
}

class ViagemPassageirosGeraRotas extends ViagemPassageirosEvent {}
