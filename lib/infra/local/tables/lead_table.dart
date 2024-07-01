import '../table.dart';

class LeadTable implements Table {
  static const tableName = 'lead_table';
  final columnCarId = 'car_id';
  final columnModelId = 'model_id';
  final columnClientEmail = 'client_email';
  final columnCreatedAt = 'createdAt';

  @override
  String get createTable => '''
          CREATE TABLE $tableName (
            $columnCarId INTEGER NOT NULL,
            $columnModelId INTEGER NOT NULL,
            $columnClientEmail TEXT NOT NULL,
            $columnCreatedAt TEXT NOT NULL
          )
          ''';

  @override
  String get dropTable => 'DROP TABLE IF EXISTS $tableName';
}
