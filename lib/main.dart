import 'package:flutter/material.dart';
import "package:flutter_bloc/flutter_bloc.dart";

import 'package:fast_learn_repo/core/utils/constants.dart';
import "package:fast_learn_repo/features/home/cubit/home_cubit.dart";
import "package:fast_learn_repo/features/home/repository/home_repository.dart";
import "package:fast_learn_repo/features/home/view/home_page.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
  // Untuk yang MultiBlocProvider itu bisa dibuat file sendiri. Jadi nanti di `providers` nya tinggal manggil file yg udah kita declare. Untuk improvment kedepan aja
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              HomeCubit(ProductionHomeRepository.create())..getMovies(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
      ),
    );
  }
}
