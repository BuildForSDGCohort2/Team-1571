import 'package:PayMeBack/core/sevices/login_service.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked_services/stacked_services.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => LoginService());
  locator.registerLazySingleton(() => ContactsService());
}
