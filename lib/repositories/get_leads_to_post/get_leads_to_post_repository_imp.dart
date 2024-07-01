import 'package:ws_cars/models/lead.dart';
import 'package:ws_cars/infra/local/tables/lead_table.dart';

import '../../infra/local/local_db_service.dart';
import 'get_leads_to_post_repository.dart';

class GetLeadsToPostRepositoryImp implements LeadsToPostRepository {
  final LocalDbService localDBService;

  GetLeadsToPostRepositoryImp({required this.localDBService});
  @override
  Future<List<Lead>> call() async {
    try {
      final listOfLeadsAsMap =
          await localDBService.getData(LeadTable.tableName);
      final leads = listOfLeadsAsMap.map((e) => Lead.fromMap(e));
      return leads.toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future clearPosted() async {
    await localDBService.clearData(LeadTable.tableName);
  }
}
