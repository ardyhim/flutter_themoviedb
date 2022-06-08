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
                              child: Row(
                                children: [
                                  Text(
                                    "Favorite Movies",
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                  const Spacer(),
                                  Text(
                                    "See More",
                                    style: Theme.of(context).textTheme.overline,
                                  ),
                                ],
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: SizedBox(
                                width: constraints.maxWidth,
                                height: 200,
                                child: ListView.builder(
                                  itemCount: account!.movie.length,
                                  itemBuilder: ((context, index) {
                                    return Text(
                                        "${account.movie[index]["title"]}");
                                  }),
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: Row(
                                children: [
                                  Text(
                                    "Favorite Tv",
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                  const Spacer(),
                                  Text(
                                    "See More",
                                    style: Theme.of(context).textTheme.overline,
                                  ),
                                ],
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: SizedBox(
                                width: constraints.maxWidth,
                                height: 200,
                                child: ListView.builder(
                                  itemCount: account.tv.length,
                                  itemBuilder: ((context, index) {
                                    return Text("${account.tv[index]["name"]}");
                                  }),
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: Row(
                                children: [
                                  Text(
                                    "Watch List Movies",
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                  const Spacer(),
                                  Text(
                                    "See More",
                                    style: Theme.of(context).textTheme.overline,
                                  ),
                                ],
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: SizedBox(
                                width: constraints.maxWidth,
                                height: 200,
                                child: ListView.builder(
                                  itemCount: account.movieWatchList.length,
                                  itemBuilder: ((context, index) {
                                    return Text(
                                        "${account.movieWatchList[index]["title"]}");
                                  }),
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: Row(
                                children: [
                                  Text(
                                    "Watch List Tv",
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                  const Spacer(),
                                  Text(
                                    "See More",
                                    style: Theme.of(context).textTheme.overline,
                                  ),
                                ],
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: SizedBox(
                                width: constraints.maxWidth,
                                height: 200,
                                child: ListView.builder(
                                  itemCount: account.tvWatchList.length,
                                  itemBuilder: ((context, index) {
                                    return Text(
                                        "${account.tvWatchList[index]["name"]}");
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
