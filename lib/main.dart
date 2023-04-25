import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'color_provider.dart';

void main(List<String> args) {
  runApp(const ProviderScope(
    child: MaterialApp(
      home: TestTask(),
    ),
  ));
}

class TestTask extends ConsumerWidget {
  const TestTask({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color myColor = ref.watch(randomColorProvider);

    log('1');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Randome Color Tap'),
      ),
      body: GestureDetector(
        onTap: () {
          ref.watch(randomColorProvider.notifier).changeColor();
        },
        child: Container(
          decoration: BoxDecoration(color: myColor),
          child: const Center(
            child: Text(
              'This Is Random Color Tap Test',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      floatingActionButton: Text(
        myColor.toString(),
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}
