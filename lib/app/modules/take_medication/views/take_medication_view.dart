import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/take_medication_controller.dart';

class TakeMedicationView extends GetView<TakeMedicationController> {
  const TakeMedicationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TakeMedicationView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TakeMedicationView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
