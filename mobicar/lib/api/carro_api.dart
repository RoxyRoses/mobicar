import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobicar/modelos/carro.dart';
import 'package:mobicar/modelos/carroModelo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mobicar/modelos/valor.dart';

class CarroApi {
  static Future<List<Carro>> carregarMarca() async {
    final resposta = await http.get(
        Uri.parse('https://parallelum.com.br/fipe/api/v1/carros/marcas'),
        headers: {"Accept": "application/json"});
    if (resposta.statusCode == 200) {
      var corpo = (json.decode(resposta.body));

      return corpo.map<Carro>(Carro.fromJson).toList();
    } else {
      throw Exception('falha ao carregar');
    }
  }

  static Future<List<Carro>> carregarAno() async {
    final resposta = await http.get(
        Uri.parse(
            'https://parallelum.com.br/fipe/api/v1/carros/marcas/59/modelos/5940/anos'),
        headers: {"Accept": "application/json"});
    if (resposta.statusCode == 200) {
      var corpo = (json.decode(resposta.body));

      return corpo.map<Carro>(Carro.fromJson).toList();
    } else {
      throw Exception('falha ao carregar');
    }
  }

  /*static Future<List<Modelos>> carregarModelo() async {
    final resposta = await http.get(
        Uri.parse(
            'https://parallelum.com.br/fipe/api/v1/carros/marcas/59/modelos'),
        headers: {"Accept": "application/json"});
    if (resposta.statusCode == 200) {
      var corpo = (json.decode(resposta.body));
      return corpo.map<Modelos>(modeloFromJson).toList();
    } else {
      throw Exception('falha ao carregar');
    }
  }*/
}
