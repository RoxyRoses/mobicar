import 'package:mobicar/modelos/carro.dart';
import 'carro_evento.dart';

class AtualizarCarro extends CarroEvento {
  Carro novocarro;
  int carroIndex;

  AtualizarCarro(int index, Carro carro) {
    novocarro = carro;
    carroIndex = index;
  }
}
