import 'package:get/get.dart';

import '../controllers/remedios_controller.dart';

class RemediosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RemedioController>(
      () => RemedioController(),
    );
  }
}
