import 'package:equatable/equatable.dart';
import 'package:fast_learn_repo/features/home/repository/response/movie_response.dart';

class MoviesResponse extends Equatable {
  final List<MovieResponse> movieList;

  const MoviesResponse({required this.movieList});

  factory MoviesResponse.fromJson(Map<String, dynamic> json) => MoviesResponse(
        movieList: List<MovieResponse>.from((json["results"] as List)
            .map((x) => MovieResponse.fromJson(x))
            .where((element) => element.posterPath != null)),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(movieList.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [movieList];
}
