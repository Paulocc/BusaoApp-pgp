import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute('''
    CREATE TABLE viagens (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT,
    endereco_inicio TEXT,
    endereco_fim TEXT)''');

    await database.execute('''
     CREATE TABLE passageiros (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT,
    cpf TEXT,
    telefone INTEGER,
    email TEXT,
    endereco_embarque TEXT,
    endereco_desembarque TEXT,
    viagem_id INTEGER,
    FOREIGN KEY(viagem_id) REFERENCES rotasViagem(id)
)''');
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'finalApp.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createPassageiro(
      String nome,
      String cpf,
      int telefone,
      String email,
      String endEmbarque,
      String endDesembarque,
      int idViagem) async {
    final db = await SQLHelper.db();

    final data = {
      'nome': nome,
      'cpf': cpf,
      'telefone': telefone,
      'email': email,
      'endereco_embarque': endEmbarque,
      'endereco_desembarque': endDesembarque,
      'viagem_id': idViagem,
    };

    final id = await db.insert('passageiros', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getPassageiros(idViagem) async {
    final db = await SQLHelper.db();
    return db.query('passageiros',
        where: 'viagem_id = ?', whereArgs: [idViagem], orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getPassageiro(id) async {
    final db = await SQLHelper.db();
    return db.query('passageiros', where: 'id = ?', whereArgs: [id], limit: 1);
  }

  static Future<int> updatePassageiro(
      int id,
      String nome,
      String cpf,
      int telefone,
      String email,
      String endEmbarque,
      String endDesembarque,
      int idViagem) async {
    final db = await SQLHelper.db();

    final data = {
      'nome': nome,
      'cpf': cpf,
      'telefone': telefone,
      'email': email,
      'endereco_embarque': endEmbarque,
      'endereco_desembarque': endDesembarque,
      'viagem_id': idViagem,
    };

    final result =
        await db.update('passageiros', data, where: 'id = ?', whereArgs: [id]);
    return result;
  }

  static Future<void> deletePassageiro(id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete('passageiros', where: 'id = ?', whereArgs: [id]);
    } catch (err) {
      debugPrint("Algo deu errado ao deletar o passageiro: $err");
    }
  }

  //apartir daqui viagens

  static Future<int> createViagem(
      String nome, String endInicio, String endFinal) async {
    final db = await SQLHelper.db();

    final data = {
      'nome': nome,
      'endereco_inicio': endInicio,
      'endereco_fim': endFinal,
    };

    final id = await db.insert('viagens', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getViagens() async {
    final db = await SQLHelper.db();
    return db.query('viagens', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getViagem(id) async {
    final db = await SQLHelper.db();
    return db.query('viagens', where: 'id = ?', whereArgs: [id], limit: 1);
  }

  static Future<int> updateViagem(
      String nome, String endInicio, String endFinal, int id) async {
    final db = await SQLHelper.db();

    final data = {
      'nome': nome,
      'endereco_inicio': endInicio,
      'endereco_fim': endFinal,
    };

    final result =
        await db.update('viagens', data, where: 'id = ?', whereArgs: [id]);
    return result;
  }

  static Future<void> deleteViagem(id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete('viagens', where: 'id = ?', whereArgs: [id]);
    } catch (err) {
      debugPrint("Algo deu errado ao deletar a viagem: $err");
    }
  }
}
