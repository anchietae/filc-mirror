import 'package:firka/helpers/extensions.dart';
import 'package:firka/helpers/ui/firka_card.dart';
import 'package:firka/l10n/app_localizations.dart';
import 'package:firka/ui/model/style.dart';
import 'package:flutter/material.dart';

import '../../../helpers/api/model/timetable.dart';
import '../../widget/class_icon.dart';

class LessonWidget extends StatelessWidget {
  final int? lessonNo;
  final Lesson lesson;

  const LessonWidget(this.lessonNo, this.lesson, {super.key});

  @override
  Widget build(BuildContext context) {
    var isSubstituted = lesson.substituteTeacher != null;
    var isDismissed = lesson.type.name == "UresOra";

    var accent = appStyle.colors.accent;
    var secondary = appStyle.colors.secondary;
    var bgColor = appStyle.colors.a15p;

    if (isSubstituted) {
      accent = appStyle.colors.warningAccent;
      secondary = appStyle.colors.warningText;
      bgColor = appStyle.colors.warning15p;
    }
    if (isDismissed) {
      accent = appStyle.colors.errorAccent;
      secondary = appStyle.colors.errorText;
      bgColor = appStyle.colors.error15p;
    }

    List<Widget> elements = [];

    elements.add(FirkaCard(
      left: [
        Card(
          // TODO: improve this to match design
          shadowColor: Colors.transparent,
          color: bgColor,
          child: Padding(
            padding: EdgeInsets.all(4),
            child: Text(lessonNo.toString(),
                style: appStyle.fonts.B_12R.apply(color: secondary)),
          ),
        ),
        ClassIconWidget(
          color: accent,
          size: 20,
          uid: lesson.uid,
          className: lesson.name,
          category: lesson.subject?.name ?? '',
        ),
        SizedBox(width: 8),
        Text(lesson.subject?.name ?? "N/A",
            style: appStyle.fonts.B_16SB
                .apply(color: appStyle.colors.textPrimary)),
      ],
      right: [
        Text(
            isDismissed
                ? AppLocalizations.of(context)!.class_dismissed
                : lesson.start.toLocal().format(context, FormatMode.hmm),
            style:
                appStyle.fonts.B_14R.apply(color: appStyle.colors.textPrimary)),
        isDismissed
            ? SizedBox()
            : Card(
                shadowColor: Colors.transparent,
                color: appStyle.colors.a15p,
                child: Padding(
                  padding: EdgeInsets.all(4),
                  child: Text(lesson.roomName ?? '?',
                      style: appStyle.fonts.B_12R
                          .apply(color: appStyle.colors.secondary)),
                ),
              ),
      ],
    ));

    if (isSubstituted) {
      elements.add(FirkaCard(
        left: [
          Text(AppLocalizations.of(context)!.class_substitution,
              style: appStyle.fonts.H_14px
                  .apply(color: appStyle.colors.textPrimary))
        ],
        right: [
          Text(lesson.substituteTeacher!,
              style: appStyle.fonts.B_16R
                  .apply(color: appStyle.colors.textSecondary))
        ],
      ));
    }

    elements.add(SizedBox(height: 4));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: elements,
    );
  }
}
