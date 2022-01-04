import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:ohanami/models/players.dart';
import 'package:ohanami/models/rounds.dart';

class Game {
  final List<Player> players;
  final List<Ronda> rounds;
  final String date;
  final String uuid;

  Game({
    required this.players,
    required this.rounds,
    required this.date,
    required this.uuid,
  });

  Game copyWith({
    List<Player>? players,
    List<Ronda>? rounds,
    String? date,
    String? uuid,
  }) {
    return Game(
      players: players ?? this.players,
      rounds: rounds ?? this.rounds,
      date: date ?? this.date,
      uuid: uuid ?? this.uuid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'players': players.map((x) => x.toMap()).toList(),
      'rounds': rounds.map((x) => x.toMap()).toList(),
      'date': date,
      'uuid': uuid,
    };
  }

  factory Game.fromMap(Map<String, dynamic> map) {
    return Game(
      players: List<Player>.from(map['players']?.map((x) => Player.fromMap(x))),
      rounds: List<Ronda>.from(map['rounds']?.map((x) => Ronda.fromMap(x))),
      date: map['date'] ?? '',
      uuid: map['uuid'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Game.fromJson(String source) => Game.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Game(players: $players, rounds: $rounds, date: $date, uuid: $uuid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Game &&
        listEquals(other.players, players) &&
        listEquals(other.rounds, rounds) &&
        other.date == date &&
        other.uuid == uuid;
  }

  @override
  int get hashCode {
    return players.hashCode ^ rounds.hashCode ^ date.hashCode ^ uuid.hashCode;
  }
}
