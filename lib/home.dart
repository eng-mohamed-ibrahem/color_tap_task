import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'color_converting_type.dart';
import 'color_provider.dart';

final colorTypeProvider = StateProvider<ColorConvertType>(
  (ref) => ColorConvertType.hexadecimal,
);

class TestTask extends ConsumerWidget {
  const TestTask({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color myColor = ref.watch(randomColorProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Randome Color Tap'),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.colorize),
            padding: const EdgeInsets.all(5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            itemBuilder: (context) {
              return <PopupMenuEntry<ColorConvertType>>[
                const PopupMenuItem(
                    value: ColorConvertType.hexadecimal,
                    child: Text('HEX color')),
                const PopupMenuItem(
                  value: ColorConvertType.rgb,
                  child: Text('RGB color'),
                )
              ];
            },
            onSelected: (value) {
              switch (value) {
                case ColorConvertType.hexadecimal:
                  ref
                      .read(colorTypeProvider.notifier)
                      .update((state) => ColorConvertType.hexadecimal);
                  break;
                case ColorConvertType.rgb:
                  ref
                      .read(colorTypeProvider.notifier)
                      .update((state) => ColorConvertType.rgb);

                  break;
              }
            },
          )
        ],
      ),
      body: GestureDetector(
        onLongPress: () {
          Clipboard.setData(
            ClipboardData(
              text: ref.read(colorTypeProvider) == ColorConvertType.hexadecimal
                  ? ref.read(randomColorProvider.notifier).getHexaColor()
                  : ref.read(randomColorProvider.notifier).getRGBColor(),
            ),
          );
          // displayed snackbar if run on web or desktop
          if (defaultTargetPlatform != TargetPlatform.android &&
              defaultTargetPlatform != TargetPlatform.iOS) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Copied to Clipboard'),
              ),
            );
          }
        },
        onTap: () {
          ref.watch(randomColorProvider.notifier).changeColor();
        },
        child: Container(
          decoration: BoxDecoration(color: myColor),
          child: const Center(
            child: Text(
              'Random Color Tap Test',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      floatingActionButton: Text(myColor.toString(),
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold)),
    );
  }
}
