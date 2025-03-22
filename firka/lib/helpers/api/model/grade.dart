import 'package:firka/helpers/api/model/generic.dart';

class Grade {

  final String uid;
  final DateTime recordDate;
  final DateTime creationDate;
  final DateTime? ackDate;
  final Subject subject;
  final String? topic;
  final NameUidDesc type;
  final NameUidDesc? mode;
  final NameUidDesc valueType;
  final String teacher;
  final String? kind;
  final int? numericValue;
  final String strValue;
  final int? weightPercentage;
  final String? shortStrValue;
  final UidObj? classGroup;
  final int sortIndex;


  Grade(
    this.uid,
    this.recordDate,
    this.creationDate,
    this.ackDate,
    this.subject,
    this.topic,
    this.type,
    this.mode,
    this.valueType,
    this.teacher,
    this.kind,
    this.numericValue,
    this.strValue,
    this.weightPercentage,
    this.shortStrValue,
    this.classGroup,
    this.sortIndex
  );

  factory Grade.fromJson(Map<String, dynamic> json) {
    return Grade(
      json['Uid'],
      DateTime.parse(json['RogzitesDatuma']),
      DateTime.parse(json['KeszitesDatuma']),
      json['LattamozasDatuma'] != null
          ? DateTime.parse(json['LattamozasDatuma']) : null,
      Subject.fromJson(json['Tantargy']),
      json['Tema'],
      NameUidDesc.fromJson(json['Tipus']),
      json['Mod'] != null ? NameUidDesc.fromJson(json['Mod']) : null,
      NameUidDesc.fromJson(json['ErtekFajta']),
      json['ErtekeloTanarNeve'],
      json['Kind'],
      json['SzamErtek'],
      json['SzovegesErtek'],
      json['SulySzazalekErteke'],
      json['SzovegesErtekelesRovidNev'],
      json['OsztalyCsoport'] != null ?
        UidObj.fromJson(json['OsztalyCsoport']) : null,
      json['SortIndex'],
    );
  }

  @override
  String toString() {
    return "Grade("
      "uid: \"$uid\", "
      "recordDate: \"$recordDate\", "
      "creationDate: \"$creationDate\", "
      "ackDate: \"${ackDate ?? 'null'}\", "
      "subject: $subject, "
      "topic: \"${topic ?? 'null'}\", "
      "type: $type, "
      "mode: ${mode ?? 'null'}, "
      "valueType: $valueType, "
      "teacher: \"$teacher\", "
      "kind: \"${kind ?? 'null'}\", "
      "numericValue: ${numericValue ?? 'null'}, "
      "strValue: \"$strValue\", "
      "weightPercentage: ${weightPercentage ?? 'null'}, "
      "shortStrValue: \"${shortStrValue ?? 'null'}\", "
      "classGroup: ${classGroup ?? 'null'}, "
      "sortIndex: $sortIndex"
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
    this.sortIndex
  );

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      json['Uid'],
      json['Nev'],
      NameUidDesc.fromJson(json['Kategoria']),
      json['SortIndex']
    );
  }
}
