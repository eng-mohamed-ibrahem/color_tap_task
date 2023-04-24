import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main(List<String> args) {
  runApp(ProviderScope(
    child: MaterialApp(
      home: TestTask(),
    ),
  ));
}

class TestTask extends ConsumerWidget {
  TestTask({super.key});

  final StateProvider<Color> colorProvider =
      StateProvider((ref) => Colors.white);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color myColor = ref.watch(colorProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Randome Color Tap'),
      ),
      body: GestureDetector(
        onTap: () {
          ref.watch(colorProvider.notifier).update(
                (state) => Color.fromRGBO(Random().nextInt(256),
                    Random().nextInt(256), Random().nextInt(256), 1),
              );
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
    );
  }
}
