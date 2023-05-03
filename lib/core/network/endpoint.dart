import "package:fast_learn_repo/core/network/url_builder.dart";
import "package:fast_learn_repo/core/network/base_url.dart";

class Endpoint {
  final String _baseUrl;
  final String _key;

  Endpoint(this._baseUrl, this._key);

  Uri get getNowPlayingMovies {
    return createUrl(
      host: _baseUrl,
      path: "/3/movie/now_playing",
      queryParameters: {"api_key": _key},
    );
  }

  Uri get getTopRatedMovies {
    return createUrl(
      host: _baseUrl,
      path: "/3/movie/top_rated",
      queryParameters: {"api_key": _key},
    );
  }

  Uri get getPopularMovies {
    return createUrl(
      host: _baseUrl,
      path: "/3/movie/popular",
      queryParameters: {"api_key": _key},
    );
  }

  factory Endpoint.stagingEndpoint() {
    return Endpoint(BaseUrl.host, BaseUrl.key);
  }
}
