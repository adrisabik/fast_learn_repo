import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:fast_learn_repo/core/utils/constants.dart';
import "package:fast_learn_repo/features/home/cubit/home_cubit.dart";
import 'package:fast_learn_repo/features/home/repository/response/movie_response.dart';

class HomeMoviePage extends StatefulWidget {
  static const ROUTE_NAME = '/home';

  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    // context.read<HomeCubit>().getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('TV Series'),
              onTap: () {
                // Navigator.pushNamed(context, HomeSeriesPage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                // Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                // Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
                if (state.status == HomeStatus.loading) {
                  return const CircularProgressIndicator();
                } else if (state.status == HomeStatus.success) {
                  final data = state.responseNowPlaying;
                  return MovieList(data);
                } else if (state.status == HomeStatus.failure) {
                  return const Text("Failed");
                } else {
                  return Container();
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                // onTap: () =>
                // Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
                if (state.status == HomeStatus.loading) {
                  return const CircularProgressIndicator();
                } else if (state.status == HomeStatus.success) {
                  final data = state.responsePopular;
                  return MovieList(data);
                } else if (state.status == HomeStatus.failure) {
                  return const Text("Failed");
                } else {
                  return Container();
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                // onTap: () =>
                // Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
                if (state.status == HomeStatus.loading) {
                  return const CircularProgressIndicator();
                } else if (state.status == HomeStatus.success) {
                  final data = state.responseTopRated;
                  return MovieList(data);
                } else if (state.status == HomeStatus.failure) {
                  return const Text("Failed");
                } else {
                  return Container();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, Function()? onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<MovieResponse>? movies;

  const MovieList(this.movies, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies?[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                // Navigator.pushNamed(
                //   context,
                //   MovieDetailPage.ROUTE_NAME,
                //   arguments: movie.id,
                // );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie?.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                // child: Text(movie!.title),
              ),
            ),
          );
        },
        itemCount: movies?.length,
      ),
    );
  }
}
