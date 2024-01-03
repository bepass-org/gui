import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return BottomAppBar(
      height: 85,
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(
                width: 15,
                child: Icon(
                  Ionicons.triangle,
                  color: Colors.white,
                  size: 10,
                ),
              ),
              Text(
                "15.2 KB/s",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Transform.rotate(
                angle: 45 * 3.1415 / 45,
                child: const SizedBox(
                  width: 15,
                  child: Icon(
                    Ionicons.triangle,
                    color: Colors.white,
                    size: 10,
                  ),
                ),
              ),
              Text(
                "7.2 KB/s",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2,),
          Text(
            "Successfully connected to remote server.",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
