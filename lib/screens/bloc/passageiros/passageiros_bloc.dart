import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../database/sql_helper.dart';
import '../../../models/passageiro_model.dart';

part 'passageiros_event.dart';

part 'passageiros_state.dart';

class PassageirosBloc extends Bloc<PassageirosEvent, PassageirosState> {
  PassageirosBloc() : super(PassageirosInitial()) {
    on<PassageirosCarregar>((event, emit) async {
      emit(PassageirosLoading(listaPassageiros: state.listaPassageiros));
      emit(PassageirosLoaded(
          listaPassageiros: await SQLHelper.getAllPassageiros()));
    });

    on<PassageirosSalvar>((event, emit) async {
      emit(PassageirosLoading(listaPassageiros: state.listaPassageiros));

      await SQLHelper.insertPassageiro(event.passageiro);

      emit(PassageirosSave(listaPassageiros: await SQLHelper.getAllPassageiros()));
    });

    on<PassageirosDeletar>((event, emit) async {
      emit(PassageirosLoading(listaPassageiros: state.listaPassageiros));

      await SQLHelper.deletePassageiro(event.passageiro.id ?? 0);

      emit(PassageirosDelete(
          listaPassageiros: await SQLHelper.getAllPassageiros()));
    });
  }
}
