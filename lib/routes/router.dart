import 'package:contoh/pages/detail/detail.dart';
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
      routes: [
        GoRoute(
          path: ':id',
          name: "detail_movie",
          builder: (context, state) =>
              DetailPage(id: int.parse(state.params['id']!)),
        ),
      ],
    ),
  ],
);
