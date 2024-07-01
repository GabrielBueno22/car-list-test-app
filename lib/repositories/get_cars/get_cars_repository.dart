import '../../models/car.dart';

abstract class GetCarsRepository {
  Future<List<Car>> call();
}
