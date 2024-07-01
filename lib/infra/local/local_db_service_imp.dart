import 'package:sqflite/sqflite.dart';
import 'package:ws_cars/infra/local/local_db_service.dart';

import 'migration_helper.dart';

class LocalDBServiceImp implements LocalDbService {
  late Database db;
  late MigrationHelper migrationHelper;

  LocalDBServiceImp() {
    init();
  }

  Future open(String path) async {
    db = await openDatabase(
      path,
      version: migrationHelper.dbVersion,
      onCreate: (Database db, int version) async {
        migrationHelper.createMigrations(db);
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) {
        migrationHelper.deleteMigrations(db);
        migrationHelper.createMigrations(db);
      },
    );
  }

  String dbname = 'sqlitebt.db';

  Future init() async {
    migrationHelper = MigrationHelper();
    await open(dbname);
  }

  @override
  Future<List<Map<String, dynamic>>> getData(String path) async {
    return await db.query(path);
  }

  @override
  Future<int> saveData(
      {required Map<String, dynamic> data, required String path}) async {
    return await db.insert(path, data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future clearData(String path) async {
    return await db.delete(path);
  }
}
