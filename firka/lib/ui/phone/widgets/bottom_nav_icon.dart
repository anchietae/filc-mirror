import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:majesticons_flutter/majesticons_flutter.dart';

import '../../model/style.dart';

class BottomNavIcon extends StatelessWidget {
  void Function() onTap;
  bool active;
  Uint8List icon;
  String text;
  Color iconColor;
  Color textColor;

  BottomNavIcon(this.onTap, this.active, this.icon, this.text, this.iconColor,
      this.textColor,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          onTap();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Majesticon(icon, color: iconColor, size: 24).build(context),
              const SizedBox(height: 4),
              Text(
                text,
                style: active ? appStyle.fonts.B_12SB : appStyle.fonts.B_12R,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
