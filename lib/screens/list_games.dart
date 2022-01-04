import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ohanami/constants.dart';
import 'package:ohanami/repositories/mongo_connection.dart';
import 'package:ohanami/screens/players_summary.dart';

class ListGameScreen extends StatefulWidget {
  @override
  State<ListGameScreen> createState() => _ListGameScreenState();
}

class _ListGameScreenState extends State<ListGameScreen> {
  final List<Widget> _children = [];

  Future getGames() async {
    RepositorioMongo conexion = RepositorioMongo();
    var allGames = await conexion.getAllGames();
    List ganador = [];
    bool space = false;
    setState(() {
      for (var i = 0; i < allGames.length; i++) {
        var puntosGanador = 0;
        var jugadorGanador = '';
        var rondas = allGames[i]['rounds'];
        var fecha = allGames[i]['date'];
        for (var j = 0; j < rondas.length; j++) {
          if (rondas[j]['num'] == 4 && rondas[j]['total'] > puntosGanador) {
            puntosGanador = rondas[j]['total'];
            jugadorGanador = rondas[j]['player']['name'];
          }
        }
        _children.add(Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          padding: EdgeInsets.all(10),
          height: 90,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 17),
                blurRadius: 23,
                spreadRadius: -13,
                color: kShadowColor,
              ),
            ],
          ),
          child: Row(
            children: <Widget>[
              SvgPicture.asset(
                "assets/icons/fiesta.svg",
                height: 50,
                width: 50,
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "$jugadorGanador",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Text("Alcanzo los $puntosGanador puntos"),
                    Text("$fecha")
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    color: Colors.pink,
                    tooltip: 'Siguiente',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PlayersSummaryScreen(gameId: allGames[i]['uuid']),
                        ),
                      );
                    },
                  )),
            ],
          ),
        ));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getGames();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * 100,
            decoration: BoxDecoration(
              color: kBackGameColor,
              image: DecorationImage(
                image: AssetImage("assets/images/ganadores.png"),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _children,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
