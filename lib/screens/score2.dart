import 'package:ohanami/components/button_start.dart';
import 'package:ohanami/components/best_seller_clipper.dart' as bsc;
import 'package:ohanami/constants.dart';
import 'package:flutter/material.dart';
import 'package:ohanami/paquete_partida/jugador.dart';
import 'package:ohanami/paquete_partida/puntuaciones.dart';
import 'package:ohanami/screens/score.dart';
import 'package:ohanami/screens/score3.dart';

class Score2Screen extends StatefulWidget {
  final List<Jugador> jugadores;
  final List<CartasAPuntuarRonda1> puntuacionesRonda1;
  const Score2Screen(
      {Key? key, required this.jugadores, required this.puntuacionesRonda1})
      : super(key: key);

  @override
  _Score2Screen createState() =>
      _Score2Screen(this.jugadores, this.puntuacionesRonda1);
}

class _Score2Screen extends State<Score2Screen> {
  final List<Jugador> jugadores;
  final List<CartasAPuntuarRonda1> puntuacionesRonda1;
  List<CartasAPuntuarRonda2> puntuacionesRonda2 = [];

  String prueba = '';
  List<int> cartasAzules = [0, 0, 0, 0];
  List<int> cartasVerdes = [0, 0, 0, 0];
  List<Widget> _children = [];

  _Score2Screen(this.jugadores, this.puntuacionesRonda1);

  void inicializaState() {
    for (var i = 0; i < puntuacionesRonda1.length; i++) {
      print("inicializa el estado");
      print(puntuacionesRonda1[i].cuantasAzules);
      setState(() {
        cartasAzules[i] = puntuacionesRonda1[i].cuantasAzules;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inicializaState();
  }

  void recordPlayers() {
    _children = [];
    final int cero = 0;

    for (var i = 0; i < puntuacionesRonda1.length; i++) {
      String playerName = puntuacionesRonda1[i].jugador.nombre;
      _children.add(ScoreJugador(
          number: i + 1,
          title: playerName,
          pressAzules: () => {
                print("primero cartas azules son:: $i"),
                print(cartasAzules),
                print(cartasAzules[i]),
                setState(() {
                  prueba = playerName;
                  cartasAzules[i] = cartasAzules[i] + 1;
                }),
                print("prueba es $prueba"),
                print("suma ahora es " + cartasAzules[i].toString()),
                print(cartasAzules)
              },
          pressVerdes: () => {
                setState(() {
                  prueba = jugadores[i].nombre;
                  cartasVerdes[i] = cartasVerdes[i] + 1;
                }),
                print("prueba es $prueba"),
                print("suma ahora es " + cartasVerdes[i].toString())
              },
          restart: () => {
                setState(() {
                  cartasAzules[i] = cero;
                  cartasVerdes[i] = cero;
                }),
              },
          labelAzul: cartasAzules[i],
          labelVerde: cartasVerdes[i]));
    }
  }

  @override
  Widget build(BuildContext context) {
    recordPlayers();
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFF5F4EF),
          image: DecorationImage(
            image: AssetImage(kUxBig),
            alignment: Alignment.topRight,
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20, top: 50, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 30),
                  ClipPath(
                    clipper: bsc.BestSellerClipper(),
                    child: Container(
                      color: kBestSellerColor,
                      padding: EdgeInsets.only(
                          left: 10, top: 5, right: 20, bottom: 10),
                      child: Text(
                        "SCORE",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text("Ronda 2", style: kHeadingextStyle),
                  SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      SizedBox(width: 40),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            SizedBox(height: 40),
            Expanded(
              child: Container(
                width: double.infinity,
                height: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                ),
                child: Stack(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _children),
                  ),
                  Positioned(
                    right: 0,
                    left: 0,
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 50,
                            color: kTextColor.withOpacity(.1),
                          ),
                        ],
                      ),
                      child: Row(
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () => {
                              print(cartasAzules),
                              for (int i = 0;
                                  i < puntuacionesRonda1.length;
                                  i++)
                                {
                                  print("ahora al hacer el cliclo a enviar"),
                                  print(cartasAzules[i]),
                                  puntuacionesRonda2.add(CartasAPuntuarRonda2(
                                      jugador: puntuacionesRonda1[i].jugador,
                                      cuantasAzules: cartasAzules[i],
                                      cuantasVerdes: cartasVerdes[i]))
                                },
                              for (int i = 0;
                                  i < puntuacionesRonda2.length;
                                  i++)
                                {
                                  print(puntuacionesRonda2[i].jugador.nombre),
                                  print(puntuacionesRonda2[i].cuantasAzules),
                                  print(puntuacionesRonda2[i].cuantasVerdes),
                                },
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return Score3Screen(
                                      jugadores: jugadores,
                                      puntuacionesRonda1: puntuacionesRonda1,
                                      puntuacionesRonda2: puntuacionesRonda2,
                                    );
                                  },
                                ),
                              ),
                            },
                            child: const Text("Siguiente"),
                            style: ElevatedButton.styleFrom(
                                primary: const Color(0xFF6E8AFA),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                fixedSize: const Size(360, 40)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class ScoreJugador extends StatefulWidget {
  final int number;
  final String title;
  final VoidCallback pressAzules;
  final VoidCallback pressVerdes;
  final VoidCallback restart;
  late int labelAzul;
  late int labelVerde;

  ScoreJugador(
      {Key? key,
      required this.number,
      required this.title,
      required this.pressAzules,
      required this.pressVerdes,
      required this.restart,
      required this.labelAzul,
      required this.labelVerde})
      : super(key: key);

  @override
  _ScoreJugadorState createState() => _ScoreJugadorState(
      number, title, pressAzules, pressVerdes, restart, labelAzul, labelVerde);
}

class _ScoreJugadorState extends State<ScoreJugador> {
  final int number;
  final String title;
  final VoidCallback pressAzules;
  final VoidCallback pressVerdes;
  final VoidCallback restart;
  late int labelAzul;
  late int labelVerde;

  _ScoreJugadorState(this.number, this.title, this.pressAzules,
      this.pressVerdes, this.restart, this.labelAzul, this.labelVerde);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        children: <Widget>[
          Text(
            number.toString(),
            style: kHeadingextStyle.copyWith(
              color: kTextColor.withOpacity(.15),
              fontSize: 30,
            ),
          ),
          SizedBox(width: 20),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  style: TextStyle(
                    color: kTextColor.withOpacity(.5),
                    fontSize: 18,
                  ),
                ),
                TextSpan(
                  text: title,
                  style: kSubtitleTextSyule.copyWith(
                    fontWeight: FontWeight.w600,
                    height: 2,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () => {
              setState(() {
                labelAzul = labelAzul + 1;
                pressAzules();
              }),
            },
            child: Text(labelAzul.toString()),
            style: ElevatedButton.styleFrom(
                shape: const CircleBorder(), fixedSize: Size(40, 40)),
          ),
          SizedBox(
            width: 1,
          ),
          ElevatedButton(
            onPressed: () => {
              setState(() {
                labelVerde = labelVerde + 1;
                pressVerdes();
              }),
            },
            child: Text(labelVerde.toString()),
            style: ElevatedButton.styleFrom(
                primary: Colors.green,
                shape: const CircleBorder(),
                fixedSize: Size(40, 40)),
          ),
          SizedBox(
            width: 10,
          ),
          IconButton(
            icon: const Icon(Icons.backspace_outlined),
            color: Colors.grey,
            tooltip: 'Borrar puntuaciones',
            onPressed: () {
              setState(() {
                labelAzul = 0;
                labelVerde = 0;
                restart();
              });
            },
          )
        ],
      ),
    );
  }
}
