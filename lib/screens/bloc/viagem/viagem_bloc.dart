import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../database/sql_helper.dart';
import '../../../models/viagem_model.dart';

part 'viagem_event.dart';

part 'viagem_state.dart';

class ViagemBloc extends Bloc<ViagemEvent, ViagemState> {
  ViagemBloc() : super(ViagemInitial()) {
    on<ViagemCarregar>((event, emit) async {
      emit(ViagemLoading(listaViagens: state.listaViagens));
      emit(ViagemLoaded(listaViagens: await SQLHelper.getAllViagens()));
    });

    on<ViagemSalvar>((event, emit) async {
      emit(ViagemLoading(listaViagens: state.listaViagens));

      await SQLHelper.insertViagem(event.viagem);

      emit(ViagemSave(listaViagens: await SQLHelper.getAllViagens()));
    });

    on<ViagemDeletar>((event, emit) async {
      emit(ViagemLoading(listaViagens: state.listaViagens));

      await SQLHelper.deleteViagem(event.viagem.id ?? 0);

      emit(ViagemDelete(listaViagens: await SQLHelper.getAllViagens()));
    });
  }
}
