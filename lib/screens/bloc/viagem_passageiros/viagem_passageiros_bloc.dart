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

      if (event.passageiros.isNotEmpty) {
        for (Passageiro pas in event.passageiros) {
          await SQLHelper.insertPassageirosStatus(PassageirosStatus(
              status: 0, viagemId: viagemId, passageiroId: pas.id));
        }
      }

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

    on<ViagemPassageirosGeraRotas>((event, emit) async {
      emit(ViagemPassageirosLoading(
        viagemPassageiros: state.viagemPassageiros,
      ));

      String url = 'https://www.google.com/maps/dir';

      String enderecosPassageirosIda = '';
      String enderecosPassageirosVolta = '';

      if (state.viagemPassageiros!.listaPassageirosStatus != null &&
          state.viagemPassageiros!.listaPassageirosStatus!.isNotEmpty &&
          state.viagemPassageiros!.listaPassageiros != null &&
          state.viagemPassageiros!.listaPassageiros!.isNotEmpty) {
        List<PassageirosStatus> listaPassageirosConfirmados = state
            .viagemPassageiros!.listaPassageirosStatus!
            .where((el) => el.status == 1)
            .toList();

        List<Passageiro> passageiros = [];

        for (PassageirosStatus pasStatus in listaPassageirosConfirmados) {
          Passageiro passageiro = state.viagemPassageiros!.listaPassageiros!
              .firstWhere((el) => el.id == pasStatus.passageiroId);
          passageiros.add(passageiro);
        }

        for(Passageiro pas in passageiros){
          enderecosPassageirosIda += '${pas.enderecoEmbarque!.toStringByMapGoogle()}/';
          enderecosPassageirosVolta += '${pas.enderecoDesembarque!.toStringByMapGoogle()}/';
        }
      }

      String urlIda = '$url/'
          '${state.viagemPassageiros!.viagem!.enderecoSaida!.toStringByMapGoogle()}/'
          '${enderecosPassageirosIda != '' ? enderecosPassageirosIda : ''}'
          '${state.viagemPassageiros!.viagem!.enderecoRetorno!.toStringByMapGoogle()}/';

      String urlVolta = '$url/'
          '${state.viagemPassageiros!.viagem!.enderecoRetorno!.toStringByMapGoogle()}/'
          '${enderecosPassageirosVolta != '' ? enderecosPassageirosVolta : ''}'
          '${state.viagemPassageiros!.viagem!.enderecoSaida!.toStringByMapGoogle()}/';

      emit(ViagemPassageirosRotaGerada(
        urlIda: urlIda,
        urlVolta: urlVolta,
        viagemPassageiros: state.viagemPassageiros,
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
