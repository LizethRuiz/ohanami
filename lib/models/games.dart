import 'package:flutter/material.dart';
import 'package:ohanami/models/players.dart';
import 'package:ohanami/models/rounds.dart';

class Game {
  final List<Player> players;
  final List<Round> rounds;

  Game({Key? key, required this.rounds, required this.players});
}
