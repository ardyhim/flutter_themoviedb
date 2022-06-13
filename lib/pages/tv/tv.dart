import 'package:flutter/material.dart';

import '../../shared/sidebar.dart';
import 'tv_content.dart';

class TvPage extends StatelessWidget {
  const TvPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Row(
        children: [
          Sidebar(size: size),
          Expanded(
            child: LayoutBuilder(
              builder: (context, BoxConstraints constraints) {
                return SizedBox(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  child: TvView(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
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
