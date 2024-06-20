import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute('''
  CREATE TABLE passageiros (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT,
    cpf TEXT,
    telefone INTEGER,
    email TEXT,
    endereco_embarque TEXT,
    endereco_desembarque TEXT
    )''');
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'app.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createPassageiro(String nome, String cpf, int telefone,
      String email, String endEmbarque, String endDesembarque) async {
    final db = await SQLHelper.db();

    final data = {
      'nome': nome,
      'cpf': cpf,
      'telefone': telefone,
      'email': email,
      'endereco_embarque': endEmbarque,
      'endereco_desembarque': endDesembarque
    };

    final id = await db.insert('passageiros', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getPassageiros() async {
    final db = await SQLHelper.db();
    return db.query('passageiros', orderBy: 'id');
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
      String endDesembarque) async {
    final db = await SQLHelper.db();

    final data = {
      'nome': nome,
      'cpf': cpf,
      'telefone': telefone,
      'email': email,
      'endereco_embarque': endEmbarque,
      'endereco_desembarque': endDesembarque
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
}
