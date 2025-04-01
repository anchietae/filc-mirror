import 'dart:ui';

class WearColors {

  Color backgroundColor;
  Color ambientBackgroundColor;
  Color radiusColor;
  Color primaryText;
  Color secondaryText;
  Color tertiaryText;

  WearColors({
    required this.backgroundColor,
    required this.ambientBackgroundColor,
    required this.radiusColor,
    required this.primaryText,
    required this.secondaryText,
    required this.tertiaryText
  });

}

WearColors defaultColors = WearColors(
  backgroundColor: Color(0xff0c1201),
  ambientBackgroundColor: Color(0xff000000),
  radiusColor: Color(0xffa6dc22),
  primaryText: Color(0xffcbee71),
  secondaryText: Color(0xffe9f7cb),
  tertiaryText: Color(0xffa7b290),
);