import 'package:flutter/material.dart';
import 'package:ohanami/components/backgroud.dart';
import 'package:ohanami/components/button.dart';
import 'package:ohanami/components/button_start.dart';
import 'package:ohanami/components/rounded_input_field.dart';
import 'package:ohanami/paquete_partida/jugador.dart';

class AddScoreScreen extends StatefulWidget {
  final List<Jugador> jugadores;
  const AddScoreScreen({Key? key, required this.jugadores}) : super(key: key);

  @override
  _AddScoreState createState() => _AddScoreState(this.jugadores);
}

class _AddScoreState extends State<AddScoreScreen> {
  final List<Jugador> jugadores;
  List<Widget> _children = [];

  _AddScoreState(this.jugadores);

  @override
  void recorre() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            const Background(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                const Text("Ronda 1",
                    style: TextStyle(
                        fontSize: 30.0,
                        fontFamily: "Lato",
                        color: Colors.grey)),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const Text("Jugador 1",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: "Lato",
                                  color: Colors.grey)),
                        ],
                      ),
                      Column(
                        children: [
                          FloatingActionButton(
                            onPressed: () => {},
                            tooltip: 'cartas_azules',
                            child: Text('1'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Text("Ronda 2",
                    style: TextStyle(
                        fontSize: 30.0,
                        fontFamily: "Lato",
                        color: Colors.grey)),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const Text("Jugador 1",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: "Lato",
                                  color: Colors.grey)),
                        ],
                      ),
                      Column(
                        children: [
                          FloatingActionButton(
                            onPressed: () => {},
                            tooltip: 'cartas_azules',
                            child: Text('1'),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          FloatingActionButton(
                            onPressed: () => {},
                            tooltip: 'cartas_verdes',
                            backgroundColor: Colors.greenAccent,
                            child: Text('1'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Text("Ronda 3",
                    style: TextStyle(
                        fontSize: 30.0,
                        fontFamily: "Lato",
                        color: Colors.grey)),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const Text("Jugador 1",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: "Lato",
                                  color: Colors.grey)),
                        ],
                      ),
                      Column(
                        children: [
                          FloatingActionButton(
                            onPressed: () => {},
                            tooltip: 'cartas_azules',
                            child: Text('1'),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          FloatingActionButton(
                            onPressed: () => {},
                            tooltip: 'cartas_verdes',
                            backgroundColor: Colors.greenAccent,
                            child: Text('1'),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          FloatingActionButton(
                            onPressed: () => {},
                            tooltip: 'cartas_negras',
                            backgroundColor: Colors.black,
                            child: Text('1'),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          FloatingActionButton(
                            onPressed: () => {},
                            tooltip: 'cartas_negras',
                            backgroundColor: Colors.pink,
                            child: Text('1'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                RoundedButton(
                  text: "Guardar",
                  press: () => {},
                )
              ],
            )
          ],
        ),
        resizeToAvoidBottomInset: true);
  }
}
