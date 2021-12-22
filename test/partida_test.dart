import 'package:flutter_test/flutter_test.dart';
import 'package:ohanami/paquete_partida/jugador.dart';
import 'package:ohanami/paquete_partida/partida.dart';
import 'package:ohanami/paquete_partida/problemas.dart';
import 'package:ohanami/paquete_partida/puntuaciones.dart';

void main() {
  group('Partidas', () {
    late Jugador j1, j2, j3, j4, j5;

    setUp(() {
      j1 = Jugador(nombre: 'juan');
      j2 = Jugador(nombre: 'Pancho');
      j3 = Jugador(nombre: 'Paco');
      j5 = Jugador(nombre: 'Maria');
      j4 = Jugador(nombre: 'Pepe');
    });
    test('debe de tener al menos dos jugadores', () {
      expect(() => Partida(jugadores: {j1}),
          throwsA(TypeMatcher<ProblemaNumeroJugadoresMenorMinimo>()));
    });

    test('debe de tener maximo 4 jugadores', () {
      expect(() => Partida(jugadores: {j1, j2, j3, j4, j5}),
          throwsA(TypeMatcher<ProblemaNumeroJugadoresMayorMaximo>()));
    });

    test('con dos jugadores está bien', () {
      expect(() => Partida(jugadores: {j1, j2}), returnsNormally);
    });
  });

  group('Puntuaciones Ronda 1', () {
    late Jugador j1, j2, j3;
    late CartasAPuntuarRonda1 p1, p2, p3;
    setUp(() {
      j1 = Jugador(nombre: 'Pancho');
      j2 = Jugador(nombre: 'Paco');
      j3 = Jugador(nombre: 'Pedro');

      p1 = CartasAPuntuarRonda1(jugador: j1, cuantasAzules: 3);
      p3 = CartasAPuntuarRonda1(jugador: j3, cuantasAzules: 5);
      p2 = CartasAPuntuarRonda1(jugador: j2, cuantasAzules: 6);
    });
    test('Jugadores diferentes no se debe', () {
      Partida p = Partida(jugadores: {j1, j2});

      expect(() => p.puntuacionRonda1([p1, p3]),
          throwsA(TypeMatcher<ProblemaJugadoresNoConcuerdan>()));
    });
    test('Jugadores deben concordar', () {
      Partida p = Partida(jugadores: {j1, j2});
      expect(() => p.puntuacionRonda1([p1, p2]), returnsNormally);
    });
  });

  group('Puntuaciones Ronda 2', () {
    late Jugador j1, j2, j3;
    late CartasAPuntuarRonda2 p21, p22, p23;
    late CartasAPuntuarRonda1 p11, p12;
    late CartasAPuntuarRonda1 p11mal, p12mal;

    setUp(() {
      j1 = Jugador(nombre: 'Pancho');
      j2 = Jugador(nombre: 'Paco');
      j3 = Jugador(nombre: 'Pepe');

      p11 = CartasAPuntuarRonda1(jugador: j1, cuantasAzules: 0);
      p12 = CartasAPuntuarRonda1(jugador: j2, cuantasAzules: 0);
      //p13 = PRonda1(jugador: j3, cuantasAzules: 7);

      p11mal = CartasAPuntuarRonda1(jugador: j1, cuantasAzules: 10);
      p12mal = CartasAPuntuarRonda1(jugador: j2, cuantasAzules: 10);

      p21 =
          CartasAPuntuarRonda2(jugador: j1, cuantasAzules: 1, cuantasVerdes: 1);
      p22 =
          CartasAPuntuarRonda2(jugador: j2, cuantasAzules: 2, cuantasVerdes: 2);
      p23 =
          CartasAPuntuarRonda2(jugador: j3, cuantasAzules: 1, cuantasVerdes: 1);
    });
    test('Jugadores diferentes manda error', () {
      Partida p = Partida(jugadores: {j1, j2});
      p.puntuacionRonda1([p11, p12]);
      expect(() => p.puntuacionRonda2([p21, p23]),
          throwsA(TypeMatcher<ProblemaJugadoresNoConcuerdan>()));
    });
    test('Jugadores si concuerdan', () {
      Partida p = Partida(jugadores: {j1, j2});
      p.puntuacionRonda1([p11, p12]);
      expect(() => p.puntuacionRonda2([p21, p22]), returnsNormally);
    });

    test('Debe ser llamado despues de puntuacion ronda 1', () {
      Partida p = Partida(jugadores: {j1, j2});
      expect(() => p.puntuacionRonda2([p21, p22]),
          throwsA(TypeMatcher<ProblemaOrdenIncorrecto>()));
    });
    test('Cartas azules no deben ser menores a el número anterior', () {
      Partida p = Partida(jugadores: {j1, j2});
      p.puntuacionRonda1([p11mal, p12mal]);
      expect(() => p.puntuacionRonda2([p21, p22]),
          throwsA(TypeMatcher<ProblemaDisminucionAzules>()));
    });
    test('Cartas azules pueden ser iguales o mayores al número anterior', () {
      Partida p = Partida(jugadores: {j1, j2});
      p.puntuacionRonda1([p11, p12]);
      expect(() => p.puntuacionRonda2([p21, p22]), returnsNormally);
    });
    test('Cartas azules deben ser iguales o mayores', () {
      Partida p = Partida(jugadores: {j1, j2});
      p.puntuacionRonda1([p11, p12]);
      expect(() => p.puntuacionRonda2([p21, p22]), returnsNormally);
    });

    test('Maximo de cartas azules es 20', () {
      Partida p = Partida(jugadores: {j1, j2});
      p.puntuacionRonda1([p11, p12]);
      expect(
          () => p.puntuacionRonda2([
                CartasAPuntuarRonda2(
                    jugador: j1, cuantasAzules: 21, cuantasVerdes: 0),
                CartasAPuntuarRonda2(
                    jugador: j2, cuantasAzules: 0, cuantasVerdes: 0)
              ]),
          throwsA(TypeMatcher<ProblemasDemasiadasAzules>()));
    });
    test('Maximo de cartas verdes es 20', () {
      Partida p = Partida(jugadores: {j1, j2});
      p.puntuacionRonda1([p11, p12]);
      expect(
          () => p.puntuacionRonda2([
                CartasAPuntuarRonda2(
                    jugador: j1, cuantasAzules: 1, cuantasVerdes: 30),
                CartasAPuntuarRonda2(
                    jugador: j2, cuantasAzules: 0, cuantasVerdes: 0)
              ]),
          throwsA(TypeMatcher<ProblemaDemasiadasVerdes>()));
    });
    test('Máximo de ambas cartas debe de ser 20', () {
      Partida p = Partida(jugadores: {j1, j2});
      p.puntuacionRonda1([p11, p12]);
      expect(
          () => p.puntuacionRonda2([
                CartasAPuntuarRonda2(
                    jugador: j1, cuantasAzules: 11, cuantasVerdes: 11),
                CartasAPuntuarRonda2(
                    jugador: j2, cuantasAzules: 0, cuantasVerdes: 0)
              ]),
          throwsA(TypeMatcher<ProblemaExcesoCartas>()));
    });
  });

  group('Puntuaciones Ronda 3', () {
    late Jugador j1, j2, j3;
    late CartasAPuntuarRonda3 j1p3, j2p3, j3p3;
    late CartasAPuntuarRonda2 j1p2, j2p2;
    late CartasAPuntuarRonda1 j1p1, j2p1;
    late Partida p;
    setUp(() {
      j1 = Jugador(nombre: 'Juan');
      j2 = Jugador(nombre: 'Pancho');
      j3 = Jugador(nombre: 'Paco');

      p = Partida(jugadores: {j1, j2});

      j1p1 = CartasAPuntuarRonda1(jugador: j1, cuantasAzules: 0);
      j2p1 = CartasAPuntuarRonda1(jugador: j2, cuantasAzules: 0);

      j1p2 =
          CartasAPuntuarRonda2(jugador: j1, cuantasAzules: 0, cuantasVerdes: 0);
      j2p2 =
          CartasAPuntuarRonda2(jugador: j1, cuantasAzules: 0, cuantasVerdes: 0);

      j1p3 = CartasAPuntuarRonda3(
          jugador: j1,
          cuantasVerdes: 0,
          cuantasAzules: 0,
          cuantasNegras: 0,
          cuantasRosas: 0);
      j2p3 = CartasAPuntuarRonda3(
          jugador: j3,
          cuantasVerdes: 0,
          cuantasAzules: 0,
          cuantasNegras: 0,
          cuantasRosas: 0);
      j3p3 = CartasAPuntuarRonda3(
          jugador: j3,
          cuantasVerdes: 0,
          cuantasAzules: 0,
          cuantasNegras: 0,
          cuantasRosas: 0);
    });
    test('Debe de ser llamado despues de puntuacionRonda2', () {
      expect(() => p.puntuacionRonda3([j1p3, j2p3]),
          throwsA(TypeMatcher<ProblemaOrdenIncorrecto>()));
    });

    /*test('orden correcto, llamada puntuacionRonda3', () {

      p.puntuacionRonda1([j1p1,j2p1]);
      p.puntuacionRonda2([j1p2,j2p22]);

      expect(()=>p.puntuacionRonda3([j1p3,j3p33]), returnsNormally);
      
    });*/

    /*test('jugadores diferentes deben de mandar error', () {
      p.puntuacionRonda1([j1p1, j2p1]);
      p.puntuacionRonda2([j1p2, j2p2]);
      expect(() => p.puntuacionRonda3([j1p3, j3p3]),
          throwsA(TypeMatcher<ProblemaJugadoresNoConcuerdan>()));
    });*/
    /*test('jugadores si concuerdan es correcto', () {
      p.puntuacionRonda1([j1p1, j2p1]);
      p.puntuacionRonda2([j1p2, j2p2]);
      expect(() => p.puntuacionRonda3([j1p3, j2p3]), returnsNormally);
    });*/
  });
}
