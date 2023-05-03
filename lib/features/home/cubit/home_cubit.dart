import "dart:async";
import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fast_learn_repo/features/home/repository/home_repository.dart";
import "package:fast_learn_repo/features/home/repository/response/movie_response.dart";

part "home_state.dart";

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _repository;

  HomeCubit(this._repository) : super(HomeState.initial());

  Future<void> getMovies() async {
    try {
      emit(HomeState.loading());
      final responseNowPlaying = await _repository.getNowPlayingMovies();
      final responsePopular = await _repository.getPopularMovies();
      final responseTopRated = await _repository.getTopRatedMovies();

      emit(HomeState.success(
          responseNowPlaying, responsePopular, responseTopRated));
    } catch (e) {
      emit(HomeState.failure());
    }
  }
}
