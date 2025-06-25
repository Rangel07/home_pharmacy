import 'package:get/get.dart';

import '../controllers/list_medications_controller.dart';

class ListMedicationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListMedicationsController>(
      () => ListMedicationsController(),
    );
  }
}
