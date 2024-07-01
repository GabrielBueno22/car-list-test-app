import 'package:flutter/material.dart';
import 'package:ws_cars/models/car.dart';
import 'package:ws_cars/repositories/get_cars/get_cars_repository.dart';

class CarListController {
  final GetCarsRepository getCarsRepository;
  ValueNotifier<List<Car>> cars = ValueNotifier([]);

  ValueNotifier<bool> isLoading = ValueNotifier(false);

  ValueNotifier<bool> isError = ValueNotifier(false);

  CarListController({required this.getCarsRepository});

  Future<void> fetchCars() async {
    try {
      isError.value = false;
      final carsResponse = await getCarsRepository();
      cars.value = carsResponse;
    } catch (e) {
      isError.value = true;
    }
  }
}
