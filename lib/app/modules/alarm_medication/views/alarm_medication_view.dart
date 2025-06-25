import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/alarm_medication_controller.dart';

class AlarmMedicationView extends GetView<AlarmMedicationController> {
  const AlarmMedicationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AlarmMedicationView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AlarmMedicationView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
