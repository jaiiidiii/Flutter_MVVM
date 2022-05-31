import 'dart:convert';
import 'dart:developer';

import 'package:flutter_mvvm/models/movies_model.dart';
import 'package:http/http.dart' as http;

class MovieService {
  Future<List<Movie>> fetchMovies(String keyword) async {
    final url = "http://www.omdbapi.com/?s=$keyword&apikey=cc4e72e3";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log(response.body);
      final body = jsonDecode(response.body);
      var json = MoviesResponse.fromJson(body);
      // final Iterable json = body["Search"];
      // return json.map((movie) => Movie.fromJson(movie)).toList();
      if (json.response != "False") {
        return Future.value(json.movie);
      } else {
        throw Exception("Movie not found");
      }
    } else {
      throw Exception("Unable to perform request!");
    }
  }
}
