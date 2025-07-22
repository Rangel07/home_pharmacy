import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:home_pharmacy/app/data/remedio.dart';
import 'package:home_pharmacy/app/modules/list_medications/controllers/list_medications_controller.dart';

import '../controllers/expired_medications_controller.dart';

class ExpiredMedicationsView extends GetView<ExpiredMedicationsController> {
  ExpiredMedicationsView({super.key});
  final ListMedicationsController listMedicationsController = Get.put(
    ListMedicationsController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicamentos Vencidos'),
        centerTitle: true,
      ),
      body:  Obx(() {
        final sortedRemedios = List<Remedio>.from(
        listMedicationsController.remedios.where(
          (remedio) => remedio.dataValidade < DateTime.now().millisecondsSinceEpoch || remedio.quantidade <= 0,
        ),
        );
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              // verifica se a lista de remédios está vazia
              // se estiver vazia, exibe uma mensagem
              // caso contrário, exibe a lista de remédios
              (!sortedRemedios.isNotEmpty)
                  ? Center(
                    child: Text(
                      'Sem remedios vencidos',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                  : Builder(
                    builder: (context) {
                      return ListView.builder(
                        itemCount: sortedRemedios.length,
                        itemBuilder: (context, index) {
                          final remedio = sortedRemedios[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: ListTile(
                              title: Text(remedio.nome),
                              subtitle: Text(
                                '${remedio.descricao} - ${remedio.quantidade} ${remedio.medida}',
                              ),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: context.theme.primaryColor,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              tileColor: Colors.red.withAlpha(50),
                              trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  deleteRemedioDialog(remedio);
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
        );
      }),
      
    );
  }


  void deleteRemedioDialog(Remedio remedio) {
    Get.defaultDialog(
      title: "Excluir Remédio",
      middleText: "Você tem certeza que deseja excluir:\n${remedio.nome}?",
      onCancel: () => Get.back(),
      onConfirm: () {
        Get.back();
        // Chama o método de exclusão do controlador
        listMedicationsController.deleteRemedio(remedio.id!);
      },
      textConfirm: "Excluir",
      textCancel: "Cancelar",
      confirm: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 172, 23, 23),
        ),
        onPressed: () {
          Get.back();
          // Chama o método de exclusão do controlador
          listMedicationsController.deleteRemedio(remedio.id!);
        },
        child: Text("Excluir", style: TextStyle(color: Colors.white)),
      ),
      cancel: ElevatedButton(
        onPressed: () => Get.back(),
        child: Text("Cancelar"),
      ),
    );
  }


}