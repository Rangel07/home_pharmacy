import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/expired_medications_controller.dart';

class ExpiredMedicationsView extends GetView<ExpiredMedicationsController> {
  const ExpiredMedicationsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ExpiredMedicationsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ExpiredMedicationsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
