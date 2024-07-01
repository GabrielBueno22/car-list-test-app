import 'package:ws_cars/models/lead.dart';

import 'package:ws_cars/infra/local/tables/lead_table.dart';

import '../../infra/local/local_db_service.dart';
import 'save_lead_repository.dart';

class SaveLeadRepositoryImp implements SaveLeadRepository {
  final LocalDbService localDBService;

  SaveLeadRepositoryImp({required this.localDBService});
  @override
  Future<bool> call(Lead lead) async {
    try {
      final localId = await localDBService.saveData(
          data: lead.toMap(), path: LeadTable.tableName);
      if (localId > 0) {
        return true;
      }
      return false;
    } catch (e) {
      throw Exception();
    }
  }
}
