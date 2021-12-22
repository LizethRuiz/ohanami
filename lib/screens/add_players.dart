import 'package:flutter/material.dart';
import 'package:ohanami/blocs/partida_bloc.dart';
import 'package:ohanami/components/backgroud.dart';
import 'package:ohanami/components/button.dart';
import 'package:ohanami/components/button_start.dart';
import 'package:ohanami/components/rounded_input_field.dart';
import 'package:ohanami/models/players.dart';
import 'package:ohanami/paquete_partida/jugador.dart';
import 'package:ohanami/screens/score1.dart';
import 'package:flutter_svg/svg.dart';

class PlayersScreen extends StatefulWidget {
  PlayersScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PlayersScreen> createState() => _PlayersScreenState();
}

class _PlayersScreenState extends State<PlayersScreen> {
  List<Jugador> players = [];
  List<String> playersState = ['', '', '', ''];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //SizedBox(height: 200),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: 200,
            ),
            RoundedInputField(
              hintText: "Jugador 1",
              onChanged: (value) {
                setState(() {
                  playersState[0] = value;
                });
              },
            ),
            RoundedInputField(
              hintText: "Jugador 2",
              onChanged: (value) {
                setState(() {
                  playersState[1] = value;
                });
              },
            ),
            RoundedInputField(
              hintText: "Jugador 3",
              onChanged: (value) {
                setState(() {
                  playersState[2] = value;
                });
              },
            ),
            RoundedInputField(
              hintText: "Jugador 4",
              onChanged: (value) {
                setState(() {
                  playersState[3] = value;
                });
              },
            ),
            RoundedButton(
                text: "Siguiente",
                press: () => {
                      for (int i = 0; i < playersState.length; i++)
                        {
                          if (playersState[i] != '')
                            {
                              players.add(Jugador(nombre: playersState[i])),
                            }
                        },
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Score1Screen(jugadores: players);
                          },
                        ),
                      ),
                    })
          ],
        ),
      ),
    ));
  }
}
