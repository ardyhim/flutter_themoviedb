import 'package:contoh/pages/home/home.dart';
import 'package:contoh/pages/movie/movie.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: "home",
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/movies',
      name: "movie",
      builder: (context, state) => const MoviePage(),
    ),
  ],
);
