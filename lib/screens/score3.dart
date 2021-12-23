import 'package:ohanami/components/button_start.dart';
import 'package:ohanami/components/best_seller_clipper.dart' as bsc;
import 'package:ohanami/constants.dart';
import 'package:flutter/material.dart';
import 'package:ohanami/models/players.dart';
import 'package:ohanami/models/rounds.dart';
import 'package:ohanami/paquete_partida/jugador.dart';
import 'package:ohanami/paquete_partida/partida.dart';
import 'package:ohanami/paquete_partida/puntuaciones.dart';
import 'package:ohanami/repositories/mongo_connection.dart';
import 'package:ohanami/screens/home.dart';
import 'package:ohanami/screens/list_games.dart';
import 'package:ohanami/screens/score.dart';
import 'package:ohanami/screens/score2.dart';

class Score3Screen extends StatefulWidget {
  final List<Jugador> jugadores;
  final List<CartasAPuntuarRonda1> puntuacionesRonda1;
  final List<CartasAPuntuarRonda2> puntuacionesRonda2;
  const Score3Screen(
      {Key? key,
      required this.jugadores,
      required this.puntuacionesRonda1,
      required this.puntuacionesRonda2})
      : super(key: key);

  @override
  _Score3Screen createState() => _Score3Screen(
      this.jugadores, this.puntuacionesRonda1, this.puntuacionesRonda2);
}

class _Score3Screen extends State<Score3Screen> {
  List<Jugador> jugadores;
  final List<CartasAPuntuarRonda1> puntuacionesRonda1;
  final List<CartasAPuntuarRonda2> puntuacionesRonda2;
  List<CartasAPuntuarRonda3> puntuacionesRonda3 = [];
  var conexion;
  var newGame;
  bool connected = false;

  String prueba = '';
  int sum = 1;
  List<int> cartasAzules = [0, 0, 0, 0];
  List<int> cartasVerdes = [0, 0, 0, 0];
  List<int> cartasNegras = [0, 0, 0, 0];
  List<int> cartasRosas = [0, 0, 0, 0];
  List<Widget> _children = [];

  _Score3Screen(
      this.jugadores, this.puntuacionesRonda1, this.puntuacionesRonda2);

  void saveGame() async {
    RepositorioMongo conexion = RepositorioMongo();
    connected = await conexion.inicializar();
    print(connected);
    if (connected == true) {
      print("SE CREO CONEXION CON LA BD");
      //await conexion.saveGame();
    }
  }

  void inicializaState() {
    for (var i = 0; i < puntuacionesRonda2.length; i++) {
      setState(() {
        for (var i = 0; i < puntuacionesRonda2.length; i++) {
          cartasAzules[i] = puntuacionesRonda2[i].cuantasAzules;
          cartasVerdes[i] = puntuacionesRonda2[i].cuantasVerdes;
        }
      });
    }
  }

  validaPartida() async {
    List<Player> players = [];
    List<Ronda> rondas = [];
    Partida newGame = Partida(jugadores: jugadores.toSet());
    for (int j = 0; j < jugadores.length; j++) {
      players.add(Player(name: jugadores[j].nombre));
    }
    newGame.puntuacionRonda1(puntuacionesRonda1);
    newGame.puntuacionRonda2(puntuacionesRonda2);
    newGame.puntuacionRonda3(puntuacionesRonda3);
    var puntuacionSumaRonda1 = newGame.puntuaciones(FasePuntuacion.ronda1);
    var puntuacionSumaRonda2 = newGame.puntuaciones(FasePuntuacion.ronda2);
    var puntuacionSumaRonda3 = newGame.puntuaciones(FasePuntuacion.ronda3);
    var puntuacionSumaDesenlace =
        newGame.puntuaciones(FasePuntuacion.desenlace);
    for (int i = 0; i < puntuacionSumaRonda1.length; i++) {
      rondas.add(Ronda(
          num: 1,
          azules: puntuacionSumaRonda1[i].porAzules,
          verdes: 0,
          negras: 0,
          rosas: 0,
          total: 0,
          player: Player(name: puntuacionSumaRonda1[i].jugador.nombre)));
    }
    for (int i = 0; i < puntuacionSumaRonda2.length; i++) {
      rondas.add(Ronda(
          num: 2,
          azules: puntuacionSumaRonda2[i].porAzules,
          verdes: puntuacionSumaRonda2[i].porVerdes,
          negras: 0,
          rosas: 0,
          total: 0,
          player: Player(name: puntuacionSumaRonda2[i].jugador.nombre)));
    }
    for (int i = 0; i < puntuacionSumaRonda3.length; i++) {
      rondas.add(Ronda(
          num: 3,
          azules: puntuacionSumaRonda3[i].porAzules,
          verdes: puntuacionSumaRonda3[i].porVerdes,
          negras: puntuacionSumaRonda3[i].porNegras,
          rosas: puntuacionSumaRonda3[i].porRosas,
          total: 0,
          player: Player(name: puntuacionSumaRonda3[i].jugador.nombre)));
    }
    for (int i = 0; i < puntuacionSumaDesenlace.length; i++) {
      rondas.add(Ronda(
          num: 4,
          azules: puntuacionSumaDesenlace[i].porAzules,
          verdes: puntuacionSumaDesenlace[i].porVerdes,
          negras: puntuacionSumaDesenlace[i].porNegras,
          rosas: puntuacionSumaDesenlace[i].porRosas,
          total: puntuacionSumaDesenlace[i].total,
          player: Player(name: puntuacionSumaDesenlace[i].jugador.nombre)));
    }
    RepositorioMongo conexion = RepositorioMongo();
    return await conexion.saveGame(players: players, rounds: rondas) == true
        ? Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ListGameScreen();
              },
            ),
          )
        : print("no se guardo partida");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inicializaState();
  }

  void recordPlayers() {
    _children = [];

    for (var i = 0; i < puntuacionesRonda2.length; i++) {
      String playerName = puntuacionesRonda2[i].jugador.nombre;
      _children.add(ScoreJugador(
          number: i + 1,
          title: playerName,
          pressAzules: () => {
                setState(() {
                  prueba = playerName;
                  cartasAzules[i] = puntuacionesRonda1[i].cuantasAzules + 1;
                }),
                print("prueba es $prueba"),
                print("suma ahora es " + cartasAzules[i].toString())
              },
          pressVerdes: () => {
                setState(() {
                  prueba = jugadores[i].nombre;
                  cartasVerdes[i] = cartasVerdes[i] + 1;
                }),
                print("prueba es $prueba"),
                print("suma ahora es " + cartasVerdes[i].toString())
              },
          pressNegras: () => {
                setState(() {
                  prueba = jugadores[i].nombre;
                  cartasNegras[i] = cartasNegras[i] + 1;
                }),
                print("prueba es $prueba"),
                print("suma ahora es " + cartasVerdes[i].toString())
              },
          pressRosas: () => {
                setState(() {
                  prueba = jugadores[i].nombre;
                  cartasRosas[i] = cartasRosas[i] + 1;
                }),
                print("prueba es $prueba"),
                print("suma ahora es " + cartasVerdes[i].toString())
              },
          restart: () => {
                setState(() {
                  cartasAzules[i] = 0;
                  cartasVerdes[i] = 0;
                  cartasNegras[i] = 0;
                  cartasRosas[i] = 0;
                }),
              },
          labelAzul: cartasAzules[i],
          labelVerde: cartasVerdes[i],
          labelNegras: cartasNegras[i],
          labelRosas: cartasRosas[i]));
    }
  }

  @override
  Widget build(BuildContext context) {
    recordPlayers();
    RepositorioMongo newConnection;
    Partida newGame;
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
                  Text("Ronda 3", style: kHeadingextStyle),
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
                              print("dio clic"),
                              //saveGame(),
                              for (int i = 0;
                                  i < puntuacionesRonda2.length;
                                  i++)
                                {
                                  puntuacionesRonda3.add(CartasAPuntuarRonda3(
                                      jugador: puntuacionesRonda2[i].jugador,
                                      cuantasAzules: cartasAzules[i],
                                      cuantasVerdes: cartasVerdes[i],
                                      cuantasNegras: cartasNegras[i],
                                      cuantasRosas: cartasRosas[i]))
                                },
                              validaPartida()
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
  final VoidCallback pressNegras;
  final VoidCallback pressRosas;
  final VoidCallback restart;
  late int labelAzul;
  late int labelVerde;
  late int labelNegras;
  late int labelRosas;

  ScoreJugador({
    Key? key,
    required this.number,
    required this.title,
    required this.pressAzules,
    required this.pressVerdes,
    required this.pressNegras,
    required this.pressRosas,
    required this.restart,
    required this.labelAzul,
    required this.labelVerde,
    required this.labelNegras,
    required this.labelRosas,
  }) : super(key: key);

  @override
  _ScoreJugadorState createState() => _ScoreJugadorState(
      number,
      title,
      pressAzules,
      pressVerdes,
      pressNegras,
      pressRosas,
      restart,
      labelAzul,
      labelVerde,
      labelNegras,
      labelRosas);
}

class _ScoreJugadorState extends State<ScoreJugador> {
  final int number;
  final String title;
  final VoidCallback pressAzules;
  final VoidCallback pressVerdes;
  final VoidCallback pressNegras;
  final VoidCallback pressRosas;
  final VoidCallback restart;
  late int labelAzul;
  late int labelVerde;
  late int labelNegras;
  late int labelRosas;

  _ScoreJugadorState(
      this.number,
      this.title,
      this.pressAzules,
      this.pressVerdes,
      this.pressNegras,
      this.pressRosas,
      this.restart,
      this.labelAzul,
      this.labelVerde,
      this.labelNegras,
      this.labelRosas);

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
                      labelAzul = labelAzul + 1;
                      pressAzules();
                    }),
                  },
              backgroundColor: Colors.blue,
              //child: const Icon(Icons.navigation),
              //mini: true,
              label: Text(labelAzul.toString())),
          FloatingActionButton.extended(
              onPressed: () => {
                    setState(() {
                      labelVerde = labelVerde + 1;
                      pressVerdes();
                    }),
                  },
              backgroundColor: Colors.green,
              //mini: true,
              label: Text(labelVerde.toString())),
          FloatingActionButton.extended(
              onPressed: () => {
                    setState(() {
                      labelNegras = labelNegras + 1;
                      pressNegras();
                    }),
                  },
              backgroundColor: Colors.black,
              //mini: true,
              label: Text(labelNegras.toString())),
          FloatingActionButton.extended(
              onPressed: () => {
                    setState(() {
                      labelRosas = labelRosas + 1;
                      pressRosas();
                    }),
                  },
              backgroundColor: Colors.pink,
              elevation: 1.0,
              //mini: true,
              label: Text(labelRosas.toString())),
          IconButton(
            icon: const Icon(Icons.backspace_outlined),
            color: Colors.grey,
            tooltip: 'Borrar puntuaciones',
            onPressed: () {
              setState(() {
                labelAzul = 0;
                labelVerde = 0;
                labelNegras = 0;
                labelRosas = 0;
                restart();
              });
            },
          )
        ],
      ),
    );
  }
}
