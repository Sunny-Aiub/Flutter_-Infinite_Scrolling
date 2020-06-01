import 'package:flutterinfinitescrolling/data_response.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';

abstract class MovieRepository {
  Future<DataResponse> fetchMovies();
}

class MovieProdRepository implements MovieRepository {
  @override
  Future<DataResponse> fetchMovies() async {
    http.Response response = await http.get("'http://58.84.34.65:9090/api/recipe/list/?limit=10'");
    return compute(parseMovies, response.body);
  }
}
DataResponse parseMovies(String responseBody) {
  final Map moviesMap = JsonCodec().decode(responseBody);
  print(moviesMap);

  DataResponse movies = dataResponseFromJson(responseBody);
  if (movies == null) {
    throw new Exception("An error occurred : [ Status Code = ]");
  }
  return movies;
}

