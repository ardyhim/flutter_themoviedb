import 'package:flutter/material.dart';

enum TextAlignment {
  center,
  left,
}

class DrawerButton extends StatelessWidget {
  DrawerButton({
    Key? key,
    required this.active,
    required this.onPressed,
    required this.text,
    this.icon,
    this.badge,
    this.textAlignment = TextAlignment.left,
  }) : super(
          key: key,
        );
  VoidCallback? onPressed;
  bool? active;
  String? text;
  Icon? icon;
  String? badge;
  TextAlignment? textAlignment;

  @override
  Widget build(BuildContext context) {
    TextStyle labelText = Theme.of(context).textTheme.button!.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        );
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        // textStyle: MaterialStateProperty.resolveWith<TextStyle>(
        //   (Set<MaterialState> states) {
        //     if (active!) {
        //       if (states.contains(MaterialState.selected)) {
        //         return Theme.of(context).textTheme.button!.copyWith(
        //               color: Theme.of(context).colorScheme.onSecondaryContainer,
        //             );
        //       } else if (states.contains(MaterialState.hovered)) {
        //         return Theme.of(context).textTheme.button!.copyWith(
        //               color: Theme.of(context).colorScheme.onSecondaryContainer,
        //             );
        //       } else if (states.contains(MaterialState.focused)) {
        //         return Theme.of(context).textTheme.button!.copyWith(
        //               color: Theme.of(context).colorScheme.onSecondaryContainer,
        //             );
        //       } else if (states.contains(MaterialState.disabled)) {
        //         return Theme.of(context).textTheme.button!.copyWith(
        //               color: Theme.of(context).colorScheme.onSecondaryContainer,
        //               fontSize: 25,
        //             );
        //       }
        //       return Theme.of(context).textTheme.button!.copyWith(
        //             color: Colors.red,
        //           );
        //     } else {
        //       if (states.contains(MaterialState.selected)) {
        //         return Theme.of(context).textTheme.button!.copyWith(
        //               color: Theme.of(context).colorScheme.onSecondaryContainer,
        //             );
        //       } else if (states.contains(MaterialState.hovered)) {
        //         return Theme.of(context).textTheme.button!.copyWith(
        //               color: Theme.of(context).colorScheme.onSurface,
        //             );
        //       } else if (states.contains(MaterialState.focused)) {
        //         return Theme.of(context).textTheme.button!.copyWith(
        //               color: Theme.of(context).colorScheme.onSurface,
        //             );
        //       } else if (states.contains(MaterialState.pressed)) {
        //         return Theme.of(context).textTheme.button!.copyWith(
        //               color: Theme.of(context).colorScheme.onSurface,
        //               fontSize: 25,
        //             );
        //       }
        //       return Theme.of(context).textTheme.button!.copyWith(
        //             color: Theme.of(context).colorScheme.onSurface,
        //           );
        //     }
        //   },
        // ),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (active!) {
              if (states.contains(MaterialState.selected)) {
                return Theme.of(context).colorScheme.onSecondaryContainer;
              } else if (states.contains(MaterialState.focused)) {
                return Theme.of(context).colorScheme.secondaryContainer;
              } else if (states.contains(MaterialState.pressed)) {
                return Theme.of(context)
                    .colorScheme
                    .secondaryContainer
                    .withOpacity(0.3);
              }
              return Theme.of(context).colorScheme.secondaryContainer;
            } else {
              if (states.contains(MaterialState.selected)) {
                return Theme.of(context).colorScheme.onSurfaceVariant;
              } else if (states.contains(MaterialState.focused)) {
                return Theme.of(context).colorScheme.onSurface;
              } else if (states.contains(MaterialState.pressed)) {
                return Theme.of(context).colorScheme.onSurface.withOpacity(0.3);
              }
              return Theme.of(context).colorScheme.surface;
            }
          },
        ),
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
          ),
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: icon!,
            ),
          if (textAlignment == TextAlignment.left)
            Text(
              "$text",
            ),
          if (textAlignment == TextAlignment.center)
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "$text center",
                ),
              ),
            ),
          if (textAlignment != TextAlignment.center) const Spacer(),
          if (badge != null)
            Padding(
              padding: const EdgeInsets.only(right: 13, left: 6.5),
              child: Text(
                "$badge",
              ),
            ),
        ],
      ),
    );
  }
}
