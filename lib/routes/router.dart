import 'package:go_router/go_router.dart';

import '../pages/account/account.dart';
import '../pages/home/home.dart';
import '../pages/login/login.dart';
import '../pages/movie/movie.dart';
import '../pages/movie_detail/detail.dart';
import '../pages/tv/tv.dart';
import '../pages/tv_detail/detail.dart';

final router = [
  GoRoute(
    path: '/login',
    name: "login",
    builder: (context, state) => LoginPage(),
  ),
  GoRoute(
    path: '/',
    name: "home",
    builder: (context, state) => const HomePage(),
  ),
  GoRoute(
    path: '/account',
    name: "account",
    builder: (context, state) => const AccountPage(),
    routes: [
      GoRoute(
        path: 'tv/:id',
        name: "account_detail_tv",
        builder: (context, state) =>
            DetailTvPage(id: int.parse(state.params['id']!)),
      ),
      GoRoute(
        path: 'movie/:id',
        name: "account_detail_movie",
        builder: (context, state) =>
            DetailMoviePage(id: int.parse(state.params['id']!)),
      ),
    ],
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
            DetailMoviePage(id: int.parse(state.params['id']!)),
      ),
    ],
  ),
  GoRoute(
    path: '/tv',
    name: "tv",
    builder: (context, state) => const TvPage(),
    routes: [
      GoRoute(
        path: ':id',
        name: "detail_tv",
        builder: (context, state) =>
            DetailTvPage(id: int.parse(state.params['id']!)),
      ),
    ],
  ),
];
