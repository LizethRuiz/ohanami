import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:ohanami/models/players.dart';

class MongoConnection {
  final String PLAYERS = 'players';
  final String GAMES = 'games';
  var db;
  var colPlayer;

  Player lizeth = Player(name: "Diana");

  void connection() async {
    db = await Db.create(
        "mongodb+srv://lizeth:micontra123@cluster0.ipo6k.mongodb.net/myFirstDatabase?retryWrites=true&w=majority");
    await db.open();
    colPlayer = db.collection(PLAYERS);
  }

  void setPlayers() async {
    connection();
    await colPlayer.insert(jsonDecode(lizeth.toJson()));
  }
}
