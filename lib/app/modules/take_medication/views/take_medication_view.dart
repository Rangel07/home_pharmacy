import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:home_pharmacy/app/modules/list_medications/controllers/list_medications_controller.dart';

import '../controllers/take_medication_controller.dart';

class TakeMedicationView extends GetView<TakeMedicationController> {
  TakeMedicationView({super.key});
  final ListMedicationsController listMedicationsController = Get.put(
    ListMedicationsController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TakeMedicationView'),
        centerTitle: true,
      ),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              (!listMedicationsController.remedios.isNotEmpty)
                  ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Adicione um remédio ao seu estoque!",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                  : ListView.builder(
                    itemCount: listMedicationsController.remedios.length,
                    itemBuilder: (context, index) {
                      final remedio = listMedicationsController.remedios[index];
                      if (remedio.quantidade <= 0) {
                        return SizedBox.shrink(); // Skip empty medications
                      }
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(remedio.nome, 
                            style: TextStyle(fontSize: 20),),
                          subtitle: Text(
                            '${remedio.quantidade} ${remedio.medida} restante',
                          ),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: context.theme.primaryColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          tileColor: context.theme.primaryColor.withAlpha(50),

                          onTap: () {
                            // Implementar lógica para tomar o remédio
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                final TextEditingController quantityController = TextEditingController();
                                return AlertDialog(
                                  title: Text('Quanto tomar?'),
                                  content: TextField(
                                    controller: quantityController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: 'Quantidade',
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      child: Text('Cancelar'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        final int? quantity = int.tryParse(quantityController.text);
                                        if (quantity != null && quantity > 0) {
                                          if (remedio.quantidade >= quantity) {
                                            // Atualizar a quantidade do remédio
                                            remedio.quantidade -= quantity;
                                            listMedicationsController.updateRemedio(remedio);
                                            Get.snackbar(
                                              'Sucesso',
                                              'Você tomou $quantity ${remedio.medida} de ${remedio.nome}.',
                                              snackPosition: SnackPosition.BOTTOM,
                                            );
                                          } else {
                                            Get.snackbar(
                                              'Erro',
                                              'Quantidade insuficiente de ${remedio.nome}.',
                                              snackPosition: SnackPosition.BOTTOM,
                                            );
                                          }
                                        } else {
                                          Get.snackbar(
                                            'Erro',
                                            'Por favor, insira uma quantidade válida.',
                                            snackPosition: SnackPosition.BOTTOM,
                                          );
                                        }
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Confirmar'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
        );
      }),
    );
  }
}
