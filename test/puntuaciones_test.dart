import 'package:flutter_test/flutter_test.dart';
import 'package:ohanami/paquete_partida/jugador.dart';
import 'package:ohanami/paquete_partida/problemas.dart';
import 'package:ohanami/paquete_partida/puntuaciones.dart';

void main() {
  group('Puntuacion Ronda 1', () {
    late Jugador jugador;
    setUp(() {
      jugador = Jugador(nombre: 'x');
    });
    test('La cantidad de azules  debe ser cero o mayor', () {
      expect(() => CartasAPuntuarRonda1(jugador: jugador, cuantasAzules: -1),
          throwsA(TypeMatcher<ProblemaAzulesNegativas>()));
    });
    test('Maximo azules es 10', () {
      expect(() => CartasAPuntuarRonda1(jugador: jugador, cuantasAzules: 11),
          throwsA(TypeMatcher<ProblemasDemasiadasAzules>()));
    });
    test('Cantidad entre 1 y 10 esta bien', () {
      expect(() => CartasAPuntuarRonda1(jugador: jugador, cuantasAzules: 3),
          returnsNormally);
    });
  });

  group('Puntuacion Ronda 2', () {
    late Jugador jugador;
    setUp(() {
      jugador = Jugador(nombre: 'Pancho');
    });

    test('Cartas azules no deben ser negativas', () {
      expect(
          () => CartasAPuntuarRonda2(
              jugador: jugador, cuantasAzules: -1, cuantasVerdes: 0),
          throwsA(TypeMatcher<ProblemaAzulesNegativas>()));
    });
    test('Se aceptan numeros positivos de cartas azules', () {
      expect(
          () => CartasAPuntuarRonda2(
              jugador: jugador, cuantasAzules: 3, cuantasVerdes: 3),
          returnsNormally);
    });
    test('Cartas verdes deben ser positivas', () {
      expect(
          () => CartasAPuntuarRonda2(
              jugador: jugador, cuantasAzules: 3, cuantasVerdes: 0),
          returnsNormally);
    });
    test('Cartas verdes no deben ser negativas', () {
      expect(
          () => CartasAPuntuarRonda2(
              jugador: jugador, cuantasAzules: 0, cuantasVerdes: -1),
          throwsA(TypeMatcher<ProblemaVerdesNegativas>()));
    });
  });

  group('Puntuaciones Ronda 3', () {
    late Jugador j1;
    setUp(() {
      j1 = Jugador(nombre: 'Juan');
    });
    test('Se acepta solo  número de cartas positivas', () {
      expect(
          () => CartasAPuntuarRonda3(
              jugador: j1,
              cuantasVerdes: 0,
              cuantasAzules: 0,
              cuantasNegras: 0,
              cuantasRosas: 0),
          returnsNormally);
    });
    test('No se acepta número de cartas negativas', () {
      expect(
          () => CartasAPuntuarRonda3(
              jugador: j1,
              cuantasVerdes: -1,
              cuantasAzules: 0,
              cuantasNegras: 0,
              cuantasRosas: 0),
          throwsA(TypeMatcher<ProblemaVerdesNegativas>()));
      expect(
          () => CartasAPuntuarRonda3(
              jugador: j1,
              cuantasVerdes: 0,
              cuantasAzules: -1,
              cuantasNegras: 0,
              cuantasRosas: 0),
          throwsA(TypeMatcher<ProblemaAzulesNegativas>()));
      expect(
          () => CartasAPuntuarRonda3(
              jugador: j1,
              cuantasVerdes: 0,
              cuantasAzules: 0,
              cuantasNegras: -1,
              cuantasRosas: 0),
          throwsA(TypeMatcher<ProblemaNegrasNegativas>()));
      expect(
          () => CartasAPuntuarRonda3(
              jugador: j1,
              cuantasVerdes: 0,
              cuantasAzules: 0,
              cuantasNegras: 0,
              cuantasRosas: -1),
          throwsA(TypeMatcher<ProblemaRosasNegativas>()));
    });
  });
}
