import 'package:firka/helpers/api/model/generic.dart';

class Lesson {
  final String uid;
  final String date;
  final DateTime start;
  final DateTime end;
  final String name;
  final int? lessonNumber;
  final int? lessonSeqNumber;
  final NameUid classGroup;
  final String teacher;
  final NameUidDesc subject;
  final String? theme;
  final String roomName;
  final NameUidDesc type;
  final NameUidDesc studentPresence;
  final NameUidDesc state;
  final String? substituteTeacher;
  final String? homeworkUid;
  final String? taskGroupUid;
  final String? languageTaskGroupUid;
  final String? assessmentUid;
  final bool canStudentEditHomework;
  final bool isHomeworkComplete;
  final List<dynamic> attachments;
  final bool isDigitalLesson;
  final String? digitalDeviceList;
  final String? digitalPlatformType;
  final List<String> digitalSupportDeviceTypeList;
  final DateTime createdAt;
  final DateTime lastModifiedAt;

  Lesson(
    this.uid,
    this.date,
    this.start,
    this.end,
    this.name,
    this.lessonNumber,
    this.lessonSeqNumber,
    this.classGroup,
    this.teacher,
    this.subject,
    this.theme,
    this.roomName,
    this.type,
    this.studentPresence,
    this.state,
    this.substituteTeacher,
    this.homeworkUid,
    this.taskGroupUid,
    this.languageTaskGroupUid,
    this.assessmentUid,
    this.canStudentEditHomework,
    this.isHomeworkComplete,
    this.attachments,
    this.isDigitalLesson,
    this.digitalDeviceList,
    this.digitalPlatformType,
    this.digitalSupportDeviceTypeList,
    this.createdAt,
    this.lastModifiedAt,
  );

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      json['Uid'],
      json['Datum'],
      DateTime.parse(json['KezdetIdopont']),
      DateTime.parse(json['VegIdopont']),
      json['Nev'],
      json['Oraszam'],
      json['OraEvesSorszama'],
      NameUid.fromJson(json['OsztalyCsoport']),
      json['TanarNeve'],
      NameUidDesc.fromJson(json['Tantargy']),
      json['Tema'],
      json['TeremNeve'],
      NameUidDesc.fromJson(json['Tipus']),
      NameUidDesc.fromJson(json['TanuloJelenlet']),
      NameUidDesc.fromJson(json['Allapot']),
      json['HelyettesTanarNeve'],
      json['HaziFeladatUid'],
      json['FeladatGroupUid'],
      json['NyelviFeladatGroupUid'],
      json['BejelentettSzamonkeresUid'],
      json['IsTanuloHaziFeladatEnabled'],
      json['IsHaziFeladatMegoldva'],
      json['Csatolmanyok'],
      json['IsDigitalisOra'],
      json['DigitalisEszkozTipus'],
      json['DigitalisPlatformTipus'],
      List<String>.from(json['DigitalisTamogatoEszkozTipusList']),
      DateTime.parse(json['Letrehozas']),
      DateTime.parse(json['UtolsoModositas']),
    );
  }

  @override
  String toString() {
    return "TanitasiOra("
      "uid: \"$uid\", "
      "date: \"$date\", "
      "start: $start, "
      "end: $end, "
      "name: \"$name\", "
      "lessonNumber: $lessonNumber, "
      "lessonSeqNumber: $lessonSeqNumber, "
      "classGroup: $classGroup, "
      "teacher: \"$teacher\", "
      "subject: $subject, "
      "theme: \"$theme\", "
      "roomName: \"$roomName\", "
      "type: $type, "
      "studentPresence: $studentPresence, "
      "state: $state, "
      "substituteTeacher: \"$substituteTeacher\", "
      "homeworkUid: \"$homeworkUid\", "
      "taskGroupUid: \"$taskGroupUid\", "
      "languageTaskGroupUid: \"$languageTaskGroupUid\", "
      "assessmentUid: \"$assessmentUid\", "
      "canStudentEditHomework: $canStudentEditHomework, "
      "isHomeworkComplete: $isHomeworkComplete, "
      "attachments: $attachments, "
      "isDigitalLesson: $isDigitalLesson, "
      "digitalDeviceList: \"$digitalDeviceList\", "
      "digitalPlatformType: \"$digitalPlatformType\", "
      "digitalSupportDeviceTypeList: $digitalSupportDeviceTypeList, "
      "create: $createdAt, "
      "lastModified: $lastModifiedAt"
    ")";
  }
}

class Subject {
  final String uid;
  final String name;
  final NameUidDesc category;
  final int sortIndex;

  Subject(
      this.uid,
      this.name,
      this.category,
      this.sortIndex,
      );

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      json['Uid'],
      json['Nev'],
      NameUidDesc.fromJson(json['Kategoria']),
      json['SortIndex'],
    );
  }

  @override
  String toString() {
    return "Subject("
      "uid: \"$uid\", "
      "name: \"$name\", "
      "category: $category, "
      "sortIndex: $sortIndex"
    ")";
  }
}