import 'package:mobicar/api/carro_api.dart';
import 'package:mobicar/bloco/carro_bloco.dart';
import 'package:mobicar/db/classe_banco.dart';
import 'package:mobicar/eventos/add_carro.dart';
import 'package:mobicar/modelos/carro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarroTeste extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text("Adicionar Carro")),
        body: FutureBuilder<List<Carro>>(
          future: CarroApi.carregarMarca(),
          builder: (context, snapshot) {
            final passagens = snapshot.data;

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return Center(child: Text('Error'));
                } else {
                  return buildCarros(passagens);
                }
            }
          },
        ),
      );

  Widget buildCarros(List<Carro> carros) => ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: carros.length,
        itemBuilder: (context, index) {
          final carro = carros[index];

          return Column(
            children: <Widget>[
              Text('Marca',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
              Text(
                carro.nome,
                style: TextStyle(height: 1, fontSize: 25),
              ),
              RaisedButton(
                  child: Text(
                    'Cadastrar Carro',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                  onPressed: () {
                    ClasseBanco.db.insert(carro).then(
                          (carroGuardado) =>
                              BlocProvider.of<BlocoCarro>(context).add(
                            AddCarro(carroGuardado),
                          ),
                        );

                    Navigator.pop(context);
                  })
            ],
          );
        },
      );
}
