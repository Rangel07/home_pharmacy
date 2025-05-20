import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:home_pharmacy/app/data/remedio.dart';
import 'package:home_pharmacy/app/modules/home/views/widgets/lista_vazia.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});
  final HomeController homeController = Get.put(HomeController());
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
              (!homeController.remedios.isNotEmpty)
                  ? ListaRemediosVazia()
                  : ListView.builder(
                    itemCount: homeController.remedios.length,
                    itemBuilder: (context, index) {
                      final remedio = homeController.remedios[index];
                      return ListTile(
                        title: Text(remedio.nome),
                        subtitle: Text(
                          '${remedio.descricao} - ${remedio.quantidade}',
                        ),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blueAccent),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        tileColor: Colors.blueAccent.withAlpha(50),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            homeController.deleteRemedio(remedio.id!);
                          },
                        ),
                        onTap: () {
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
                          // Exemplo: adicionar um novo remédio (poderia abrir um formulário)
                          Get.defaultDialog(
                            title: "Alterar Remédio",
                            content: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
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

                                  remedio.nome = nome;
                                  remedio.descricao = descricao;
                                  remedio.quantidade = quantidade;
                                  // Aqui você pode chamar o método de atualização do controlador
                                  homeController.updateRemedio(remedio);
                                  Get.back();
                                },
                                child: Text("Salvar"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final nomeController = TextEditingController();
          final descricaoController = TextEditingController();
          final quantidadeController = TextEditingController();
          // Exemplo: adicionar um novo remédio (poderia abrir um formulário)
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
                  homeController.addRemedio(
                    Remedio(
                      nome: nome,
                      descricao: descricao,
                      quantidade: quantidade,
                    ),
                  );
                  Get.back();
                },
                child: Text("Salvar"),
              ),
            ],
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
