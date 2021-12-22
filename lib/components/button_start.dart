import 'package:flutter/material.dart';
import 'package:ohanami/constants.dart';

class ButtonStart extends StatefulWidget {
  final String text;
  double width = 0.0;
  double height = 0.0;
  VoidCallback onPressed;

  ButtonStart(
      {required this.text,
      required this.onPressed,
      required this.height,
      required this.width});

  @override
  State createState() => _ButtonStart();
}

class _ButtonStart extends State<ButtonStart> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: widget.onPressed,
        child: Container(
            margin: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                gradient: const LinearGradient(
                    colors: [kBlueColor, kBlueColor],
                    begin: FractionalOffset(0.2, 0.0),
                    end: FractionalOffset(1.0, 0.6),
                    stops: [0.0, 0.6],
                    tileMode: TileMode.clamp)),
            child: Center(
              child: Text(widget.text,
                  style: const TextStyle(
                      fontSize: 18.0, fontFamily: "Lato", color: Colors.white)),
            )));
  }
}
