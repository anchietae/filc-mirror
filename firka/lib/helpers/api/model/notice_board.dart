class NoticeBoardItem {
  final String uid;
  final String author;
  final DateTime validFrom;
  final DateTime validTo;
  final String title;
  final String contentHTML;
  final String contentText;

  NoticeBoardItem(
    this.uid,
    this.author,
    this.validFrom,
    this.validTo,
    this.title,
    this.contentHTML,
    this.contentText
  );

  factory NoticeBoardItem.fromJson(Map<String, dynamic> json) {
    return NoticeBoardItem(
      json['Uid'],
      json['RogzitoNeve'],
      DateTime.parse(json['ErvenyessegKezdete']),
      DateTime.parse(json['ErvenyessegVege']),
      json['Cim'],
      json['Tartalom'],
      json['TartalomText']
    );
  }

  @override
  String toString() {
    return "NoticeBoardItem("
        "uid: \"$uid\", "
        "author: \"$author\", "
        "validFrom: \"$validFrom\", "
        "validTo: \"$validTo\", "
        "title: \"$title\", "
        "contentHTML: \"$contentHTML\", "
        "contentText: \"$contentText\""
      ")";
  }
}