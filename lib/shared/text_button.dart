import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  CustomTextButton({
    Key? key,
    required this.active,
    required this.onPressed,
    required this.text,
  }) : super(
          key: key,
        );
  VoidCallback? onPressed;
  bool active;
  String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: active ? onPressed : null,
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
            if (active) {
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
      child: Text(
        text,
        style: Theme.of(context).textTheme.button,
      ),
    );
  }
}
