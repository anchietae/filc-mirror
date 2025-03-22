class NameUidDesc {
  final String uid;
  final String? name;
  final String? description;

  NameUidDesc(
    this.uid,
    this.name,
    this.description
  );

  factory NameUidDesc.fromJson(Map<String, dynamic> json) {
    return NameUidDesc(
        json['Uid'],
        json['Nev'],
        json['Leiras']
    );
  }

  @override
  String toString() {
    return "NameUidDesc("
      "uid: \"$uid\", "
      "name: \"$name\", "
      "description: \"$description\""
    ")";
  }
}

class NameUid {
  final String uid;
  final String name;

  NameUid({
    required this.uid,
    required this.name,
  });

  factory NameUid.fromJson(Map<String, dynamic> json) {
    return NameUid(
      uid: json['Uid'],
      name: json['Nev'],
    );
  }
}

class UidObj {
  final String uid;

  UidObj(
    this.uid
  );

  factory UidObj.fromJson(Map<String, dynamic> json) {
    return UidObj(
      json['Uid'],
    );
  }

  @override
  String toString() {
    return "UidObj("
      "uid: \"$uid\""
    ")";
  }
}