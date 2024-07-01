import '../../models/lead.dart';

abstract class PostLeadsRepository {
  Future<bool> call(List<Lead> leads);
}
