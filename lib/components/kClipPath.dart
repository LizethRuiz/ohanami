import 'package:flutter/material.dart';
import 'package:ohanami/components/best_seller_clipper.dart' as bsc;
import '../constants.dart';

class kClipPath extends StatelessWidget {
  const kClipPath({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: bsc.BestSellerClipper(),
      child: Container(
        color: kBestSellerColor,
        padding: EdgeInsets.only(
            left: 10, top: 5, right: 20, bottom: 10),
        child: Text(
          "SCORE",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}