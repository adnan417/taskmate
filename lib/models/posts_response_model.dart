import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'posts_response_model.g.dart';

List<PostsResponseModel> postsResponseModelFromJson(String str) =>
    List<PostsResponseModel>.from(
        json.decode(str).map((x) => PostsResponseModel.fromJson(x)));

String postsResponseModelToJson(List<PostsResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class PostsResponseModel {
  int? userId;
  int? id;
  String? title;
  String? body;

  PostsResponseModel({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  factory PostsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PostsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostsResponseModelToJson(this);
}
