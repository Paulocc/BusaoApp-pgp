import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  //construtor com acesso privado, pra só uma instancia poder ser criada
  DB._();
  //criar instancia de DB
  static final DB instance = DB._();
  //Instancia de SQLite
  static Database? _database;

  get database async {
    if (_database != null) return _database;

    return await _initDatabase();
  }
}

_initDatabase() async {
  return await openDatabase(
    join(await getDatabasesPath(), 'giuseApp.db'),
    version: 1,
    onCreate: _onCreate,
  );
}

_onCreate(db, versao) async {
  await db.execute(_passageiros);
  await db.execute(_motoristas);
  await db.execute(_rotasViagem);
  await db.execute(_viagensAgendadas);
}

String get _passageiros => '''
  CREATE TABLE passageiros (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT,
    cpf TEXT,
    telefone INTEGER,
    email TEXT,
    endereco_embarque_latitude TEXT,
    endereco_embarque_longitude TEXT,
    endereco_desembarque_latitude TEXT,
    endereco_desembarque_longitude TEXT

  )''';

String get _motoristas => '''
  CREATE TABLE motoristas (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_motorista TEXT,
    cpf_motorista TEXT,
    telefone INTEGER,
    email TEXT,
    cnh TEXT  
  )''';

String get _rotasViagem => '''
  CREATE TABLE rotasViagem (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_viagem TEXT,
    endereco_inicio_latitude TEXT,
    endereco_inicio_longitude TEXT,
    endereco_fim_latitude TEXT,
    endereco_fim_longitude TEXT,
    horario_inico DATE,
    horario_final DATE,
    horario_disparo DATE,
    motorista_id INTEGER,
    FOREIGN KEY(motorista_id) REFERENCES motoristas(id)
  )''';

String get _viagensAgendadas => '''
  CREATE TABLE viagens (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_rotaViagem INTEGER,
    id_passageiro INTEGER,
    FOREIGN KEY(id_rotaViagem) REFERENCES rotasViagem(id),
    FOREIGN KEY(id_passageiro) REFERENCES passageiros(id)
  )''';
