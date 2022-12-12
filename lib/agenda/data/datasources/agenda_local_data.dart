import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../models/agenda_model.dart';
import 'package:sqflite/sqflite.dart';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

abstract class AgendaLocalDataSource {
  Future<Database> initDB();
  Future<List<AgendaModel>> getAllAgenda(String fecha);
  Future<int> newAgenda(AgendaModel triviaToCache);
  Future<int> deleteAllAgenda();
  Future<int> deleteAgenda(int index);
}

class AgendaLocalDataSourceImpl implements AgendaLocalDataSource {
  AgendaLocalDataSourceImpl();
  @override
  Future<int> newAgenda(AgendaModel newagenda) async {
    final db = await database;
    final res = await db.insert('Agenda', newagenda.toMap());
    return res;
  }

  @override
  Future<List<AgendaModel>> getAllAgenda(String fecha) async {
    final db = await database;
    final res = await db.query('Agenda');
    final List<AgendaModel> data =
        res.isNotEmpty ? res.map((e) => AgendaModel.fromMap(e)).toList() : [];
    return data;
  }

  Future<Database> get database async {
    Database? database;
    if (database != null) return database;
    database = await initDB();
    return database;
  }

  @override
  Future<int> deleteAgenda(int id) async {
    final db = await database;
    final res = await db.delete('Agenda', where: 'id=?', whereArgs: [id]);
    return res;
  }

  @override
  Future<int> deleteAllAgenda() async {
    final db = await database;
    final res = await db.rawDelete('''DELETE FROM Agenda''');
    return res;
  }

  @override
  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'agendaDB.db');

    return await openDatabase(path, version: 2,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE Agenda(
          id INTEGER PRIMARY KEY,
          username TEXT,
          namecancha TEXT,
          date TEXT,
          percentrain TEXT
        );
      ''');
    });
  }
}
