import 'package:flutter_test/flutter_test.dart';
import 'package:ohanami/paquete_partida/jugador.dart';
import 'package:ohanami/paquete_partida/problemas.dart';

void main() {
  group('Jugador', () {
    test('debe de tener nombre no vacío', () {
      expect(() => Jugador(nombre: ''),
          throwsA(TypeMatcher<ProblemaNombreJugadorVacio>()));
    });
    test('mismo nombre, mismo id', () {
      Jugador j1 = Jugador(nombre: 'Paco');
      Jugador j2 = Jugador(nombre: 'Paco');
      expect(j1, equals(j2));
    });
    test('diferente nombre, diferentes instancias', () {
      Jugador j1 = Jugador(nombre: 'Paco');
      Jugador j2 = Jugador(nombre: 'Juan');
      expect(j1, isNot(equals(j2)));
    });
  });
}
