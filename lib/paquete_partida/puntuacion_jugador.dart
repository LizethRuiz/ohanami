import 'package:ohanami/paquete_partida/jugador.dart';

class P {}

class PJugador extends P {}

class PJugadorFinal extends P {}

class PuntuacionJugador {
  final Jugador jugador;
  final int porAzules;
  final int porVerdes;
  final int porRosas;
  final int porNegras;

  int get total => porAzules + porNegras + porVerdes + porRosas;

  PuntuacionJugador(
      {required this.jugador,
      required this.porAzules,
      required this.porVerdes,
      required this.porRosas,
      required this.porNegras});
}
