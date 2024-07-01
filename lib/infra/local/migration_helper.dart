import 'package:sqflite/sqflite.dart';
import 'package:ws_cars/infra/local/tables/lead_table.dart';

import 'table.dart';

class MigrationHelper {
  final int dbVersion = 1;
  final List<Table> tables = [LeadTable()];

  Future<void> createMigrations(Database db) async {
    for (var table in tables) {
      await db.execute(table.createTable);
    }
  }

  Future<void> deleteMigrations(Database db) async {
    for (var table in tables) {
      await db.execute(table.dropTable);
    }
  }
}
