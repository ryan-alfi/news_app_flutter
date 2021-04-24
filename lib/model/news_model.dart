// To parse this JSON data, do
//
//     final newsResponse = newsResponseFromJson(jsonString);

import 'dart:convert';

List<NewsResponse> newsResponseFromJson(String str) => List<NewsResponse>.from(
    json.decode(str).map((x) => NewsResponse.fromJson(x)));

String newsResponseToJson(List<NewsResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewsResponse {
  NewsResponse({
    this.code,
    this.messege,
    this.data,
  });

  int code;
  String messege;
  List<News> data;

  factory NewsResponse.fromJson(Map<String, dynamic> json) => NewsResponse(
        code: json["code"],
        messege: json["messege"],
        data: List<News>.from(json["data"].map((x) => News.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "messege": messege,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class News {
  News({
    this.contentId,
    this.channelName,
    this.published,
    this.title,
    this.thumbnail,
    this.url,
    this.author,
    this.summary,
  });

  String contentId;
  String channelName;
  String published;
  String title;
  String thumbnail;
  String url;
  String author;
  String summary;

  factory News.fromJson(Map<String, dynamic> json) => News(
        contentId: json["content_id"],
        channelName: json["channel_name"],
        published: json["published"],
        title: json["title"],
        thumbnail: json["thumbnail"],
        url: json["url"],
        author: json["author"],
        summary: json["summary"],
      );

  Map<String, dynamic> toJson() => {
        "content_id": contentId,
        "channel_name": channelName,
        "published": published,
        "title": title,
        "thumbnail": thumbnail,
        "url": url,
        "author": author,
        "summary": summary,
      };
}
