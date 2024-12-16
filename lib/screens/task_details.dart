import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:todoo_app/constants.dart';
import 'package:todoo_app/models/tasks_model.dart';

class TodooTaskDetails extends StatelessWidget {
  const TodooTaskDetails({required this.currentTask, super.key});

  final TodooTask currentTask;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todoo Details'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: kScaffoldBodyPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Iconify(
                    Bx.heading,
                    color: Theme.of(context).colorScheme.primary,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Expanded(
                    child: Text(currentTask.title,
                        style: Theme.of(context).textTheme.titleSmall),
                  ),
                ],
              ),
              if (currentTask.description != null) ...[
                const SizedBox(
                  height: 8,
                ),
                Text(currentTask.description!)
              ],
            ],
          ),
        ),
      ),
    );
  }
}
