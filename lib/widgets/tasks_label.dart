import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

class TaskLabel extends StatelessWidget {
  const TaskLabel({
    required this.icon,
    super.key,
    this.labelText,
    this.iconColour,
    this.iconSize,
    this.isTappable,
  });

  final String icon;
  final String? labelText;
  final Color? iconColour;
  final double? iconSize;
  final bool? isTappable;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InkWell(
          child: Iconify(
            icon,
            size: iconSize ?? 18,
            color: iconColour ?? Theme.of(context).colorScheme.primary,
          ),
        ),
        if (labelText != null) ...[
          const SizedBox(
            width: 4,
          ),
          Text(
            labelText!,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ]
      ],
    );
  }
}
