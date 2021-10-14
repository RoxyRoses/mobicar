import 'package:mobicar/modelos/carro.dart';
import 'carro_evento.dart';

class SetCarro extends CarroEvento {
  List<Carro> listaCarro;

  SetCarro(List<Carro> Carros) {
    listaCarro = Carros;
  }
}
