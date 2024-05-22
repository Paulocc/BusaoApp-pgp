import 'package:flutter/material.dart';
import 'package:giuse_app/database/db.dart';
import 'package:giuse_app/models/posicao.dart';
import 'package:sqflite/sqflite.dart';

class PassageiroRepository extends ChangeNotifier {
  late Database db;
  List<Posicao> _passageiros = [];

  List<Posicao> get passageiros => _passageiros;

  PassageiroRepository() {
    _initRepository();
  }

  _initRepository() async {
    await _getPassageiro();
  }

  _getPassageiro() async {
    db = await DB.instance.database;
    List passageiros = await db.query('passageiros');
    notifyListeners();
  }

  _setPassageiro(String cpf, String nome) async {
    db = await DB.instance.database;
    db.update('conta', {
      'cpf': cpf,
      'nome': nome,
    });

    notifyListeners();
  }
}
