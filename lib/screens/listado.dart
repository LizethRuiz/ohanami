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

class ListaPartidas extends StatefulWidget {
  ListaPartidas({
    Key? key,
  }) : super(key: key);

  @override
  State<ListaPartidas> createState() => _ListaPartidasState();
}

class _ListaPartidasState extends State<ListaPartidas> {
  final titles = ["Jugadores", "Jugadores", "Jugadores"];
  final subtitles = [
    "Jugador 1",
    "Jugador 2",
    "Jugador 3"
  ];
  final icons = [Icons.ac_unit, Icons.access_alarm, Icons.access_time];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(
                  onTap: () {},
                  title: Text(titles[index]),
                  subtitle: Text(subtitles[index]),
                  trailing: 
                    FlatButton(
                      child: Icon(Icons.delete),
                      textColor: Colors.white,
                      color: Colors.red,
                      onPressed: (){},
                      shape: CircleBorder(),
                      ),                  
                  ));
        });
  }
}