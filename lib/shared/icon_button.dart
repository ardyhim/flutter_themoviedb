import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  CustomIconButton({
    Key? key,
    required this.icon,
    required this.active,
    required this.onPressed,
  }) : super(key: key);
  Icon? icon;
  VoidCallback? onPressed;
  bool? active;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
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
                  return Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withOpacity(0.3);
                }
                return Theme.of(context).colorScheme.surface;
              }
            },
          ),
        ),
        child: icon!,
      ),
    );
  }
}
