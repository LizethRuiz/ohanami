import 'package:flutter/material.dart';
import 'package:ohanami/components/backgroud.dart';
import 'package:ohanami/components/button_start.dart';
import 'package:ohanami/screens/add_players.dart';
import 'package:ohanami/constants.dart';

import 'list_games.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Background(
            child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          child: Image.asset(
            kOhanami,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            const Text("Ohanami",
                style: TextStyle(
                    fontSize: 37.0, fontFamily: "Lato", color: Colors.grey)),
            ButtonStart(
              text: "Ver mis partidas",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ListGameScreen();
                    },
                  ),
                );
              },
              width: 300.0,
              height: 60.0,
            ),
            ButtonStart(
              text: "Agregar partida",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return PlayersScreen();
                    },
                  ),
                );
              },
              width: 300.0,
              height: 60.0,
            )
          ],
        )
      ],
    )));
  }
}
