part of 'passageiros_bloc.dart';

sealed class PassageirosEvent extends Equatable {
  const PassageirosEvent();

  @override
  List<Object> get props => [];
}

class PassageirosSalvar extends PassageirosEvent{
  final Passageiro passageiro;

  const PassageirosSalvar({required this.passageiro});
}

class PassageirosCarregar extends PassageirosEvent{}

class PassageirosDeletar extends PassageirosEvent{
  final Passageiro passageiro;

  const PassageirosDeletar({required this.passageiro});
}
