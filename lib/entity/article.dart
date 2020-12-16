class Article {
  final String id;
  final DateTime publishedAt;
  final String title;
  final String subTitle;
  final String abstract;
  final String body;
  final Uri eyecath;
  final String videoURL;

  Article.fromJSON(Map<String, dynamic> json)
      : id = json['id'],
        publishedAt = DateTime.parse(json['publishedAt']),
        title = json['title'],
        subTitle = json['subtitle'],
        abstract = json['abstract'],
        body = json['body'],
        eyecath = Uri.parse(json['eyecatch']['url']),
        videoURL = json['video'];
}
