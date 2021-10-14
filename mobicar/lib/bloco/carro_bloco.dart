import 'package:mobicar/eventos/carro_evento.dart';
import 'package:mobicar/eventos/set_carro.dart';
import 'package:mobicar/eventos/add_carro.dart';
import 'package:mobicar/eventos/atualizar_carro.dart';
import 'package:mobicar/eventos/deletar_carro.dart';
import 'package:mobicar/modelos/carro.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocoCarro extends Bloc<CarroEvento, List<Carro>> {
  @override
  List<Carro> get initialState => <Carro>[];

  @override
  Stream<List<Carro>> mapEventToState(CarroEvento event) async* {
    if (event is SetCarro) {
      yield event.listaCarro;
    } else if (event is AddCarro) {
      List<Carro> newState = List.from(state);
      if (event.novoCarro != null) {
        newState.add(event.novoCarro);
      }
      yield newState;
    } else if (event is DeletarCarro) {
      List<Carro> newState = List.from(state);
      newState.removeAt(event.CarroIndex);
      yield newState;
    } else if (event is AtualizarCarro) {
      List<Carro> newState = List.from(state);
      newState[event.carroIndex] = event.novocarro;
      yield newState;
    }
  }
}
