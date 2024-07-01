// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Car {
  final int id;
  final int modelId;
  final int year;
  final String fuel;
  final int doorsQuantity;
  final String color;
  final String modelName;
  final double price;

  Car(
      {required this.id,
      required this.modelId,
      required this.year,
      required this.fuel,
      required this.doorsQuantity,
      required this.color,
      required this.modelName,
      required this.price});

  Car copyWith({
    int? id,
    int? modelId,
    int? year,
    String? fuel,
    int? doorsQuantity,
    String? color,
    String? modelName,
    double? price,
  }) {
    return Car(
      id: id ?? this.id,
      modelId: modelId ?? this.modelId,
      year: year ?? this.year,
      fuel: fuel ?? this.fuel,
      doorsQuantity: doorsQuantity ?? this.doorsQuantity,
      color: color ?? this.color,
      modelName: modelName ?? this.modelName,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'modelo_id': modelId,
      'ano': year,
      'combustivel': fuel,
      'num_portas': doorsQuantity,
      'cor': color,
      'nome_modelo': modelName,
      'valor': price,
    };
  }

  factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
      id: map['id'] as int,
      modelId: map['modelo_id'] as int,
      year: map['ano'] as int,
      fuel: map['combustivel'] as String,
      doorsQuantity: map['num_portas'] as int,
      color: map['cor'] as String,
      modelName: map['nome_modelo'] as String,
      price: map['valor'] * 1000 as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Car.fromJson(String source) =>
      Car.fromMap(json.decode(source) as Map<String, dynamic>);
}
