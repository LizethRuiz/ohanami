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
        List<PuntuacionJugador> r1 = puntuaciones(FasePuntuacion.ronda1);
        List<PuntuacionJugador> r2 = puntuaciones(FasePuntuacion.ronda2);
        List<PuntuacionJugador> r3 = puntuaciones(FasePuntuacion.ronda3);
        int totalAzules = 0;
        int totalVerdes = 0;
        int totalNegras = 0;
        int totalRosas = 0;

        for (Jugador j in jugadores) {
          var totalAzules = puntuaciones(FasePuntuacion.ronda3)
              .firstWhere((element) => element.jugador == j)
              .porAzules;
          totalVerdes = puntuaciones(FasePuntuacion.ronda3)
              .firstWhere((element) => element.jugador == j)
              .porVerdes;
          totalNegras = puntuaciones(FasePuntuacion.ronda3)
              .firstWhere((element) => element.jugador == j)
              .porNegras;
          totalRosas = puntuaciones(FasePuntuacion.ronda3)
              .firstWhere((element) => element.jugador == j)
              .porRosas;

          _puntuacionesJugador.add(PuntuacionJugador(
              jugador: j,
              porAzules: totalAzules,
              porVerdes: totalVerdes,
              porRosas: totalRosas,
              porNegras: totalNegras));
        }

        return _puntuacionesJugador;
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

    if (!setEquals(jugadores, puntuaciones.map((e) => e.jugador).toSet()))
      throw ProblemaJugadoresNoConcuerdan();

    for (CartasAPuntuarRonda3 terceraPuntuacion in puntuaciones) {
      CartasAPuntuarRonda2 segundaPuntuacion = _puntuacionesRonda2.firstWhere(
          (element) => element.jugador == terceraPuntuacion.jugador);
      if (segundaPuntuacion.cuantasAzules > terceraPuntuacion.cuantasAzules) {
        throw ProblemaDisminucionAzules();
      }
      /*if(segundaPuntuacion.cuantasVerdes > terceraPuntuacion.cuantasVerdes) {
        throw ProblemaDisminucionVerdes();
      }*/
    }

    /*for(CartasAPuntuarRonda3 p in puntuaciones){
      if(p.cuantasAzules > maximoCartasJugadasRonda3) throw ProblemaDemasiadosAzules();
      if(p.cuantasVerdes > maximoCartasJugadasRonda3) throw ProblemaDemasiadosVerdes();
    }*/

    _puntuacionesRonda3 = puntuaciones;
  }
}
