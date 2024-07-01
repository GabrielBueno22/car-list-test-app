import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:ws_cars/core/constants/send_leads_timer.dart';
import 'package:ws_cars/repositories/get_leads_to_post/get_leads_to_post_repository.dart';
import 'package:ws_cars/repositories/post_leads/post_leads_repository.dart';

class SendLeadController {
  final PostLeadsRepository postLeadsRepository;
  final LeadsToPostRepository leadsToPostRepository;
  late Timer _timer;

  SendLeadController(
      {required this.postLeadsRepository,
      required this.leadsToPostRepository}) {
    postLeadsLoop();
  }

  dispose() {
    _timer.cancel();
  }

  postLeadsLoop() {
    _timer = Timer.periodic(const Duration(seconds: SEND_LEADS_ITERATION_TIME),
        (Timer t) {
      postLeads();
    });
  }

  postLeads() async {
    try {
      print("---- POSTING LEADS ----\n");
      final leads = await leadsToPostRepository();
      print("---- LEADS TO POST => ${leads.length} ----\n");
      if (leads.isNotEmpty) {
        print("---- POSTED ----\n");
        await postLeadsRepository(leads);
        await leadsToPostRepository.clearPosted();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
