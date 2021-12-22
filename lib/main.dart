import 'package:flutter/material.dart';
import 'package:ohanami/screens/home.dart';
import 'package:ohanami/screens/score1.dart';

import 'blocs/partida_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Ohanami',
      home: MyHomePage(),
    );
  }
}
