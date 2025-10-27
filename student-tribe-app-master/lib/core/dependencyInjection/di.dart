import 'package:get_it/get_it.dart';

import 'di.config.dart';

class AppContainer {
  static GetIt getIt = GetIt.instance;

  static Future<void> init() async {
    getIt.init();
  }
}
