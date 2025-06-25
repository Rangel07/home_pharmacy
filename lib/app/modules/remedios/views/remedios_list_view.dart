import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:home_pharmacy/app/data/remedio.dart';
import 'package:home_pharmacy/app/modules/remedios/views/widgets/lista_vazia.dart';
import '../controllers/remedios_controller.dart';

class RemediosView extends GetView<RemedioController> {
  RemediosView({super.key});
  final RemedioController remedioController = Get.put(RemedioController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Remédios')),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              // verifica se a lista de remédios está vazia
              // se estiver vazia, exibe uma mensagem
              // caso contrário, exibe a lista de remédios
              (!remedioController.remedios.isNotEmpty)
                  ? ListaRemediosVazia()
                  : ListView.builder(
                    itemCount: remedioController.remedios.length,
                    itemBuilder: (context, index) {
                      final remedio = remedioController.remedios[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: ListTile(
                          title: Text(remedio.nome),
                          subtitle: Text(
                            '${remedio.descricao} - ${remedio.quantidade} ${remedio.medida}',
                          ),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: context.theme.primaryColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          tileColor: context.theme.primaryColor.withAlpha(50),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              deleteRemedioDialog(remedio);
                            },
                          ),
                          onTap: () {
                            // Exemplo: adicionar um novo remédio (poderia abrir um formulário)
                            updateRemedioDialog(remedio);
                          },
                        ),
                      );
                    },
                  ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Exemplo: adicionar um novo remédio (poderia abrir um formulário)
          addRemedioDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void addRemedioDialog() {
     // Aqui você pode navegar para uma tela de edição ou detalhes
    final nomeController = TextEditingController();
    final descricaoController = TextEditingController();
    final quantidadeController = TextEditingController();
    final medidaController = TextEditingController();
    Get.defaultDialog(
          title: "Adicionar Remédio",
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nomeController,
                  decoration: InputDecoration(labelText: "Nome"),
                ),
                TextField(
                  controller: descricaoController,
                  decoration: InputDecoration(labelText: "Descrição"),
                ),
                TextField(
                  controller: quantidadeController,
                  decoration: InputDecoration(labelText: "Quantidade"),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                TextField(
                  controller: medidaController,
                  decoration: InputDecoration(labelText: "Unidade de Medida"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Get.back(), child: Text("Cancelar")),
            TextButton(
              onPressed: () {
                final nome = nomeController.text;
                final descricao = descricaoController.text;
                final quantidade =
                    int.tryParse(quantidadeController.text) ?? 1;
                final medida = medidaController.text;
                remedioController.addRemedio(
                  Remedio(
                    nome: nome,
                    descricao: descricao,
                    quantidade: quantidade,
                    medida: medida.isNotEmpty ? medida : 'capsulas',
                  ),
                );
                Get.back();
              },
              child: Text("Salvar"),
            ),
          ],
        );
  }

  void updateRemedioDialog(Remedio remedio) {
     // Aqui você pode navegar para uma tela de edição ou detalhes
    final nomeController = TextEditingController(
      text: remedio.nome,
    );
    final descricaoController = TextEditingController(
      text: remedio.descricao,
    );
    final quantidadeController = TextEditingController(
      text: remedio.quantidade.toString(),
    );
    final medidaController = TextEditingController(
      text: remedio.medida.toString(),
    );
    Get.defaultDialog(
                          title: "Alterar Remédio",
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: nomeController,
                                    decoration: InputDecoration(
                                      labelText: "Nome",
                                    ),
                                  ),
                                  TextField(
                                    controller: descricaoController,
                                    decoration: InputDecoration(
                                      labelText: "Descrição",
                                    ),
                                  ),
                                  TextField(
                                    controller: quantidadeController,
                                    decoration: InputDecoration(
                                      labelText: "Quantidade",
                                    ),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                  ),
                                  TextField(
                                    controller: medidaController,
                                    decoration: InputDecoration(
                                      labelText: "Unidade de Medida",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Get.back(),
                              child: Text("Cancelar"),
                            ),
                            TextButton(
                              onPressed: () {
                                final nome = nomeController.text;
                                final descricao = descricaoController.text;
                                final quantidade =
                                    int.tryParse(quantidadeController.text) ??
                                    1;
                                final medida = medidaController.text.isNotEmpty ?
                                    medidaController.text
                                    : 'capsulas';

                                remedio.nome = nome;
                                remedio.descricao = descricao;
                                remedio.quantidade = quantidade;
                                remedio.medida = medida;
                                // Aqui você pode chamar o método de atualização do controlador
                                remedioController.updateRemedio(remedio);
                                Get.back();
                              },
                              child: Text("Salvar"),
                            ),
                          ],
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
        remedioController.deleteRemedio(remedio.id!);
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
          remedioController.deleteRemedio(remedio.id!);
        },
        child: Text(
          "Excluir",
          style: TextStyle(color: Colors.white),
        ),
        ),
      cancel: ElevatedButton(
        onPressed: () => Get.back(),
        child: Text("Cancelar"),
      ),
    );
  }

}
