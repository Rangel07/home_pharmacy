import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_pharmacy/app/modules/alarm_medication/views/alarm_medication_view.dart';
import 'package:home_pharmacy/app/modules/expired_medications/views/expired_medications_view.dart';
import 'package:home_pharmacy/app/modules/home/controllers/home_controller.dart';
import 'package:home_pharmacy/app/modules/list_medications/views/list_medications_view.dart';
import 'package:home_pharmacy/app/modules/take_medication/views/take_medication_view.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});
  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Remédios')),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 12.0,
          children: [
            ElevatedButton(
              onPressed: () => Get.to(() => ListMedicationsView()),
              child: const Text('Lista de Remédios'),
            ),
            ElevatedButton(
              onPressed: () => Get.to(() => const TakeMedicationView()),
              child: const Text('[TODO] Tomar remédio'),
            ),
            ElevatedButton(
              onPressed: () => Get.to(() => const AlarmMedicationView()),
              child: const Text('[TODO] Definir lembrete'),
            ),
            ElevatedButton(
              onPressed: () => Get.to(() => const ExpiredMedicationsView()),
              child: const Text('[TODO] Remédios vencidos'),
            ),
          ],
        ),
      ),
    );
  }
}
