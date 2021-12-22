import 'package:flutter/material.dart';

import 'package:ohanami/paquete_partida/jugador.dart';
import 'package:ohanami/paquete_partida/puntuaciones.dart';
import 'package:ohanami/screens/score1.dart';
import 'package:ohanami/components/best_seller_clipper.dart' as bsc;

import '../constants.dart';

class Score extends StatefulWidget {
  const Score({
    Key? key,
    required this.children,
  }) : super(key: key);

  final List<Widget> children;

  @override
  State<Score> createState() => _ScoreState(children: []);
}

class _ScoreState extends State<Score> {
  late List<Widget> children;

  _ScoreState({
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
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
                  Text("Ronda 1", style: kHeadingextStyle),
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
                child: Stack(children: children),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
