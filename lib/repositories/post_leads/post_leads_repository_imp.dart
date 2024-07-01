import 'package:ws_cars/models/lead.dart';
import 'package:ws_cars/infra/remote/http_service.dart';
import 'package:ws_cars/core/constants/remote_constants.dart';

import 'post_leads_repository.dart';

class PostLeadsRepositoryImp implements PostLeadsRepository {
  final HttpService httpService;

  PostLeadsRepositoryImp({required this.httpService});
  @override
  Future<bool> call(List<Lead> leads) async {
    try {
      final leadsAsMap = leads.map((e) => e.toMap()).toList();
      final leadsBody = {"leads": leadsAsMap};
      await httpService.post(POST_LEADS_API, body: leadsBody);
      return true;
    } catch (e) {
      return false;
    }
  }
}
