import 'package:get/get.dart';

import '../controllers/take_medication_controller.dart';

class TakeMedicationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TakeMedicationController>(
      () => TakeMedicationController(),
    );
  }
}
