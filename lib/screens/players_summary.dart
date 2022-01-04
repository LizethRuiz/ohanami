import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ohanami/constants.dart';
import 'package:ohanami/repositories/mongo_connection.dart';

class PlayersSummaryScreen extends StatefulWidget {
  final String gameId;

  const PlayersSummaryScreen({Key? key, required this.gameId})
      : super(key: key);

  @override
  State<PlayersSummaryScreen> createState() =>
      _PlayersSummaryScreenState(this.gameId);
}

class _PlayersSummaryScreenState extends State<PlayersSummaryScreen> {
  final String gameId;
  final List<Widget> _children = [];

  _PlayersSummaryScreenState(this.gameId);

  Future getDetailGame() async {
    RepositorioMongo conexion = RepositorioMongo();
    var detailGames = await conexion.getDetailGame(gameId);

    for (int i = 0; i < detailGames.length; i++) {
      var name = '';
      var puntos = '';

      for (int j = 0; j < detailGames[i]['players'].length; j++) {
        var rondas = detailGames[i]['rounds'];
        for (int k = 0; k < rondas.length; k++) {
          var player = detailGames[i]['players'][j];
          var name = rondas[k]['player']['name'];
          if (rondas[k]['num'] == 4 && player['name'] == name) {
            var puntos = rondas[k]['total'];
            var azules = rondas[k]['azules'];
            var verdes = rondas[k]['verdes'];
            var negras = rondas[k]['negras'];
            var rosas = rondas[k]['rosas'];
            setState(() {
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
                      "assets/icons/star.svg",
                      height: 30,
                      width: 30,
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "$name",
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Text("Total $puntos puntos"),
                        ],
                      ),
                    ),
                    FloatingActionButton.extended(
                        onPressed: () => {
                              setState(() {}),
                            },
                        backgroundColor: Colors.blue,
                        label: Text(azules.toString())),
                    FloatingActionButton.extended(
                        onPressed: () => {
                              setState(() {}),
                            },
                        backgroundColor: Colors.green,
                        label: Text(verdes.toString())),
                    FloatingActionButton.extended(
                        onPressed: () => {
                              setState(() {}),
                            },
                        backgroundColor: Colors.black,
                        label: Text(negras.toString())),
                    FloatingActionButton.extended(
                        onPressed: () => {
                              setState(() {}),
                            },
                        backgroundColor: Colors.pink,
                        label: Text(rosas.toString())),
                  ],
                ),
              ));
            });
          }
        }
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetailGame();
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
              color: kBestSellerColor,
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
