import 'package:get/get.dart';
import 'package:home_pharmacy/app/data/db_helper.dart';
import 'package:home_pharmacy/app/data/remedio.dart';

class ListMedicationsController extends GetxController {
  //TODO: Implement ListMedicationsController

  var remedios = <Remedio>[].obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    loadRemedios();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

   void loadRemedios() async {
    final data = await DatabaseHelper.instance.readAllRemedios();
    remedios.assignAll(data);
  }

  void addRemedio(Remedio remedio) async {
    await DatabaseHelper.instance.createRemedio(remedio);
    loadRemedios();
  }

  void updateRemedio(Remedio remedio) async {
    await DatabaseHelper.instance.updateRemedio(remedio);
    loadRemedios();
  }

  void deleteRemedio(int id) async {
    await DatabaseHelper.instance.deleteRemedio(id);
    loadRemedios();
  }
}
