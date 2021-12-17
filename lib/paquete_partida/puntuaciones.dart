import 'package:ohanami/paquete_partida/problemas.dart';

import 'jugador.dart';

const int ninguna = 0;
const int maximoCartasPR1 = 10;
const int maximoCartasPR2 = 20;
const int maximoCartasPR3 = 30;

class PRonda1 {
  final Jugador jugador;
  final int cuantasAzules;

  PRonda1({required this.jugador, required this.cuantasAzules}) {
    if (cuantasAzules < ninguna) throw ProblemaAzulesNegativas();
    if (cuantasAzules > maximoCartasPR1) throw ProblemasDemasiadasAzules();
  }
}

class PRonda2 {
  final Jugador jugador;
  final int cuantasAzules;
  final int cuantasVerdes;

  PRonda2(
      {required this.jugador,
      required this.cuantasAzules,
      required this.cuantasVerdes}) {
    if (cuantasAzules < ninguna) throw ProblemaAzulesNegativas();
    if (cuantasVerdes < ninguna) throw ProblemaVerdesNegativas();
  }
}

class PRonda3 {
  final int cuantasVerdes;
  final int cuantasAzules;
  final int cuantasNegras;
  final int cuantasRosas;
  final Jugador jugador;

  PRonda3(
      {required this.jugador,
      required this.cuantasVerdes,
      required this.cuantasAzules,
      required this.cuantasNegras,
      required this.cuantasRosas}) {
    if (cuantasAzules < ninguna) throw ProblemaAzulesNegativas();
    if (cuantasVerdes < ninguna) throw ProblemaVerdesNegativas();
    if (cuantasNegras < ninguna) throw ProblemaNegrasNegativas();
    if (cuantasRosas < ninguna) throw ProblemaRosasNegativas();
    if ((cuantasAzules + cuantasNegras + cuantasRosas + cuantasVerdes) >
        maximoCartasPR3) {
      throw ProblemaExcesoCartas();
    }
  }
}
