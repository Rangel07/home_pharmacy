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
        title: const Text('ExpiredMedicationsView'),
        centerTitle: true,
      ),
      body:  Obx(() {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              // verifica se a lista de remédios está vazia
              // se estiver vazia, exibe uma mensagem
              // caso contrário, exibe a lista de remédios
              (!listMedicationsController.remedios.isNotEmpty)
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
                      // Cria uma cópia e ordena: remédios com quantidade > 0 primeiro.
                        final sortedRemedios = List<Remedio>.from(
                        listMedicationsController.remedios.where(
                          (remedio) => remedio.dataValidade < DateTime.now().millisecondsSinceEpoch,
                        ),
                        );
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
                                  // deleteRemedioDialog(remedio);
                                },
                              ),
                              onTap: () {
                                // updateRemedioDialog(remedio);
                              },
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
}
