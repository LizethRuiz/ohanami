import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:ohanami/blocs/events.dart';
import 'package:ohanami/paquete_partida/jugador.dart';

/*class PartidaBloc extends Bloc<Eventos, List<Jugador>> {
  PartidaBloc() : super([]) {
    on<SubjectEvent>((event, emit) {
    });
  }

  @override
  void dispose() {
  }
}*/

class PartidaBloc implements Bloc {
  List<Jugador> jugadores = [];

  void setJugadores() {}
  @override
  void dispose() {}
}
