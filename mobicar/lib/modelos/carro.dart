import 'package:mobicar/modelos/carroModelo.dart';

class Carro {
  String nome;
  String codigo;
  String ano;
  int id;

  Carro({this.nome, this.codigo, this.id});

  static Carro fromJson(json) => Carro(
        nome: json['nome'],
        codigo: json['codigo'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['codigo'] = this.codigo;
    data['id'] = this.id;

    return data;
  }
}
