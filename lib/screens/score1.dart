import 'package:ohanami/components/button_start.dart';
import 'package:ohanami/constants.dart';
import 'package:flutter/material.dart';
import 'package:ohanami/paquete_partida/jugador.dart';
import 'package:ohanami/paquete_partida/puntuaciones.dart';
import 'package:ohanami/screens/score.dart';
import 'package:ohanami/screens/score2.dart';

class Score1Screen extends StatefulWidget {
  final List<Jugador> jugadores;
  const Score1Screen({Key? key, required this.jugadores}) : super(key: key);

  @override
  _Score1Screen createState() => _Score1Screen(this.jugadores);
}

class _Score1Screen extends State<Score1Screen> {
  final List<Jugador> jugadores;
  late List<CartasAPuntuarRonda1> puntuacionesRonda1 = [];

  String prueba = '';
  List<int> suma = [0, 0, 0, 0];
  List<Widget> _children = [];

  _Score1Screen(this.jugadores);

  void recordPlayers() {
    _children = [];

    for (var i = 0; i < jugadores.length; i++) {
      _children.add(ScoreJugador(
          number: i + 1,
          title: jugadores[i].nombre,
          press: () => {
                setState(() {
                  prueba = jugadores[i].nombre;
                  suma[i] = suma[i] + 1;
                }),
                print("prueba es $prueba"),
                print("suma ahora es " + suma[i].toString())
              },
          restart: () => {
                setState(() {
                  suma[i] = 0;
                }),
              },
          label: suma[i]));
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
            image: AssetImage("assets/images/ux_big.png"),
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
                    clipper: BestSellerClipper(),
                    child: Container(
                      color: kBestSellerColor,
                      padding: EdgeInsets.only(
                          left: 10, top: 5, right: 20, bottom: 10),
                      child: Text(
                        "Score".toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text("Ronda 1", style: kHeadingextStyle),
                  SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      SizedBox(width: 10),
                      SizedBox(width: 20),
                      SizedBox(width: 10),
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
                              for (int i = 0; i < jugadores.length; i++)
                                {
                                  print(jugadores[i].nombre),
                                  puntuacionesRonda1.add(CartasAPuntuarRonda1(
                                      jugador: jugadores[i],
                                      cuantasAzules: suma[i]))
                                },
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return Score2Screen(
                                      jugadores: jugadores,
                                      puntuacionesRonda1: puntuacionesRonda1,
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
  final VoidCallback press;
  final VoidCallback restart;
  late int label;

  ScoreJugador(
      {Key? key,
      required this.number,
      required this.title,
      required this.press,
      required this.restart,
      required this.label})
      : super(key: key);

  @override
  _ScoreJugadorState createState() =>
      _ScoreJugadorState(number, title, press, restart, label);
}

class _ScoreJugadorState extends State<ScoreJugador> {
  final int number;
  final String title;
  final VoidCallback press;
  final VoidCallback restart;
  late int label;

  _ScoreJugadorState(
      this.number, this.title, this.press, this.restart, this.label);

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
                label = label + 1;
                press();
              }),
            },
            child: Text(label.toString()),
            style: ElevatedButton.styleFrom(
                shape: const CircleBorder(), fixedSize: Size(40, 40)),
          ),
          SizedBox(
            width: 15,
          ),
          IconButton(
            icon: const Icon(Icons.backspace_outlined),
            color: Colors.grey,
            tooltip: 'Delete score player',
            onPressed: () {
              setState(() {
                label = 0;
                restart();
              });
            },
          )
        ],
      ),
    );
  }
}

class BestSellerClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = Path();
    path.lineTo(size.width - 20, 0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width - 20, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}
