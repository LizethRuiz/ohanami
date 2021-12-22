import 'package:flutter/material.dart';

class Background extends StatefulWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<Background> createState() => _BackgroundState(child);
}

class _BackgroundState extends State<Background> {
  final Widget child;

  _BackgroundState(this.child);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      height: size.height,
      width: double.infinity,
      child: child,
    );
  }
}
