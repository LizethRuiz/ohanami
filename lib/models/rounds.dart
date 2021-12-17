import 'package:flutter/material.dart';
import 'package:ohanami/models/players.dart';

class Round {
  final int num;
  final int azules;
  final int verdes;
  final int negras;
  final int rosas;
  final Player player;

  Round(
      this.num, this.azules, this.verdes, this.negras, this.rosas, this.player);
}
