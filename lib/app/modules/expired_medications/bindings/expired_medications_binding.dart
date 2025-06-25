import 'package:get/get.dart';

import '../controllers/expired_medications_controller.dart';

class ExpiredMedicationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExpiredMedicationsController>(
      () => ExpiredMedicationsController(),
    );
  }
}
