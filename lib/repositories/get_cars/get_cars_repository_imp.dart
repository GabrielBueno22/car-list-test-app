import 'package:ws_cars/models/car.dart';
import 'package:ws_cars/infra/remote/http_service.dart';
import 'package:ws_cars/core/constants/remote_constants.dart';

import 'get_cars_repository.dart';

class GetCarsRepositoryImp implements GetCarsRepository {
  final HttpService httpService;

  GetCarsRepositoryImp({required this.httpService});
  @override
  Future<List<Car>> call() async {
    try {
      final response = await httpService.get(GET_GARS_API);
      final carsFromApi = response!["cars"] as List;
      return carsFromApi.map((e) => Car.fromMap(e)).toList();
    } catch (e) {
      throw Exception();
    }
  }
}
