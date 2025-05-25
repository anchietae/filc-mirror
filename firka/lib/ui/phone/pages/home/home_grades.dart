import 'package:firka/helpers/ui/firka_card.dart';
import 'package:firka/helpers/ui/stateless_async_widget.dart';
import 'package:firka/ui/widget/grade_small_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../helpers/api/model/subject.dart';
import '../../../../main.dart';
import '../../../model/style.dart';

class HomeGradesScreen extends StatelessAsyncWidget {

  final AppInitialization data;
  const HomeGradesScreen(this.data, {super.key});

  @override
  Future<Widget> buildAsync(BuildContext context) async {

    var now = DateTime.now();
    var start = now.subtract(Duration(days: now.weekday - 1));
    var end = start.add(Duration(days: 6));

    var grades = await data.client.getGrades();
    var subjectAvgs = <String, double>{};
    var gradeAvg = 0.00;
    var week = await data.client.getTimeTable(start, end);
    final List<Subject> subjects = List<Subject>.empty(growable: true);
    final List<Widget> gradeCards = [];

    for (var grade in grades.response!) {
      if (subjects.where((s) => s.uid == grade.subject.uid).isEmpty) {
        subjects.add(grade.subject);
      }
    }

    subjects.sort((s1, s2) => s1.name.compareTo(s2.name));

    for (var subject in subjects) {
      gradeCards.add(GradeSmallCard(grades.response!, subject));

      var weightTotal = 0.00;
      for (var grade in grades.response!) {
        if (grade.subject.uid == subject.uid) {
          if (grade.numericValue != null) {
            var weight = (grade.weightPercentage ?? 100) / 100.0;
            weightTotal += weight;

            subjectAvgs[subject.uid] = (subjectAvgs[subject.uid] ?? 0)
              + grade.numericValue! * weight;
          }
        }
      }
      subjectAvgs[subject.uid] = (subjectAvgs[subject.uid] ?? 0) / weightTotal;
    }

    for (var n in subjectAvgs.values) {
      gradeAvg += n;
    }
    gradeAvg /= subjectAvgs.length;

    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.subjects,
                  style: appStyle.fonts.H_H2.apply(
                      color: appStyle.colors.textSecondary
                  ),
                )
              ],
            ),
            SizedBox(height: 16), // TODO: Add graphs here
            // ...gradeCards,
            Container(
              height: MediaQuery.of(context).size.height
                  - MediaQuery.of(context).padding.top
                  - 230,
              child: ListView(
                children: [
                  Text(
                    AppLocalizations.of(context)!.your_subjects,
                    style: appStyle.fonts.B_16SB.apply(
                      color: appStyle.colors.textSecondary
                    ),
                  ),
                  SizedBox(height: 16),
                  ...gradeCards,
                  SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context)!.data,
                    style: appStyle.fonts.B_16SB.apply(
                      color: appStyle.colors.textSecondary
                    ),
                  ),
                  SizedBox(height: 16),
                  FirkaCard(
                    left: [
                      Text(
                        AppLocalizations.of(context)!.subject_avg,
                        style: appStyle.fonts.B_16SB.apply(
                            color: appStyle.colors.textPrimary
                        ),
                      ),
                    ],
                    right: Text(
                      gradeAvg.toStringAsFixed(2),
                      style: appStyle.fonts.B_16SB.apply(
                          color: appStyle.colors.textPrimary
                      ),
                    ),
                  ),
                  FirkaCard(left: [
                    Text(
                      AppLocalizations.of(context)!.class_avg,
                      style: appStyle.fonts.B_16SB.apply(
                        color: appStyle.colors.textPrimary
                      ),
                    ),
                  ]),
                  FirkaCard(
                    left: [
                      Text(
                        AppLocalizations.of(context)!.class_n,
                        style: appStyle.fonts.B_16SB.apply(
                            color: appStyle.colors.textPrimary
                        ),
                      ),
                    ],
                    right: Text(
                      week.response!.length.toString(),
                      style: appStyle.fonts.B_16SB.apply(
                        color: appStyle.colors.textPrimary
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}