import 'package:flutter/material.dart';

class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            child: Image.asset('assets/illustrations/Done.png'),
          ),
          const SizedBox(
            height: 80,
          ),
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed'),
        centerTitle: true,
      ),
      body: content,
    );
  }
}
