import 'dart:convert';

import 'package:flutter/material.dart';

class Player {
  final String name;

  Player({
    required this.name,
  });

  Player copyWith({
    String? name,
  }) {
    return Player(
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Player.fromJson(String source) => Player.fromMap(json.decode(source));

  @override
  String toString() => 'Player(name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Player && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
