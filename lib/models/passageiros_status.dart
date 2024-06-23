
class PassageirosStatus {
  int? id;
  int? status;
  int? viagemId;
  int? passageiroId;

  PassageirosStatus({
    this.id,
    this.status,
    this.viagemId,
    this.passageiroId,
  });

  Map<String, dynamic> toMapBD() {
    return {
      'status': status,
      'viagem_id': viagemId,
      'passageiro_id': passageiroId,
    };
  }

  factory PassageirosStatus.fromMap(Map<String, dynamic> map) {
    return PassageirosStatus(
      id: map['id'],
      status: map['status'],
      viagemId: map['viagem_id'],
      passageiroId: map['passageiro_id'],
    );
  }

  static List<PassageirosStatus> fromMapList(List<Map<String, dynamic>> mapList) {
    return mapList.map((map) => PassageirosStatus.fromMap(map)).toList();
  }

  @override
  String toString() {
    return "PassageirosStatus"
        "{ Id: $id"
        ", status: $status"
        ", viagemId: $viagemId"
        ", passageiroId: $passageiroId"
        "}";
  }
}
