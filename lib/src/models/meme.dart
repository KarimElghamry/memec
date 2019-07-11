class Meme {
  String _postLink;
  String _subreddit;
  String _title;
  String _url;

  String get postLink => _postLink;
  String get subreddit => _subreddit;
  String get title => _title;
  String get url => _url;

  Meme({String postLink, String subreddit, String title, String url})
      : _postLink = postLink,
        _subreddit = subreddit,
        _title = title,
        _url = url;

  factory Meme.fromJson(Map<String, dynamic> json) {
    return Meme(
      postLink: json["postLink"],
      subreddit: json["subreddit"],
      title: json["title"],
      url: json["url"],
    );
  }
}
