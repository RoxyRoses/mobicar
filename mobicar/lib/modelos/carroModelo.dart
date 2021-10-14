// To parse this JSON data, do
//
//     final modelo = modeloFromJson(jsonString);

import 'dart:convert';

Modelos modeloFromJson(String str) => Modelos.fromJson(json.decode(str));

String modeloToJson(Modelos data) => json.encode(data.toJson());

class Modelos {
  Modelos({
    this.modelos,
    this.anos,
  });

  List<Modelo> modelos;
  List<Ano> anos;

  factory Modelos.fromJson(Map<String, dynamic> json) => Modelos(
        modelos:
            List<Modelo>.from(json["modelos"].map((x) => Modelo.fromJson(x))),
        anos: List<Ano>.from(json["anos"].map((x) => Ano.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "modelos": List<dynamic>.from(modelos.map((x) => x.toJson())),
        "anos": List<dynamic>.from(anos.map((x) => x.toJson())),
      };
}

class Ano {
  Ano({
    this.nome,
    this.codigo,
  });

  String nome;
  String codigo;

  factory Ano.fromJson(Map<String, dynamic> json) => Ano(
        nome: json["nome"],
        codigo: json["codigo"],
      );

  Map<String, dynamic> toJson() => {
        "nome": nome,
        "codigo": codigo,
      };
}

class Modelo {
  Modelo({
    this.nome,
    this.codigo,
  });

  String nome;
  int codigo;

  factory Modelo.fromJson(Map<String, dynamic> json) => Modelo(
        nome: json["nome"],
        codigo: json["codigo"],
      );

  Map<String, dynamic> toJson() => {
        "nome": nome,
        "codigo": codigo,
      };
}
