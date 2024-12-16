import 'package:flutter/material.dart';
import 'package:todoo_app/constants.dart';

Future<String?> showTodooMenu({
  required BuildContext context,
  required Offset offset,
}) {
  final String? shouldDelete = null;
  return showMenu<String>(
    context: context,
    position: RelativeRect.fromLTRB(offset.dx, offset.dy - 2, 16, 0),
    surfaceTintColor: Theme.of(context).primaryColor,
    constraints: const BoxConstraints.tightFor(width: 140),
    items: [
      PopupMenuItem<String>(
        padding: const EdgeInsets.fromLTRB(8, 10, 0, 4),
        value: 'Edit',
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.edit,
              size: 18,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              'Edit Todoo',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
      ),
      PopupMenuItem<String>(
        padding: const EdgeInsets.fromLTRB(8, 4, 0, 10),
        value: 'Delete',
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.delete,
              size: 18,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              'Delete Todoo',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
      ),
    ],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(kTodooAppRoundness),
    ),
    menuPadding: EdgeInsets.zero,
    color: Theme.of(context).colorScheme.surface,
  );
}
