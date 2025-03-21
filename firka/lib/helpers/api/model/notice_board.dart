class NoticeBoardItem {
  final String uid;
  final String author;
  final String validFrom;
  final String validTo;
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
      json['ErvenyessegKezdete'],
      json['ErvenyessegVege'],
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