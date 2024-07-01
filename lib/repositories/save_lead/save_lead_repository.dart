import 'package:ws_cars/models/lead.dart';

abstract class SaveLeadRepository {
  Future<bool> call(Lead lead);
}
