import 'package:fast_learn_repo/features/home/repository/response/movie_response.dart';
import "package:fast_learn_repo/features/home/service/home_service.dart";

abstract class HomeRepository {
  Future<List<MovieResponse>> getNowPlayingMovies();
  Future<List<MovieResponse>> getTopRatedMovies();
  Future<List<MovieResponse>> getPopularMovies();
}

class ProductionHomeRepository implements HomeRepository {
  final HomeService _homeService;

  ProductionHomeRepository(this._homeService);

  @override
  Future<List<MovieResponse>> getNowPlayingMovies() async {
    try {
      final response = await _homeService.getNowPlayingMovies();
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<MovieResponse>> getPopularMovies() async {
    try {
      final response = await _homeService.getPopularMovies();
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<MovieResponse>> getTopRatedMovies() async {
    try {
      final response = await _homeService.getTopRatedMovies();
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  factory ProductionHomeRepository.create() {
    return ProductionHomeRepository(RemoteHomeService.create());
  }
}
