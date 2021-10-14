import 'package:enhanced_drop_down/enhanced_drop_down.dart';
import 'package:mobicar/api/carro_api.dart';
import 'package:mobicar/bloco/carro_bloco.dart';
import 'package:mobicar/db/classe_banco.dart';
import 'package:mobicar/eventos/add_carro.dart';
import 'package:mobicar/modelos/carro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobicar/modelos/carroModelo.dart';

class ModeloTeste extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text("Adicionar Modelo")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: EnhancedDropDown.withEndpoint(
              dropdownLabelTitle: "Modelos",
              defaultOptionText: "Modelos",
              urlToFetchData: Uri.https("parallelum.com.br",
                  "/fipe/api/v1/carros/marcas/59/modelos/5940/anos/2014-3"),
              valueReturned: (chosen) {
                print(chosen);
              },
            ),
          ),
          Center(
            child: EnhancedDropDown.withEndpoint(
              dropdownLabelTitle: "Modelos",
              defaultOptionText: "Modelos",
              urlToFetchData: Uri.https(
                  "parallelum.com.br", "/fipe/api/v1/carros/marcas/59/modelos"),
              valueReturned: (chosen) {
                print(chosen);
              },
            ),
          )
        ],
      ));
}
