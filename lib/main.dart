import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:ohanami/screens/home.dart';

import 'blocs/bloc_partida.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        child: const MaterialApp(
          title: 'Ohanami',
          home: MyHomePage(),
        ),
        bloc: PartidaBloc());
  }
}
