import 'package:flutter/material.dart';

import '../../ui/model/style.dart';

class FirkaCard extends StatelessWidget {

  List<Widget> left;
  Widget? right;

  FirkaCard({required this.left, this.right, super.key});

  @override
  Widget build(BuildContext context) {
    if (right == null) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Card(
          color: appStyle.colors.card,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: left,
            ),
          ),
        ),
      );
    } else {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Card(
          color: appStyle.colors.card,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...left,
                right!,
              ],
            ),
          ),
        ),
      );
    }
  }

}