import 'package:mobicar/modelos/carro.dart';
import 'carro_evento.dart';

class AddCarro extends CarroEvento {
  Carro novoCarro;

  AddCarro(Carro Carro) {
    novoCarro = Carro;
  }
}
