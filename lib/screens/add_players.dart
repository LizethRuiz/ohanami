import 'package:flutter/material.dart';
import 'package:ohanami/components/backgroud.dart';
import 'package:ohanami/components/button.dart';
import 'package:ohanami/components/button_start.dart';
import 'package:ohanami/components/rounded_input_field.dart';
import 'package:ohanami/screens/add_scores.dart';

class PlayersScreen extends StatefulWidget {
  const PlayersScreen({Key? key}) : super(key: key);

  @override
  _PlayersScreenState createState() => _PlayersScreenState();
}

class _PlayersScreenState extends State<PlayersScreen> {
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
              RoundedInputField(
                hintText: "Jugador 1",
                onChanged: (value) {},
              ),
              RoundedInputField(
                hintText: "Jugador 2",
                onChanged: (value) {},
              ),
              RoundedInputField(
                hintText: "Jugador 3",
                onChanged: (value) {},
              ),
              RoundedInputField(
                hintText: "Jugador 4",
                onChanged: (value) {},
              ),
              RoundedButton(
                text: "Siguiente",
                press: () => {
                  print("clic en siguientee"),
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const AddScoreScreen();
                      },
                    ),
                  ),
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
