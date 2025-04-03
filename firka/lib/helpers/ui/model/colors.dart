import 'dart:ui';

class Colors {
  Color background;
  Color accent;
  Color primaryText;
  Color card;
  Color grade1;
  Color grade2;
  Color grade3;
  Color grade4;
  Color grade5;
  
  Colors({
    required this.background,
    required this.accent,
    required this.primaryText,
    required this.card,
    required this.grade1,
    required this.grade2,
    required this.grade3,
    required this.grade4,
    required this.grade5
  });

  
}

final Colors defaultColors = Colors(
  background: Color(0xFFFAFFF0),
  accent: Color(0xFFA7DC22),
  primaryText: Color(0xFF394C0A),
  card: Color(0xFFF3FBDE),

  //Grades
  grade1: Color(0xFFFF54A1),
  grade2: Color(0xFFFFA046),
  grade3: Color(0xFFF9CF00),
  grade4: Color(0xFF92EA3B),
  grade5: Color(0xFF22CCAD),
);
Colors colors = defaultColors;