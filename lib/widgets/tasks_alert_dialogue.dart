import 'package:flutter/material.dart';
import 'package:todoo_app/constants.dart';

class TodooAlertDialogue extends StatelessWidget {
  const TodooAlertDialogue({
    super.key,
    required this.title,
    required this.contentItems,
  });

  final String title;
  final List<Widget> contentItems;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kTodooAppRoundness),
      ),
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      title: Padding(
        padding: const EdgeInsets.only(left: 6, top: 8),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      titlePadding: kScaffoldBodyPadding,
      content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: contentItems),
      contentPadding:
          kScaffoldBodyPadding.copyWith(left: 16, right: 16, bottom: 16),
    );
  }
}
