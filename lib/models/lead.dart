import 'dart:convert';

import 'car.dart';

class Lead {
  final String clientEmail;
  final int carId;
  final int carModelId;
  final DateTime createdAt;

  Lead(
      {required this.clientEmail,
      required this.carId,
      required this.carModelId,
      required this.createdAt});

  Lead copyWith({
    String? clientEmail,
    int? carId,
    int? carModelId,
    DateTime? createdAt,
  }) {
    return Lead(
      clientEmail: clientEmail ?? this.clientEmail,
      carId: carId ?? this.carId,
      carModelId: carModelId ?? this.carModelId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'client_email': clientEmail,
      'car_id': carId,
      'model_id': carModelId,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Lead.fromMap(Map<String, dynamic> map) {
    return Lead(
      clientEmail: map['client_email'] as String,
      carId: map['car_id'] as int,
      carModelId: map['model_id'] as int,
      createdAt: DateTime.fromMillisecondsSinceEpoch(
          int.parse(map['createdAt'] as String)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Lead.fromJson(String source) =>
      Lead.fromMap(json.decode(source) as Map<String, dynamic>);

  factory Lead.fromCar(Car car, String clientEmail) => Lead(
      carId: car.id,
      carModelId: car.modelId,
      clientEmail: clientEmail,
      createdAt: DateTime.now());
}
