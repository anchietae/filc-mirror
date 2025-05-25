import 'package:firka/helpers/api/model/grade.dart';
import 'package:firka/helpers/api/model/subject.dart';
import 'package:firka/helpers/ui/firka_card.dart';
import 'package:firka/ui/widget/class_icon_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/style.dart';

class GradeSmallCard extends FirkaCard {

  final List<Grade> grades;
  final Subject subject;

  GradeSmallCard(this.grades, this.subject, {super.key}) : super(left: [
    ClassIconWidget(
      uid: subject.uid,
      className: subject.name,
      category: subject.category.name!,
      color: appStyle.colors.accent,
    ),
    SizedBox(width: 4,),
    Text(
      subject.name,
      style: appStyle.fonts.B_16SB.apply(
          color: appStyle.colors.textPrimary
      ),
    )
  ]);

}