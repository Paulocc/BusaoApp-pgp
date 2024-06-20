import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/viagem_model.dart';

part 'viagem_event.dart';
part 'viagem_state.dart';

class ViagemBloc extends Bloc<ViagemEvent, ViagemState> {
  ViagemBloc() : super(ViagemInitial()) {
    on<ViagemCarregar>((event, emit) {
      emit(ViagemLoading(listaViagens: state.listaViagens));
      //Get do banco de todas as viagens
      List<Viagem> viagensLocal = state.listaViagens ?? [];
      emit(ViagemLoaded(listaViagens: viagensLocal));
    });

    on<ViagemSalvar>((event, emit) {
      emit(ViagemLoading(listaViagens: state.listaViagens));
      //Insert o event.viagem no banco
      List<Viagem> viagens = state.listaViagens ?? [];
      viagens.add(event.viagem);
      emit(ViagemSave(listaViagens: viagens));
    });

    on<ViagemDeletar>((event, emit) {
      emit(ViagemLoading(listaViagens: state.listaViagens));
      List<Viagem> viagens = state.listaViagens ?? [];
      viagens.remove(event.viagem);
      //Delet o event.viagem no banco
      emit(ViagemSave(listaViagens: viagens));
    });
  }
}
