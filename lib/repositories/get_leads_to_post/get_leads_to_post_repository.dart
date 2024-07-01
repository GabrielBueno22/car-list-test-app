import '../../models/lead.dart';

abstract class LeadsToPostRepository {
  Future<List<Lead>> call();

  Future clearPosted();
}
