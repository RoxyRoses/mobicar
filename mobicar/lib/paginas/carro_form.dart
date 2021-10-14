import 'dart:convert';
import 'package:enhanced_drop_down/enhanced_drop_down.dart';
import 'package:http/http.dart' as http;
import 'package:mobicar/api/carro_api.dart';
import 'package:mobicar/bloco/carro_bloco.dart';
import 'package:mobicar/db/classe_banco.dart';
import 'package:mobicar/eventos/add_carro.dart';
import 'package:mobicar/eventos/atualizar_carro.dart';
import 'package:mobicar/modelos/carro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:mobicar/modelos/valor.dart';
import 'package:mobicar/modelos/carroModelo.dart';

class FormularioCarro extends StatefulWidget {
  final Carro carro;
  final Modelos modelo;
  final int carroIndex;
  var dropdownValue;

  FormularioCarro({this.carro, this.carroIndex, this.modelo});

  @override
  State<StatefulWidget> createState() {
    return FormularioCarroState();
  }
}

class FormularioCarroState extends State<FormularioCarro> {
  Future<Carro> carroFuturo;
  String _marca;
  String _modelo;
  int _ano;
  String _valor;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildMarca(List<Carro> carros) {
    var dropdownValue;

    return Column(
      children: [
        DropdownButton<Carro>(
          value: dropdownValue,
          icon: (null),
          style: TextStyle(
            color: Colors.black54,
            fontSize: 16,
          ),
          hint: Text('Marca'),
          onChanged: (novoValor) {
            setState(() {
              dropdownValue = novoValor;
              CarroApi.carregarMarca();
              print(dropdownValue);
            });
          },
          items: carros.map((Carro item) {
            return DropdownMenuItem<Carro>(
              child: Text(item.nome),
              value: item,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildAno(List<Carro> anos) {
    var dropdownValue;

    return Column(
      children: [
        DropdownButton<Carro>(
          value: dropdownValue,
          icon: (null),
          style: TextStyle(
            color: Colors.black54,
            fontSize: 16,
          ),
          hint: Text('Ano'),
          onChanged: (novoValor) {
            setState(() {
              dropdownValue = novoValor;
              CarroApi.carregarMarca();
              print(dropdownValue);
            });
          },
          items: anos.map((Carro item) {
            return DropdownMenuItem<Carro>(
              child: Text(item.nome),
              value: item,
            );
          }).toList(),
        ),
      ],
    );
  }

  /* Widget _buildModelo(List<Modelos> modelos) {
    var dropdownValue;

    return Column(
      children: [
        DropdownButton<Modelos>(
          value: dropdownValue,
          icon: (null),
          style: TextStyle(
            color: Colors.black54,
            fontSize: 16,
          ),
          hint: Text('Modelo'),
          onChanged: (novoValor) {
            setState(() {
              dropdownValue = novoValor;
              CarroApi.carregarModelo();
              print(dropdownValue);
            });
          },
          items: modelos.map((Modelos item) {
            return DropdownMenuItem<Modelos>(
              child: Text(item.modelos.toString()),
              value: item,
            );
          }).toList(),
        ),
      ],
    );
  }*/

  @override
  void initState() {
    super.initState();
    if (widget.carro != null) {
      _marca = widget.carro.nome;
    }
    if (widget.modelo != null) {
      _modelo = widget.modelo.modelos.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    var dropdownValue;
    List<Valor> listaValor = List<Valor>();
    return Scaffold(
      appBar: AppBar(title: Text("Cadastrar Carro")),
      body: Column(children: [
        Container(
          child: Image.network(
              'https://s2.glbimg.com/mYgwlPa7vtIiUk6kROUxJUi2yyo=/0x0:620x413/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_cf9d035bf26b4646b105bd958f32089d/internal_photos/bs/2020/a/4/Ik8J1fQYirf6wYRvRJ8Q/2020-03-20-novo-tracker-1.jpg'),
        ),
        Center(
          child: FutureBuilder<List<Carro>>(
            future: CarroApi.carregarMarca(),
            builder: (context, snapshot) {
              final carros = snapshot.data;

              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    return Center(child: Text('Error'));
                  } else {
                    return _buildMarca(carros);
                  }
              }
            },
          ),
        ),
        Center(
          child: FutureBuilder<List<Carro>>(
            future: CarroApi.carregarAno(),
            builder: (context, snapshot) {
              final modelos = snapshot.data;

              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    return Center(child: Text('Error'));
                  } else {
                    return _buildAno(modelos);
                  }
              }
            },
          ),
        ),
        Center(
          child: EnhancedDropDown.withEndpoint(
            dropdownLabelTitle: " ",
            defaultOptionText: "Anos",
            urlToFetchData: Uri.https("parallelum.com.br",
                "/fipe/api/v1/carros/marcas/59/modelos/5940/anos/2014-3"),
            valueReturned: (chosen) {
              print(chosen);
            },
          ),
        ),
        /*Center(
          child: EnhancedDropDown.withEndpoint(
            dropdownLabelTitle: " ",
            defaultOptionText: "Modelos",
            urlToFetchData: Uri.https(
                "parallelum.com.br", "/fipe/api/v1/carros/marcas/59/modelos"),
            valueReturned: (chosen) {
              print(chosen);
            },
          ),
        ),*/
      ]),
    );
  }
}
