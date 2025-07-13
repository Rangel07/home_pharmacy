import 'package:home_pharmacy/app/data/remedio.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('remedios.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, filePath);
    var db = await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );

    db.execute('''
      DROP TABLE IF EXISTS remedios;
''');
db.execute('''
      CREATE TABLE remedios (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        descricao TEXT NOT NULL,
        quantidade INTEGER NOT NULL,
        medida TEXT DEFAULT 'capsulas',
        data_validade INTEGER
      )
    ''');
    return db;
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE remedios (
        id $idType,
        nome $textType,
        descricao $textType,
        quantidade INTEGER NOT NULL,
        medida TEXT NOT NULL DEFAULT 'capsulas',
        data_validade INTEGER
      )
    ''');
  }

  // CRUD

  Future<int> createRemedio(Remedio remedio) async {
    final db = await instance.database;
    return await db.insert('remedios', remedio.toMap());
  }

  Future<Remedio?> readRemedio(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      'remedios',
      columns: ['id', 'nome', 'descricao', 'quantidade', 'data_validade'],	
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Remedio.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Remedio>> readAllRemedios() async {
    final db = await instance.database;
    final result = await db.query('remedios');
    return result.map((json) => Remedio.fromMap(json)).toList();
  }

  Future<int> updateRemedio(Remedio remedio) async {
    final db = await instance.database;
    return await db.update(
      'remedios',
      remedio.toMap(),
      where: 'id = ?',
      whereArgs: [remedio.id],
    );
  }

  Future<int> deleteRemedio(int id) async {
    final db = await instance.database;
    return await db.delete(
      'remedios',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
