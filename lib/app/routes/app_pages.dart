import 'package:get/get.dart';

import '../modules/alarm_medication/bindings/alarm_medication_binding.dart';
import '../modules/alarm_medication/views/alarm_medication_view.dart';
import '../modules/expired_medications/bindings/expired_medications_binding.dart';
import '../modules/expired_medications/views/expired_medications_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/list_medications/bindings/list_medications_binding.dart';
import '../modules/list_medications/views/list_medications_view.dart';
import '../modules/take_medication/bindings/take_medication_binding.dart';
import '../modules/take_medication/views/take_medication_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LIST_MEDICATIONS,
      page: () => ListMedicationsView(),
      binding: ListMedicationsBinding(),
    ),
    GetPage(
      name: _Paths.TAKE_MEDICATION,
      page: () => const TakeMedicationView(),
      binding: TakeMedicationBinding(),
    ),
    GetPage(
      name: _Paths.ALARM_MEDICATION,
      page: () => const AlarmMedicationView(),
      binding: AlarmMedicationBinding(),
    ),
    GetPage(
      name: _Paths.EXPIRED_MEDICATIONS,
      page: () => const ExpiredMedicationsView(),
      binding: ExpiredMedicationsBinding(),
    ),
  ];
}
