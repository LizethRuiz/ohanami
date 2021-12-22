import 'package:ohanami/paquete_partida/problemas.dart';

import 'helpers.dart';
import 'jugador.dart';
import 'puntuacion_jugador.dart';
import 'puntuaciones.dart';

const numeroMaximoJugadores = 4;
const numeroMinimoJugadores = 2;
const maximoCartasJugadasRonda2 = 20;
const puntosPorAzul = 3;
const puntosPorVerde = 4;
const puntosPorNegra = 7;
const puntosPorRosa = [
  0,
  1,
  3,
  6,
  10,
  15,
  21,
  28,
  36,
  45,
  55,
  66,
  78,
  91,
  105,
  120,
];

enum FasePuntuacion { ronda1, ronda2, ronda3, desenlace }

///Representa una partida de Ohanami
///

class Partida {
  ///Inicializa la partida con un set de [Jugador]
  ///Tira un [ProblemaNumeroJugadoresMenorMinimo] o [ProblemaNumeroJugadoresMayorMaximo]
  ///Si los jugadores no son diferentes tira un [ProblemaJugadoresRepetidos]

  Partida({required this.jugadores}) {
    if (jugadores.length < numeroMinimoJugadores)
      throw ProblemaNumeroJugadoresMenorMinimo();
    if (jugadores.length > numeroMaximoJugadores)
      throw ProblemaNumeroJugadoresMayorMaximo();
  }

  final Set<Jugador> jugadores;
  List<CartasAPuntuarRonda1> _puntuacionesRonda1 = [];
  List<CartasAPuntuarRonda2> _puntuacionesRonda2 = [];
  List<CartasAPuntuarRonda3> _puntuacionesRonda3 = [];

  List<PuntuacionJugador> puntuaciones(FasePuntuacion ronda) {
    List<PuntuacionJugador> _puntuacionesJugador = [];
    switch (ronda) {
      case FasePuntuacion.ronda1:
        for (var pRonda1 in _puntuacionesRonda1) {
          Jugador jugador = pRonda1.jugador;
          int azules = pRonda1.cuantasAzules;
          _puntuacionesJugador.add(PuntuacionJugador(
              jugador: jugador,
              porAzules: puntosPorAzul * azules,
              porVerdes: 0,
              porRosas: 0,
              porNegras: 0));
        }
        return _puntuacionesJugador;
      case FasePuntuacion.ronda2:
        for (var pRonda2 in _puntuacionesRonda2) {
          _puntuacionesJugador.add(PuntuacionJugador(
              jugador: pRonda2.jugador,
              porAzules: pRonda2.cuantasAzules * puntosPorAzul,
              porVerdes: pRonda2.cuantasVerdes * puntosPorVerde,
              porRosas: 0,
              porNegras: 0));
        }
        return _puntuacionesJugador;
      case FasePuntuacion.ronda3:
        for (var pRonda3 in _puntuacionesRonda3) {
          _puntuacionesJugador.add(PuntuacionJugador(
              jugador: pRonda3.jugador,
              porAzules: pRonda3.cuantasAzules * puntosPorAzul,
              porVerdes: pRonda3.cuantasVerdes * puntosPorVerde,
              porNegras: pRonda3.cuantasNegras * puntosPorNegra,
              porRosas: pRonda3.cuantasRosas > 15
                  ? 120
                  : puntosPorRosa[pRonda3.cuantasRosas]));
        }
        return _puntuacionesJugador;
      case FasePuntuacion.desenlace:
        // list<pjugador> r1 = puntuaciones(fase1);
        // list<pjugador> r1 = puntuaciones(fase1);
        // list<pjugador> r1 = puntuaciones(fase1);
        // r1+r2+r3

        for (Jugador j in jugadores) {
          int total = puntuaciones(FasePuntuacion.ronda1)
                  .firstWhere((element) => element.jugador == j)
                  .total +
              puntuaciones(FasePuntuacion.ronda2)
                  .firstWhere((element) => element.jugador == j)
                  .total +
              puntuaciones(FasePuntuacion.ronda3)
                  .firstWhere((element) => element.jugador == j)
                  .total;
          //PuntuacionJugador p = PuntuacionJugador(jugador: j, porAzules: porAzules, porVerdes: porVerdes, porRosas: porRosas, porNegras: porNegras)
        }

        return [];
    }
  }

  ///Guarda los datos de la primera ronda de puntuación de Ohanami
  ///
  ///En caso de que los jugadores de la puntuacions no coincidan con los
  ///del juego tira [ProblemaJugadoresNoConcuerdan]
  void puntuacionRonda1(List<CartasAPuntuarRonda1> puntuaciones) {
    Set<Jugador> jugadoresR1 = puntuaciones.map((e) => e.jugador).toSet();
    if (!setEquals(jugadores, jugadoresR1))
      throw ProblemaJugadoresNoConcuerdan();

    _puntuacionesRonda1 = puntuaciones;
  }

  ///Guarda los datos de la segunda ronda de puntuación de Ohanami
  ///
  ///En caso de que los jugadores de las puntuaciones no coincida con los del juego
  ///se tira un [ProblemaJugadoresNoConcuerdan]
  ///Si se llama antes de puntuacionRonda1 se manda una excepción
  ///Si los números de las cartas no son los adecuados se pueden tirar otras excepciones
  void puntuacionRonda2(List<CartasAPuntuarRonda2> puntuaciones) {
    if (_puntuacionesRonda1.isEmpty) throw ProblemaOrdenIncorrecto();

    Set<Jugador> jugadoresR2 = puntuaciones.map((e) => e.jugador).toSet();
    if (!setEquals(jugadores, jugadoresR2))
      throw ProblemaJugadoresNoConcuerdan();

    for (CartasAPuntuarRonda2 segundaPuntuacion in puntuaciones) {
      CartasAPuntuarRonda1 primeraPuntuacion = _puntuacionesRonda1.firstWhere(
          (element) => element.jugador == segundaPuntuacion.jugador);
      if (primeraPuntuacion.cuantasAzules > segundaPuntuacion.cuantasAzules) {
        throw ProblemaDisminucionAzules();
      }

      for (CartasAPuntuarRonda2 p in puntuaciones) {
        if (p.cuantasAzules > maximoCartasJugadasRonda2)
          throw ProblemasDemasiadasAzules();
        if (p.cuantasVerdes > maximoCartasJugadasRonda2)
          throw ProblemaDemasiadasVerdes();
        if ((p.cuantasVerdes + p.cuantasAzules) > maximoCartasJugadasRonda2) {
          throw ProblemaExcesoCartas();
        }
      }
    }

    List<int> azulesPasado =
        _puntuacionesRonda1.map((e) => e.cuantasAzules).toList();
    List<int> azulesActuales =
        puntuaciones.map((e) => e.cuantasAzules).toList();
    for (int i = 0; i < azulesActuales.length; i++) {
      if (azulesPasado[i] > azulesActuales[i])
        throw ProblemaDisminucionAzules();
    }

    _puntuacionesRonda2 = puntuaciones;
  }

  void puntuacionRonda3(List<CartasAPuntuarRonda3> puntuaciones) {
    if (_puntuacionesRonda2.isEmpty) throw ProblemaOrdenIncorrecto();

    Set<Jugador> jugadoresR3 = puntuaciones.map((e) => e.jugador).toSet();
    if (!setEquals(jugadores, jugadoresR3))
      throw ProblemaJugadoresNoConcuerdan();
  }
}
