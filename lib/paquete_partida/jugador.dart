import 'package:ohanami/paquete_partida/problemas.dart';

class Jugador {
  final String nombre;

  Jugador({required this.nombre}) {
    if (nombre.isEmpty) throw ProblemaNombreJugadorVacio();
  }
  int get id => nombre.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Jugador && other.nombre == nombre;
  }

  @override
  int get hashCode => nombre.hashCode;
}
