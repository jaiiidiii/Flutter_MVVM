import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mvvm/services/movie_service.dart';
import 'package:flutter_mvvm/view_models/movie_view_model.dart';

class MoviesListViewModel extends ChangeNotifier {
  List<MovieViewModel> movieList = <MovieViewModel>[];
  bool isLoading = false;
  fetchMovies(String keyword) async {
    try {
      isLoading = true;
      notifyListeners();

      var result = await MovieService().fetchMovies(keyword);
      movieList = result.map((e) => MovieViewModel(e)).toList();
      log(movieList.length.toString());
      isLoading = false;
    } catch (e) {
      isLoading = false;
    } finally {
      notifyListeners();
    }
  }
}
