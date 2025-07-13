import 'package:get/get.dart';
import 'package:home_pharmacy/app/data/db_helper.dart';
import 'package:home_pharmacy/app/data/remedio.dart';

class TakeMedicationController extends GetxController {
  
  var remedios = <Remedio>[].obs;

  final count = 0.obs;

  void loadRemedios() async {
    final data = await DatabaseHelper.instance.readAllRemedios();
    remedios.assignAll(data);
  }
}
