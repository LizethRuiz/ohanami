import 'package:flutter/material.dart';
import 'package:ohanami/blocs/partida_bloc.dart';
import 'package:ohanami/components/backgroud.dart';
import 'package:ohanami/components/button.dart';
import 'package:ohanami/components/button_start.dart';
import 'package:ohanami/components/rounded_input_field.dart';
import 'package:ohanami/models/players.dart';
import 'package:ohanami/paquete_partida/jugador.dart';
import 'package:ohanami/screens/add_scores.dart';
import 'package:ohanami/screens/scores.dart';

class PlayersScreen extends StatefulWidget {
  const PlayersScreen({Key? key}) : super(key: key);

  @override
  _PlayersScreenState createState() => _PlayersScreenState();
}

class _PlayersScreenState extends State<PlayersScreen> {
  late String player1 = '', player2 = '', player3 = '', player4 = '';
  List<Jugador> jugadores = [];

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
                onChanged: (value) {
                  setState(() {
                    player1 = value;
                  });
                },
              ),
              RoundedInputField(
                hintText: "Jugador 2",
                onChanged: (value) {
                  setState(() {
                    player2 = value;
                  });
                },
              ),
              RoundedInputField(
                hintText: "Jugador 3",
                onChanged: (value) {
                  setState(() {
                    player3 = value;
                  });
                },
              ),
              RoundedInputField(
                hintText: "Jugador 4",
                onChanged: (value) {
                  setState(() {
                    player4 = value;
                  });
                },
              ),
              RoundedButton(
                text: "Siguiente",
                press: () => {
                  print("clic en siguientee"),
                  if (player1 != '')
                    {
                      jugadores.add(Jugador(nombre: player1)),
                    },
                  if (player2 != '')
                    {
                      jugadores.add(Jugador(nombre: player2)),
                    },
                  if (player3 != '')
                    {
                      jugadores.add(Jugador(nombre: player3)),
                    },
                  if (player4 != '')
                    {
                      jugadores.add(Jugador(nombre: player4)),
                    },
                  //partidaBloc.setPlayerData(Player(name: "DANIEL")),
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Score1Screen(
                          jugadores: jugadores,
                        );
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
