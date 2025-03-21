class Grade {

  final String uid;
  final String recordDate;
  final String creationDate;
  final String? ackDate;
  final Subject subject;
  final String? topic;
  final GradeType type;
  final GradeMode? mode;
  final GradeValueType valueType;
  final String teacher;
  final String? kind;
  final int? numericValue;
  final String strValue;
  final int? weightPercentage;
  final String? shortStrValue;
  final ClassGroup? classGroup;
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
      json['RogzitesDatuma'],
      json['KeszitesDatuma'],
      json['LattamozasDatuma'],
      Subject.fromJson(json['Tantargy']),
      json['Tema'],
      GradeType.fromJson(json['Tipus']),
      json['Mod'] != null ? GradeMode.fromJson(json['Mod']) : null,
      GradeValueType.fromJson(json['ErtekFajta']),
      json['ErtekeloTanarNeve'],
      json['Kind'],
      json['SzamErtek'],
      json['SzovegesErtek'],
      json['SulySzazalekErteke'],
      json['SzovegesErtekelesRovidNev'],
      json['OsztalyCsoport'] != null ?
        ClassGroup.fromJson(json['OsztalyCsoport']) : null,
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
  final SubjectCategory category;
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
      SubjectCategory.fromJson(json['Kategoria']),
      json['SortIndex']
    );
  }
}

class SubjectCategory {
  final String uid;
  final String name;
  final String description;

  SubjectCategory(
    this.uid,
    this.name,
    this.description
  );

  factory SubjectCategory.fromJson(Map<String, dynamic> json) {
    return SubjectCategory(
      json['Uid'],
      json['Nev'],
      json['Leiras']
    );
  }

  @override
  String toString() {
    return "SubjectCategory("
      "uid: \"$uid\", "
      "name: \"$name\", "
      "description: \"$description\""
      ")";
  }
}

class GradeType {
  final String uid;
  final String name;
  final String description;

  GradeType(
    this.uid,
    this.name,
    this.description
  );

  factory GradeType.fromJson(Map<String, dynamic> json) {
    return GradeType(
      json['Uid'],
      json['Nev'],
      json['Leiras']
    );
  }

  @override
  String toString() {
    return "GradeType("
      "uid: \"$uid\", "
      "name: \"$name\", "
      "description: \"$description\""
      ")";
  }
}

class GradeMode {
  final String uid;
  final String name;
  final String description;

  GradeMode(
    this.uid,
    this.name,
    this.description
  );

  factory GradeMode.fromJson(Map<String, dynamic> json) {
    return GradeMode(
      json['Uid'],
      json['Nev'],
      json['Leiras']
    );
  }
}

class GradeValueType {
  final String uid;
  final String name;
  final String description;

  GradeValueType(
    this.uid,
    this.name,
    this.description
  );

  factory GradeValueType.fromJson(Map<String, dynamic> json) {
    return GradeValueType(
      json['Uid'],
      json['Nev'],
      json['Leiras']
    );
  }

  @override
  String toString() {
    return "GradeValueType("
      "uid: \"$uid\", "
      "name: \"$name\", "
      "description: \"$description\""
      ")";
  }
}

class ClassGroup {
  final String uid;

  ClassGroup(
    this.uid
  );

  factory ClassGroup.fromJson(Map<String, dynamic> json) {
    return ClassGroup(
      json['Uid'],
    );
  }

  @override
  String toString() {
    return "ClassGroup("
      "uid: \"$uid\""
      ")";
  }
}
