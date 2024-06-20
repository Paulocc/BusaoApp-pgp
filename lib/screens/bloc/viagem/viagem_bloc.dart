import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/viagem_model.dart';

part 'viagem_event.dart';
part 'viagem_state.dart';

class ViagemBloc extends Bloc<ViagemEvent, ViagemState> {
  ViagemBloc() : super(ViagemInitial()) {
    on<ViagemCarregar>((event, emit) {
      print('ViagemCarregar');
      emit(ViagemLoading(listaViagens: state.listaViagens));
      //Carrega viagens da memoria
      List<Viagem> viagensLocal = state.listaViagens ?? [];
      print(viagensLocal);
      emit(ViagemLoaded(listaViagens: viagensLocal));
    });
    on<ViagemSalvar>((event, emit) {
      print('ViagemSalvar');
      emit(ViagemLoading(listaViagens: state.listaViagens));
      List<Viagem> viagens = state.listaViagens ?? [];
      viagens.add(event.viagem);
      print(viagens);
      emit(ViagemSave(listaViagens: viagens));
    });
  }
}
