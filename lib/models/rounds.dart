import 'dart:convert';

import 'package:ohanami/models/players.dart';

class Ronda {
  final int num;
  final int azules;
  final int verdes;
  final int negras;
  final int rosas;
  final int total;
  final Player player;

  Ronda({
    required this.num,
    required this.azules,
    required this.verdes,
    required this.negras,
    required this.rosas,
    required this.total,
    required this.player,
  });

  Ronda copyWith({
    int? num,
    int? azules,
    int? verdes,
    int? negras,
    int? rosas,
    int? total,
    Player? player,
  }) {
    return Ronda(
      num: num ?? this.num,
      azules: azules ?? this.azules,
      verdes: verdes ?? this.verdes,
      negras: negras ?? this.negras,
      rosas: rosas ?? this.rosas,
      total: total ?? this.total,
      player: player ?? this.player,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'num': num,
      'azules': azules,
      'verdes': verdes,
      'negras': negras,
      'rosas': rosas,
      'total': total,
      'player': player.toMap(),
    };
  }

  factory Ronda.fromMap(Map<String, dynamic> map) {
    return Ronda(
      num: map['num']?.toInt() ?? 0,
      azules: map['azules']?.toInt() ?? 0,
      verdes: map['verdes']?.toInt() ?? 0,
      negras: map['negras']?.toInt() ?? 0,
      rosas: map['rosas']?.toInt() ?? 0,
      total: map['total']?.toInt() ?? 0,
      player: Player.fromMap(map['player']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Ronda.fromJson(String source) => Ronda.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Ronda(num: $num, azules: $azules, verdes: $verdes, negras: $negras, rosas: $rosas, total: $total, player: $player)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Ronda &&
        other.num == num &&
        other.azules == azules &&
        other.verdes == verdes &&
        other.negras == negras &&
        other.rosas == rosas &&
        other.total == total &&
        other.player == player;
  }

  @override
  int get hashCode {
    return num.hashCode ^
        azules.hashCode ^
        verdes.hashCode ^
        negras.hashCode ^
        rosas.hashCode ^
        total.hashCode ^
        player.hashCode;
  }
}
