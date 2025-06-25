import 'package:get/get.dart';

import '../controllers/alarm_medication_controller.dart';

class AlarmMedicationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AlarmMedicationController>(
      () => AlarmMedicationController(),
    );
  }
}
