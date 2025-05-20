import 'package:flutter/material.dart';

class ListaRemediosVazia extends StatelessWidget {
  const ListaRemediosVazia({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
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
    );
  }
}