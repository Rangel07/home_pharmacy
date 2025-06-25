import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_pharmacy/app/modules/home/controllers/home_controller.dart';
import 'package:home_pharmacy/app/modules/list_medications/views/list_medications_view.dart';

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
              onPressed: () => Get.toNamed('/page2'),
              child: const Text('[TODO] Tomar remédio'),
            ),
            ElevatedButton(
              onPressed: () => Get.toNamed('/page3'),
              child: const Text('[TODO] Definir lembrete'),
            ),
            ElevatedButton(
              onPressed: () => Get.toNamed('/page4'),
              child: const Text('[TODO] Remédios vencidos'),
            ),
          ],
        ),
      ),
    );
  }
}
