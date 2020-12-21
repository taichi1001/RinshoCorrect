class Article {
  String id;
  DateTime publishedAt;
  String title;
  String subTitle;
  List<String> tags;
  String abstract;
  String body;
  Uri eyecath;
  String videoURL;

  Article.fromJSON(Map<String, dynamic> json) {
    id = json['id'];
    publishedAt = DateTime.parse(json['publishedAt']);
    title = json['title'];
    subTitle = json['subtitle'];
    final tagFromJson = json['tag'];
    tags = List<String>.from(tagFromJson);
    abstract = json['abstract'];
    body = json['body'];
    eyecath = Uri.parse(json['eyecatch']['url']);
    videoURL = json['video'];
  }
}
