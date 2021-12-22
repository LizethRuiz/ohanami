import 'dart:convert';
import 'dart:io';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:ohanami/models/games.dart';
import 'package:ohanami/models/players.dart';
import 'package:ohanami/models/rounds.dart';
import 'package:ohanami/screens/home.dart';

class RepositorioMongo {
  late Db db;

  Future<bool> inicializar() async {
    bool consultar = false;
    try {
      print("BUSCA CONECTAR A LA BD");
      await Db.create(
              "mongodb+srv://lizeth:micontra123@cluster0.lcjl8.mongodb.net/myFirstDatabase?retryWrites=true&w=majority")
          .then((value) => consultar = true);
    } on SocketException catch (_) {
      consultar = false;
    }
    return consultar;
  }

  List<Player> players = [];
  List<Ronda> rounds = [];

  @override
  Future<bool> saveGame({required players, required rounds}) async {
    print("BUSCA GUARDAR LA PARTIDA");
    db = await Db.create(
        "mongodb+srv://lizeth:micontra123@cluster0.lcjl8.mongodb.net/myFirstDatabase?retryWrites=true&w=majority");

    await db.open();
    var col = db.collection('games');
    Game partida = Game(players: players, rounds: rounds);
    await col.insert(jsonDecode(partida.toJson()));
    return true;
  }
}
