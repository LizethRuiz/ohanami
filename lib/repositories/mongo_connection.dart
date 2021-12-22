import 'dart:convert';
import 'dart:io';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:ohanami/models/games.dart';
import 'package:ohanami/models/players.dart';
import 'package:ohanami/models/rounds.dart';

class RepositorioMongo {
  late Db db;

  Future<bool> inicializar() async {
    bool consultar = false;
    try {
      print("BUSCA CONECTAR A LA BD");
      await Db.create(
              "mongodb+srv://lizeth:micontra123@cluster0.ipo6k.mongodb.net/myFirstDatabase?retryWrites=true&w=majority")
          .then((value) => consultar = true);
    } on SocketException catch (_) {
      consultar = false;
    }
    return consultar;
  }

  @override
  Future<bool> saveGame() async {
    print("BUSCA GUARDAR LA PARTIDA");
    db = await Db.create(
        "mongodb+srv://lizeth:micontra123@cluster0.kzjpr.mongodb.net/myFirstDatabase?retryWrites=true&w=majority");
    List<Player> players = [];
    List<Ronda> rounds = [];
    await db.open();
    var col = db.collection('games');
    Player lizeth = Player(name: "lizeth");
    // ignore: unused_local_variable
    Ronda ronda = Ronda(
        num: 1, azules: 1, verdes: 1, negras: 1, rosas: 1, player: lizeth);
    players.add(lizeth);
    rounds.add(ronda);
    Game partida = Game(players: players, rounds: rounds);
    await col.insert(jsonDecode(partida.toJson()));
    return true;
  }
}
