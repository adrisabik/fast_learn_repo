part of "home_cubit.dart";

enum HomeStatus {
  initial,
  loading,
  success,
  failure,
}

enum HomeErrorType { retrieveInformationFailure, other }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<MovieResponse>? responseNowPlaying;
  final List<MovieResponse>? responsePopular;
  final List<MovieResponse>? responseTopRated;

  const HomeState({
    required this.status,
    this.responseNowPlaying,
    this.responsePopular,
    this.responseTopRated,
  });

  factory HomeState.initial() {
    return const HomeState(
      status: HomeStatus.initial,
    );
  }

  factory HomeState.loading() {
    return const HomeState(
      status: HomeStatus.loading,
    );
  }

  factory HomeState.success(List<MovieResponse> responseNowPlaying,
      responsePopular, responseTopRated) {
    return HomeState(
      status: HomeStatus.success,
      responseNowPlaying: responseNowPlaying,
      responsePopular: responsePopular,
      responseTopRated: responseTopRated,
    );
  }

  factory HomeState.failure() {
    return const HomeState(
      status: HomeStatus.failure,
    );
  }

  @override
  List<Object?> get props =>
      [status, responseNowPlaying, responsePopular, responseTopRated];
}
