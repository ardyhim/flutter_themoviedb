import 'package:flutter/material.dart';

enum PeopleRole {
  cast,
  crew,
}

class DetailItemPeople extends StatelessWidget {
  DetailItemPeople({
    Key? key,
    required this.data,
    required this.constraints,
    required this.role,
  }) : super(key: key);
  late Map data;
  BoxConstraints constraints;
  PeopleRole role = PeopleRole.cast;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: (constraints.maxWidth / 2) / 1.8 - 40,
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.surfaceVariant,
          ),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: SizedBox(
          height: 60,
          width: 60,
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              "https://image.tmdb.org/t/p/w92/${data["profile_path"]}",
            ),
          ),
        ),
        title: Text(
          "${data["name"]}",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: role == PeopleRole.cast
            ? Text(
                "${data["character"]}",
                style: Theme.of(context).textTheme.labelMedium,
              )
            : Container(),
      ),
    );
  }
}
