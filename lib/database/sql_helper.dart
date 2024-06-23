import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

import '../models/passageiro_model.dart';
import '../models/passageiros_status.dart';
import '../models/viagem_model.dart';

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute('''
    CREATE TABLE viagens (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo TEXT,
    endereco_inicio TEXT,
    endereco_fim TEXT)''');

    await database.execute('''
     CREATE TABLE passageiros (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT,
    telefone TEXT,
    endereco_embarque TEXT,
    endereco_desembarque TEXT
)''');

    await database.execute('''
     CREATE TABLE passageiros_status (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    status INTEGER,
    viagem_id INTEGER,
    passageiro_id INTEGER
)''');
  }

//     await database.execute('''
//      CREATE TABLE passageiros (
//     id INTEGER PRIMARY KEY AUTOINCREMENT,
//     nome TEXT,
//     cpf TEXT,
//     telefone INTEGER,
//     email TEXT,
//     endereco_embarque TEXT,
//     endereco_desembarque TEXT,
//     viagem_id INTEGER,
//     FOREIGN KEY(viagem_id) REFERENCES rotasViagem(id)
// )''');
//   }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'finalApp.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Passageiros ---------------------------------------------------------------

  static Future<int> insertPassageiro(Passageiro passageiro) async {
    final db = await SQLHelper.db();

    return await db.insert('passageiros', passageiro.toMapBD(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Passageiro>> getAllPassageiros() async {
    final db = await SQLHelper.db();
    return Passageiro.fromMapList(await db.query('passageiros', orderBy: 'id'));
  }

  static Future<List<Passageiro>> getPassageirosListByIds(List<int?> ids) async {
    final db = await SQLHelper.db();
    return Passageiro.fromMapList(await db.rawQuery(''
        'SELECT *'
        '  FROM passageiros'
        ' WHERE id IN (${ids.join(',')})'));
  }


  static Future<Passageiro> getPassageiroById(id) async {
    final db = await SQLHelper.db();
    return Passageiro.fromMap((await db.query(
      'passageiros',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    ))
        .first);
  }

  static Future<int> updatePassageiro(Passageiro passageiro) async {
    final db = await SQLHelper.db();
    return await db.update(
      'passageiros',
      passageiro.toMapBD(),
      where: 'id = ?',
      whereArgs: [passageiro.id],
    );
  }

  static Future<void> deletePassageiro(id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete('passageiros', where: 'id = ?', whereArgs: [id]);
    } catch (err) {
      debugPrint("Algo deu errado ao deletar o passageiro: $err");
    }
  }

  // Viagens -------------------------------------------------------------------

  static Future<int> insertViagem(Viagem viagem) async {
    final db = await SQLHelper.db();

    return await db.insert(
      'viagens',
      viagem.toMapBD(),
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Viagem>> getAllViagens() async {
    final db = await SQLHelper.db();
    return Viagem.fromMapList(await db.query('viagens', orderBy: 'id'));
  }

  static Future<Viagem> getViagemById(id) async {
    final db = await SQLHelper.db();
    return Viagem.fromMap((await db.query(
      'viagens',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    ))
        .first);
  }

  static Future<int> updateViagem(Viagem viagem) async {
    final db = await SQLHelper.db();

    return await db.update(
      'viagens',
      viagem.toMapBD(),
      where: 'id = ?',
      whereArgs: [viagem.id],
    );
  }

  static Future<void> deleteViagem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete('viagens', where: 'id = ?', whereArgs: [id]);
    } catch (err) {
      debugPrint("Algo deu errado ao deletar a viagem: $err");
    }
  }

  // Passageiros Status --------------------------------------------------------

  static Future<int> insertPassageirosStatus(
      PassageirosStatus passageiro) async {
    final db = await SQLHelper.db();

    return await db.insert(
      'passageiros_status',
      passageiro.toMapBD(),
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<PassageirosStatus>> getAllPassageirosStatus() async {
    final db = await SQLHelper.db();
    return PassageirosStatus.fromMapList(await db.query(
      'passageiros_status',
      orderBy: 'id',
    ));
  }

  static Future<List<PassageirosStatus>> getPassageirosStatusByViagemId(
    int viagemId,
  ) async {
    final db = await SQLHelper.db();
    return PassageirosStatus.fromMapList(await db.query(
      'passageiros_status',
      where: 'viagem_id = ?',
      whereArgs: [viagemId],
    ));
  }

  static Future<int> updatePassageirosStatus(
    PassageirosStatus passageiro,
  ) async {
    final db = await SQLHelper.db();

    return await db.update(
      'passageiros_status',
      passageiro.toMapBD(),
      where: 'id = ?',
      whereArgs: [passageiro.id],
    );
  }

  static Future<void> deletePassageirosStatus(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete('passageiros_status', where: 'id = ?', whereArgs: [id]);
    } catch (err) {
      debugPrint("Algo deu errado ao deletar a viagem: $err");
    }
  }
}
