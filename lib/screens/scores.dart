import 'package:ohanami/constants.dart';
import 'package:flutter/material.dart';
import 'package:ohanami/paquete_partida/jugador.dart';
import 'package:ohanami/paquete_partida/puntuaciones.dart';

class Score1Screen extends StatefulWidget {
  final List<Jugador> jugadores;
  const Score1Screen({Key? key, required this.jugadores}) : super(key: key);

  @override
  _Score1Screen createState() => _Score1Screen(this.jugadores);
}

class _Score1Screen extends State<Score1Screen> {
  final List<Jugador> jugadores;
  late List<PRonda1> puntuacionesRonda1 = [];
  String prueba = '';
  int sum = 1;
  List<int> suma = [];
  List<Widget> _children = [];

  _Score1Screen(this.jugadores);

  void recorre() {
    _children = [];

    for (var i = 0; i < jugadores.length; i++) {
      puntuacionesRonda1.add(PRonda1(
          jugador: Jugador(nombre: jugadores[i].nombre), cuantasAzules: 0));
      print(jugadores[i].nombre);
      _children.add(ScoreJugador(
          number: i + 1,
          title: jugadores[i].nombre,
          press: () => {
                setState(() {
                  prueba = jugadores[i].nombre;
                  sum = sum + 1;
                }),
                print("prueba es $prueba"),
                print("suma ahora es $sum")
              },
          label: sum));
    }
  }

  @override
  Widget build(BuildContext context) {
    recorre();
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
                child: Stack(
                  children: <Widget>[
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
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: kBlueColor,
                                ),
                                child: Text(
                                  "Siguiente",
                                  style: kSubtitleTextSyule.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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
  late int label;

  ScoreJugador(
      {Key? key,
      required this.number,
      required this.title,
      required this.press,
      required this.label})
      : super(key: key);

  @override
  _ScoreJugadorState createState() =>
      _ScoreJugadorState(number, title, press, label);
}

class _ScoreJugadorState extends State<ScoreJugador> {
  final int number;
  final String title;
  final VoidCallback press;
  late int label;

  _ScoreJugadorState(this.number, this.title, this.press, this.label);

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
          FloatingActionButton.extended(
              onPressed: () => {
                    setState(() {
                      label = label + 1;
                      press();
                    }),
                  },
              backgroundColor: Colors.green,
              //child: const Icon(Icons.navigation),
              //mini: true,
              label: Text(label.toString())),
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
