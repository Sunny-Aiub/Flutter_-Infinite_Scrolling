// To parse this JSON data, do
//
//     final dataResponse = dataResponseFromJson(jsonString);

import 'dart:convert';

DataResponse dataResponseFromJson(String str) => DataResponse.fromJson(json.decode(str));

String dataResponseToJson(DataResponse data) => json.encode(data.toJson());

class DataResponse {
  String next;
  dynamic previous;
  int count;
  List<Recipe> results;

  DataResponse({
    this.next,
    this.previous,
    this.count,
    this.results,
  });

  factory DataResponse.fromJson(Map<String, dynamic> json) => DataResponse(
    next: json["next"],
    previous: json["previous"],
    count: json["count"],
    results: List<Recipe>.from(json["results"].map((x) => Recipe.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "next": next,
    "previous": previous,
    "count": count,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Recipe {
  int id;
  String recipeTitle;
  String makingTime;
  int viewCounter;
  String coverPhotoUrl;
  int ingredientsCount;
  int recipeRating;

  Recipe({
    this.id,
    this.recipeTitle,
    this.makingTime,
    this.viewCounter,
    this.coverPhotoUrl,
    this.ingredientsCount,
    this.recipeRating,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
    id: json["id"],
    recipeTitle: json["recipe_title"],
    makingTime: json["making_time"],
    viewCounter: json["view_counter"],
    coverPhotoUrl: json["cover_photo_url"] == null ? null : json["cover_photo_url"],
    ingredientsCount: json["ingredients_count"],
    recipeRating: json["recipe_rating"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "recipe_title": recipeTitle,
    "making_time": makingTime,
    "view_counter": viewCounter,
    "cover_photo_url": coverPhotoUrl == null ? null : coverPhotoUrl,
    "ingredients_count": ingredientsCount,
    "recipe_rating": recipeRating,
  };
}