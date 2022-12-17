import 'package:flutter/material.dart';
import 'package:kunjapp/models/movie.dart';

import '../api/api_calls.dart';

class PostDataProvider with ChangeNotifier {
  MovieModel post = MovieModel();
  bool loading = false;

  getPostData(context, String movieName) async {
    loading = true;
    post = await getSearchResult(movieName, context);
    loading = false;

    notifyListeners();
  }
}
