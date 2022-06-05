import 'package:flutter/material.dart';

class DetailItemReview extends StatelessWidget {
  DetailItemReview({
    Key? key,
    required this.constraints,
    required this.data,
  }) : super(key: key);

  late Map data;
  BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: constraints.maxWidth - ((constraints.maxWidth / 2) / 1.8) - 40,
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.only(
        bottom: 20,
        // left: 20,
        // top: 10,
        // right: 20,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.surfaceVariant,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Text(
                  "Review by",
                  style: Theme.of(context).textTheme.overline,
                ),
              ),
              Text(
                "${data["author"]}",
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontSize: 20),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.star,
                  size: 18,
                ),
              ),
              Text(
                "${data["author_details"]["rating"]}/10",
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontSize: 20),
              ),
            ],
          ),
          Text(
            "${data["content"]}",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
