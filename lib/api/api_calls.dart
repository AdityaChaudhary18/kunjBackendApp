import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kunjapp/models/movie.dart';
import 'package:http/http.dart' as http;

Future<MovieModel> getSearchResult(String movieName, context) async {
  // return MovieModel(
  //     title: "hellp", poster: "pster", genre: "genre", rating: '10');
  MovieModel result = MovieModel(
      title: "Not Found", poster: "Null", genre: "Null", rating: 'Null');
  try {
    String url = "http://www.omdbapi.com/?apikey=2ca2343f&t=";
    url += movieName;
    final response = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
    );
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      if (item["Error"] == "Movie not found!") {
        return result;
      }
      result = MovieModel(
          title: item["Title"],
          poster: item["Poster"],
          genre: item["Genre"],
          rating: item["imdbRating"]);
      return result;
    } else {
      const snackBar = SnackBar(
        content: Text("Data not found"),
        backgroundColor: Colors.redAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  } catch (e) {
    log(e.toString());
  }
  return result;
}
