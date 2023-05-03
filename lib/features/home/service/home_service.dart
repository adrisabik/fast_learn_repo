import 'dart:convert';
import "package:http/http.dart" as http;

import "package:fast_learn_repo/core/network/endpoint.dart";
import 'package:fast_learn_repo/features/home/repository/response/movie_response.dart';
import 'package:fast_learn_repo/features/home/repository/response/movies_response.dart';

abstract class HomeService {
  Future<List<MovieResponse>> getNowPlayingMovies();
  Future<List<MovieResponse>> getTopRatedMovies();
  Future<List<MovieResponse>> getPopularMovies();
}

class RemoteHomeService implements HomeService {
  final Endpoint _endpoint;
  final http.Client client;

  RemoteHomeService(this._endpoint, this.client);

  @override
  Future<List<MovieResponse>> getNowPlayingMovies() async {
    final response = await client.get(_endpoint.getNowPlayingMovies);
    if (response.statusCode == 200) {
      return MoviesResponse.fromJson(jsonDecode(response.body)).movieList;
    } else {
      throw Exception("Failed to load now playing movies");
    }
  }

  @override
  Future<List<MovieResponse>> getPopularMovies() async {
    final response = await http.get(_endpoint.getPopularMovies);
    if (response.statusCode == 200) {
      return MoviesResponse.fromJson(jsonDecode(response.body)).movieList;
    } else {
      throw Exception("Failed to load popular movies");
    }
  }

  @override
  Future<List<MovieResponse>> getTopRatedMovies() async {
    final response = await http.get(_endpoint.getTopRatedMovies);
    if (response.statusCode == 200) {
      return MoviesResponse.fromJson(jsonDecode(response.body)).movieList;
    } else {
      throw Exception("Failed to load top rated movies");
    }
  }

  factory RemoteHomeService.create() {
    return RemoteHomeService(Endpoint.stagingEndpoint(), http.Client());
  }
}
