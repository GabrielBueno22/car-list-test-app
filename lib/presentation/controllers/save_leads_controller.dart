import 'package:flutter/material.dart';
import 'package:ws_cars/models/car.dart';
import 'package:ws_cars/models/lead.dart';

import '../../repositories/save_lead/save_lead_repository.dart';

class SaveLeadsController {
  final SaveLeadRepository saveLeadRepository;

  final ValueNotifier<bool> isSaving = ValueNotifier(false);

  final ValueNotifier<bool> errorSaving = ValueNotifier(false);

  SaveLeadsController({required this.saveLeadRepository});

  saveLead(Car car, String clientMail) async {
    try {
      isSaving.value = true;
      final leadIsSaved =
          await saveLeadRepository(Lead.fromCar(car, clientMail));
      isSaving.value = false;
      if (!leadIsSaved) {
        errorSaving.value = true;
      }
    } catch (e) {
      errorSaving.value = true;
    }
  }
}
