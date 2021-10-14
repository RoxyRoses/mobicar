import 'package:mobicar/api/carro_api.dart';
import 'package:mobicar/db/classe_banco.dart';
import 'package:mobicar/eventos/deletar_carro.dart';
import 'package:mobicar/eventos/set_carro.dart';
import 'package:mobicar/paginas/carro_form.dart';
import 'package:mobicar/modelos/carro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobicar/bloco/carro_bloco.dart';
import 'package:mobicar/paginas/carroteste.dart';

const IconData copyright = IconData(0xe198, fontFamily: 'MaterialIcons');

class ListaCarros extends StatefulWidget {
  const ListaCarros({Key key}) : super(key: key);

  @override
  _ListaCarrosState createState() => _ListaCarrosState();
}

class _ListaCarrosState extends State<ListaCarros> {
  @override
  void initState() {
    super.initState();
    ClasseBanco.db.getCarros().then(
      (listaPassagem) {
        BlocProvider.of<BlocoCarro>(context).add(SetCarro(listaPassagem));
      },
    );
  }

  mostrarDialogoCarro(BuildContext context, Carro carro, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(carro.nome),
        content: Text("Nome ${carro.nome}"),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    FormularioCarro(carro: carro, carroIndex: index),
              ),
            ),
            child: Text("Atualizar"),
          ),
          FlatButton(
            onPressed: () => ClasseBanco.db.delete(carro.nome).then((_) {
              BlocProvider.of<BlocoCarro>(context).add(
                DeletarCarro(index),
              );
              Navigator.pop(context);
            }),
            child: Text("Deletar"),
          ),
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancelar"),
          ),
        ],
      ),
    );
  }

  mostrarDialogoAdicionar(BuildContext context, Carro carro, int index) {
    var dropdownValue;
    List<Carro> carros;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Text(carro.nome),
          content: Text("Nome ${carro.nome}"),
          actions: <Widget>[
            DropdownButton<Carro>(
              value: dropdownValue,
              icon: (null),
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
              ),
              hint: Text('Marca'),
              onChanged: (Carro novoValor) {
                setState(() {
                  dropdownValue = novoValor;
                  CarroApi.carregarMarca();
                  print(dropdownValue);
                });
              },
              items: carros.map((Carro item) {
                return new DropdownMenuItem<Carro>(
                  child: new Text(item.nome),
                  value: item,
                );
              }).toList(),
            ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("Contruindo lista de Jsons");
    final ButtonStyle style =
        TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mobicar",
          style: TextStyle(color: Colors.blue),
        ),
        actions: <Widget>[
          TextButton(
            style: style,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => CarroTeste()),
            ),
            child: const Text('Add New'),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        color: Colors.grey,
        child: BlocConsumer<BlocoCarro, List<Carro>>(
          builder: (context, listaCarro) {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                print("Lista de Carros: $listaCarro");

                Carro carro = listaCarro[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://s2.glbimg.com/mYgwlPa7vtIiUk6kROUxJUi2yyo=/0x0:620x413/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_cf9d035bf26b4646b105bd958f32089d/internal_photos/bs/2020/a/4/Ik8J1fQYirf6wYRvRJ8Q/2020-03-20-novo-tracker-1.jpg'),
                    ),
                    contentPadding: EdgeInsets.all(16),
                    title: Text(carro.nome, style: TextStyle(fontSize: 26)),
                    trailing: Icon(Icons.more_vert),
                    subtitle: Text(
                      "Nome: ${carro.nome}\ncodigo: ${carro.codigo}",
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () => mostrarDialogoCarro(context, carro, index),
                  ),
                );
              },
              itemCount: listaCarro.length,
            );
          },
          listener: (BuildContext context, listaPassagem) {},
        ),
      ),
      bottomNavigationBar: Container(
        height: 30,
        child: BottomAppBar(
          color: preto,
          child: Row(
            children: [
              Icon(
                copyright,
                color: Colors.blue,
              ),
              Text('2020. All rights reserved to Mobcar.',
                  style: TextStyle(color: Colors.blue)),
            ],
          ),
        ),
      ),
    );
  }

  static const MaterialColor preto = MaterialColor(
    valorCor,
    <int, Color>{
      50: Color(0xFF000000),
      100: Color(0xFF000000),
      200: Color(0xFF000000),
      300: Color(0xFF000000),
      400: Color(0xFF000000),
      500: Color(valorCor),
      600: Color(0xFF000000),
      700: Color(0xFF000000),
      800: Color(0xFF000000),
      900: Color(0xFF000000),
    },
  );
  static const int valorCor = 0xFF000000;
}
