import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobicar/bloco/carro_bloco.dart';
import 'package:mobicar/paginas/lista_carros.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocoCarro>(
      create: (context) => BlocoCarro(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mobicar',
        theme: ThemeData(
          primarySwatch: preto,
        ),
        home: ListaCarros(),
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
