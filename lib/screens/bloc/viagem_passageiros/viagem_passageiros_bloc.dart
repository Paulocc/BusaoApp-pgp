import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../database/sql_helper.dart';
import '../../../models/passageiro_model.dart';
import '../../../models/passageiros_status.dart';
import '../../../models/viagem_model.dart';
import '../../../models/viagem_passageiros.dart';

part 'viagem_passageiros_event.dart';

part 'viagem_passageiros_state.dart';

class ViagemPassageirosBloc
    extends Bloc<ViagemPassageirosEvent, ViagemPassageirosState> {
  ViagemPassageirosBloc() : super(ViagemPassageirosInitial()) {
    on<ViagemPassageirosCarregar>((event, emit) async {
      emit(ViagemPassageirosLoading(
        viagemPassageiros: state.viagemPassageiros,
      ));

      emit(ViagemPassageirosLoaded(
        viagemPassageiros: await _getViagemPassageiros(event.viagemId),
      ));
    });

    on<ViagemPassageirosAddPassageiro>((event, emit) async {
      emit(ViagemPassageirosLoading(
        viagemPassageiros: state.viagemPassageiros,
      ));

      int viagemId = state.viagemPassageiros?.viagem?.id ?? 0;

      await SQLHelper.insertPassageirosStatus(PassageirosStatus(
          status: 0, viagemId: viagemId, passageiroId: event.passageiro.id));

      emit(ViagemPassageirosAdd(
        viagemPassageiros: await _getViagemPassageiros(viagemId),
      ));
    });

    on<ViagemPassageirosUpadateStatus>((event, emit) async {
      emit(ViagemPassageirosLoading(
        viagemPassageiros: state.viagemPassageiros,
      ));

      PassageirosStatus passageiro = event.passageirosStatus;
      passageiro.status = passageiro.status == 1 ? 2 : 1;

      await SQLHelper.updatePassageirosStatus(passageiro);

      emit(ViagemPassageirosAdd(
        viagemPassageiros: await _getViagemPassageiros(
          passageiro.viagemId ?? 0,
        ),
      ));
    });
  }

  Future<ViagemPassageiros> _getViagemPassageiros(int viagemId) async {
    List<PassageirosStatus> listaPassageirosStatus =
        await SQLHelper.getPassageirosStatusByViagemId(viagemId);

    List<int?> passageiroIds = listaPassageirosStatus
        .map((passageiro) => passageiro.passageiroId)
        .toList();

    List<Passageiro> listaPassageiros = passageiroIds.isNotEmpty
        ? await SQLHelper.getPassageirosListByIds(passageiroIds)
        : [];

    Viagem viagem = await SQLHelper.getViagemById(viagemId);

    return ViagemPassageiros(
      viagem: viagem,
      listaPassageiros: listaPassageiros,
      listaPassageirosStatus: listaPassageirosStatus,
    );
  }
}
