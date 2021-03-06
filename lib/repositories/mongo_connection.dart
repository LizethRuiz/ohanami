import 'dart:convert';
import 'dart:io';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:ohanami/models/games.dart';
import 'package:ohanami/models/players.dart';
import 'package:ohanami/models/rounds.dart';
import 'package:ohanami/screens/home.dart';

class RepositorioMongo {
  late Db db;
  String link =
      "mongodb+srv://lizeth:micontra123@cluster0.ns9rk.mongodb.net/myFirstDatabase?retryWrites=true&w=majority";

  Future<bool> inicializar() async {
    bool consultar = false;
    try {
      print("BUSCA CONECTAR A LA BD");
      await Db.create(link).then((value) => consultar = true);
    } on SocketException catch (error) {
      print(error);
      consultar = false;
    }
    return consultar;
  }

  List<Player> players = [];
  List<Ronda> rounds = [];

  @override
  Future<bool> saveGame(
      {required players, required rounds, required date, required uuid}) async {
    print("BUSCA GUARDAR LA PARTIDA");
    db = await Db.create(link);

    await db.open();
    var col = db.collection('games');
    Game partida =
        Game(players: players, rounds: rounds, date: date, uuid: uuid);
    await col.insert(jsonDecode(partida.toJson()));
    return true;
  }

  Future getAllGames() async {
    print("BUSCA TRAER TODAS LAS PARTIDAS");
    db = await Db.create(link);

    await db.open();
    var col = db.collection('games');
    var games = await col.find().toList();

    return games;
  }

  Future getDetailGame(id) async {
    print("BUSCA TRAER DETALLE PARTIDA");
    db = await Db.create(link);

    await db.open();
    var col = db.collection('games');
    var detail = await col.find(where.eq('uuid', id)).toList();
    return detail;
  }
}
