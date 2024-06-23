import 'package:giuse_app/models/passageiro_model.dart';

import 'passageiros_status.dart';
import 'viagem_model.dart';

class ViagemPassageiros {
  Viagem? viagem;
  List<Passageiro>? listaPassageiros;
  List<PassageirosStatus>? listaPassageirosStatus;

  ViagemPassageiros({
    this.viagem,
    this.listaPassageiros,
    this.listaPassageirosStatus,
  });

  @override
  String toString() {
    return "ViagemPassageiros"
        "{ viagem: $viagem"
        ", listaPassageiros: $listaPassageiros"
        ", listaPassageirosStatus: $listaPassageirosStatus"
        "}";
  }
}
