import 'package:defacto/config/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class themeSelector extends StatefulWidget {
  themeSelector({Key? key}) : super(key: key);

  @override
  _themeSelectorState createState() => _themeSelectorState();
}

class _themeSelectorState extends State<themeSelector> {
  List<Color> colorsList = [
    Colors.white,
    Colors.black,
    Colors.redAccent,
    Colors.green,
    Colors.blue,
    Colors.amber,
    Colors.orange,
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 30,
        child: ListView.builder(
          physics: const PageScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: colorsList.length,
          shrinkWrap: true,
          itemBuilder: ((context, index) {
            return Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final themeNotifier = ref.watch(themeProvider);

                return GestureDetector(
                  child: Container(
                    height: 100,
                    width: 57,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      color: colorsList[index],
                      shape: BoxShape.circle,
                    ),
                  ),
                  onTap: () {
                    themeNotifier.setTheme(index);
                  },
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
