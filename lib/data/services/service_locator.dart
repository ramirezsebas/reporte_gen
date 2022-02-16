import 'package:get_it/get_it.dart';
import 'package:report_generator/data/database/database.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator(AppDatabase database) {
  serviceLocator.registerLazySingleton(() => database);
}
