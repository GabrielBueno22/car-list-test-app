import 'package:flutter/material.dart';
import 'package:ws_cars/core/inject/di.dart';
import 'package:ws_cars/presentation/ui/theme/app_theme.dart';

import 'presentation/ui/screens/car_list_screen.dart';

main() async {
  DependencyInjection.initialize();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const WsCars());
}

class WsCars extends StatelessWidget {
  const WsCars({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WS CARS',
      theme: AppTheme.appTheme(),
      home: const CarListScreen(),
    );
  }
}
