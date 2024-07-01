import 'package:get_it/get_it.dart';
import 'package:ws_cars/infra/remote/http_service.dart';
import 'package:ws_cars/infra/remote/http_service_imp.dart';

import '../../presentation/controllers/car_list_controller.dart';
import '../../presentation/controllers/send_leads_controller.dart';
import '../../repositories/get_cars/get_cars_repository.dart';
import '../../repositories/get_cars/get_cars_repository_imp.dart';
import '../../repositories/get_leads_to_post/get_leads_to_post_repository.dart';
import '../../repositories/get_leads_to_post/get_leads_to_post_repository_imp.dart';
import '../../repositories/post_leads/post_leads_repository.dart';
import '../../repositories/post_leads/post_leads_repository_imp.dart';
import '../../repositories/save_lead/save_lead_repository.dart';
import '../../repositories/save_lead/save_lead_repository_imp.dart';
import '../../infra/local/local_db_service.dart';
import '../../infra/local/local_db_service_imp.dart';

class DependencyInjection {
  static initialize() {
    GetIt getIt = GetIt.instance;
    getIt.registerLazySingleton<HttpService>(() => HttpServiceImp());
    getIt.registerLazySingleton<LocalDbService>(() => LocalDBServiceImp());
    getIt.registerLazySingleton<PostLeadsRepository>(
        () => PostLeadsRepositoryImp(httpService: getIt()));

    getIt.registerLazySingleton<GetCarsRepository>(
        () => GetCarsRepositoryImp(httpService: getIt()));
    getIt.registerLazySingleton<SaveLeadRepository>(
      () => SaveLeadRepositoryImp(localDBService: getIt()),
    );

    getIt.registerLazySingleton<LeadsToPostRepository>(
      () => GetLeadsToPostRepositoryImp(localDBService: getIt()),
    );
    getIt.registerLazySingleton<CarListController>(
      () => CarListController(getCarsRepository: getIt()),
    );
    getIt.registerLazySingleton<SendLeadController>(() => SendLeadController(
          postLeadsRepository: getIt(),
          leadsToPostRepository: getIt(),
        ));
  }
}
