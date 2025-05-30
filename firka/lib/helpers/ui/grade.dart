import 'package:firka/helpers/api/model/grade.dart';
import 'package:flutter/material.dart';

import '../../ui/model/style.dart';
import 'grade_helpers.dart';

class GradeWidget extends StatelessWidget {
  final Grade grade;

  const GradeWidget(this.grade, {super.key});

  @override
  Widget build(BuildContext context) {
    Color gradeColor = appStyle.colors.grade1;
    var gradeStr = grade.numericValue?.toString() ?? "0";

    if (grade.valueType.name == "Szazalekos") {
      gradeStr = grade.strValue;
      if (grade.numericValue != null) {
        gradeColor =
            getGradeColor(percentageToGrade(grade.numericValue!).toDouble());
      }
    } else {
      if (grade.numericValue != null) {
        gradeColor = getGradeColor(grade.numericValue!.toDouble());
      }
    }

    return Card(
      shape: CircleBorder(eccentricity: 1.0),
      shadowColor: Colors.transparent,
      color: gradeColor.withAlpha(38),
      child: Padding(
          padding: EdgeInsets.only(left: 8, right: 8),
          child: Text(gradeStr,
              style: appStyle.fonts.H_H1
                  .copyWith(fontSize: 24, color: gradeColor))),
    );
  }
}
