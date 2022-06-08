import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../provider/api.dart';
import '../../provider/state.dart';
import '../../shared/drawer_button.dart';
import '../../shared/sidebar.dart';

class AccountPage extends ConsumerWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final accountFuture = ref.watch(accountFutureProvider);
    final account = ref.watch(accountProvider);
    final router = GoRouter.of(context);
    return Scaffold(
      body: Row(
        children: [
          Sidebar(size: size),
          Expanded(
            child: LayoutBuilder(
              builder: (context, BoxConstraints constraints) {
                return accountFuture.when(
                  data: (data) {
                    if (data) {
                      return SizedBox(
                        height: constraints.maxHeight,
                        width: constraints.maxWidth,
                        child: CustomScrollView(
                          slivers: [
                            SliverToBoxAdapter(
                              child: Container(
                                width: constraints.maxWidth,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      "Favorite Movies",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    const Spacer(),
                                    Text(
                                      "See More",
                                      style:
                                          Theme.of(context).textTheme.overline,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: SizedBox(
                                width: constraints.maxWidth,
                                height: 200 / (11 / 17),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: account!.movie.length,
                                  itemBuilder: ((context, index) {
                                    return Container(
                                      margin: index == 0
                                          ? const EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                            )
                                          : const EdgeInsets.only(
                                              left: 0,
                                              right: 20,
                                            ),
                                      child: Card(
                                        child: GestureDetector(
                                          onTap: () {
                                            router.goNamed(
                                              "account_detail_movie",
                                              params: {
                                                "id": account.movie[index]["id"]
                                                    .toString(),
                                              },
                                            );
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: 200,
                                            height: 200 / (11 / 17),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  "https://image.tmdb.org/t/p/w500${account.movie[index]["poster_path"]}",
                                                ),
                                              ),
                                            ),
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  top: 0,
                                                  right: 0,
                                                  child: Container(
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 10,
                                                      vertical: 10,
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .surface,
                                                    ),
                                                    child: Text(
                                                      "${account.movie[index]["vote_average"]}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelLarge!
                                                          .copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .onSurface,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  child: Container(
                                                    width: 200,
                                                    height: 100,
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 5),
                                                    child: Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: Text(
                                                        "${account.movie[index]["title"]}",
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleLarge,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: Container(
                                width: constraints.maxWidth,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      "Favorite Tv",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    const Spacer(),
                                    Text(
                                      "See More",
                                      style:
                                          Theme.of(context).textTheme.overline,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: SizedBox(
                                width: constraints.maxWidth,
                                height: 200 / (11 / 17),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: account.tv.length,
                                  itemBuilder: ((context, index) {
                                    return Container(
                                      margin: index == 0
                                          ? const EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                            )
                                          : const EdgeInsets.only(
                                              left: 0,
                                              right: 20,
                                            ),
                                      child: Card(
                                        child: GestureDetector(
                                          onTap: () {
                                            router.goNamed(
                                              "account_detail_movie",
                                              params: {
                                                "id": account.tv[index]["id"]
                                                    .toString(),
                                              },
                                            );
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: 200,
                                            height: 200 / (11 / 17),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  "https://image.tmdb.org/t/p/w500${account.tv[index]["poster_path"]}",
                                                ),
                                              ),
                                            ),
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  top: 0,
                                                  right: 0,
                                                  child: Container(
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 10,
                                                      vertical: 10,
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .surface,
                                                    ),
                                                    child: Text(
                                                      "${account.tv[index]["vote_average"]}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelLarge!
                                                          .copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .onSurface,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  child: Container(
                                                    width: 200,
                                                    height: 100,
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 5),
                                                    child: Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: Text(
                                                        "${account.tv[index]["name"]}",
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleLarge,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: Container(
                                width: constraints.maxWidth,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      "Watch List Movies",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    const Spacer(),
                                    Text(
                                      "See More",
                                      style:
                                          Theme.of(context).textTheme.overline,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: SizedBox(
                                width: constraints.maxWidth,
                                height: 200 / (11 / 17),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: account.movieWatchList.length,
                                  itemBuilder: ((context, index) {
                                    return Container(
                                      margin: index == 0
                                          ? const EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                            )
                                          : const EdgeInsets.only(
                                              left: 0,
                                              right: 20,
                                            ),
                                      child: Card(
                                        child: GestureDetector(
                                          onTap: () {
                                            router.goNamed(
                                              "account_detail_movie",
                                              params: {
                                                "id": account
                                                    .movieWatchList[index]["id"]
                                                    .toString(),
                                              },
                                            );
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: 200,
                                            height: 200 / (11 / 17),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  "https://image.tmdb.org/t/p/w500${account.movieWatchList[index]["poster_path"]}",
                                                ),
                                              ),
                                            ),
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  top: 0,
                                                  right: 0,
                                                  child: Container(
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 10,
                                                      vertical: 10,
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .surface,
                                                    ),
                                                    child: Text(
                                                      "${account.movieWatchList[index]["vote_average"]}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelLarge!
                                                          .copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .onSurface,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  child: Container(
                                                    width: 200,
                                                    height: 100,
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 5),
                                                    child: Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: Text(
                                                        "${account.movieWatchList[index]["title"]}",
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleLarge,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: Container(
                                width: constraints.maxWidth,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      "Watch List Tv",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    const Spacer(),
                                    Text(
                                      "See More",
                                      style:
                                          Theme.of(context).textTheme.overline,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: SizedBox(
                                width: constraints.maxWidth,
                                height: 200 / (11 / 17),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: account.tvWatchList.length,
                                  itemBuilder: ((context, index) {
                                    return Container(
                                      margin: index == 0
                                          ? const EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                            )
                                          : const EdgeInsets.only(
                                              left: 0,
                                              right: 20,
                                            ),
                                      child: Card(
                                        child: GestureDetector(
                                          onTap: () {
                                            router.goNamed(
                                              "account_detail_movie",
                                              params: {
                                                "id": account.tvWatchList[index]
                                                        ["id"]
                                                    .toString(),
                                              },
                                            );
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: 200,
                                            height: 200 / (11 / 17),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  "https://image.tmdb.org/t/p/w500${account.tvWatchList[index]["poster_path"]}",
                                                ),
                                              ),
                                            ),
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  top: 0,
                                                  right: 0,
                                                  child: Container(
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 10,
                                                      vertical: 10,
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .surface,
                                                    ),
                                                    child: Text(
                                                      "${account.tvWatchList[index]["vote_average"]}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelLarge!
                                                          .copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .onSurface,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  child: Container(
                                                    width: 200,
                                                    height: 100,
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 5),
                                                    child: Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: Text(
                                                        "${account.tvWatchList[index]["name"]}",
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleLarge,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: SizedBox(
                          width: 300,
                          height: 70,
                          child: DrawerButton(
                            active: true,
                            text: 'SIGN IN',
                            textAlignment: TextAlignment.center,
                            icon: const Icon(Icons.login),
                            onPressed: () {
                              GoRouter.of(context).goNamed("login");
                            },
                          ),
                        ),
                      );
                    }
                  },
                  error: (err, stack) => Center(
                    child: Text("$err data"),
                  ),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
