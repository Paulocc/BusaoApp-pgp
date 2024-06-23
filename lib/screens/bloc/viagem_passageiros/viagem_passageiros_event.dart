part of 'viagem_passageiros_bloc.dart';

sealed class ViagemPassageirosEvent  extends Equatable {
  const ViagemPassageirosEvent();

  @override
  List<Object> get props => [];
}

class ViagemPassageirosCarregar extends ViagemPassageirosEvent{
  final int viagemId;

  const ViagemPassageirosCarregar({required this.viagemId});
}

class ViagemPassageirosAddPassageiro extends ViagemPassageirosEvent{
  final Passageiro passageiro;

  const ViagemPassageirosAddPassageiro({required this.passageiro});
}

class ViagemPassageirosUpadateStatus extends ViagemPassageirosEvent{
  final PassageirosStatus passageirosStatus;

  const ViagemPassageirosUpadateStatus({required this.passageirosStatus});
}
