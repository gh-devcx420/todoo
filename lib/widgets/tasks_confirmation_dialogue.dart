import 'package:flutter/material.dart';
import 'package:todoo_app/widgets/tasks_alert_dialogue.dart';
import 'package:todoo_app/widgets/tasks_button.dart';

class TodooConfirmationDialogue extends StatelessWidget {
  const TodooConfirmationDialogue(
      {super.key,
      required this.confirmationDialogueTitle,
      required this.confirmationDialogueBodyText,
      required this.onCancelTap,
      required this.onConfirmTap,
      required this.confirmButtonText});

  final String confirmationDialogueTitle;
  final String confirmationDialogueBodyText;
  final void Function() onCancelTap;
  final void Function() onConfirmTap;
  final String confirmButtonText;

  @override
  Widget build(BuildContext context) {
    return TodooAlertDialogue(
      title: confirmationDialogueTitle,
      contentItems: [
        Text(
          confirmationDialogueBodyText,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TodooButton(
              onButtonTap: onCancelTap,
              buttonText: 'Cancel',
              buttonColour:
                  Theme.of(context).colorScheme.primary.withOpacity(0.06),
            ),
            const SizedBox(width: 4),
            TodooButton(
              onButtonTap: onConfirmTap,
              buttonText: confirmButtonText,
            ),
          ],
        )
      ],
    );
    ;
  }
}
