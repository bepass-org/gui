import 'package:defacto/ui/screens/other/new_profile.dart';
import 'package:flutter/material.dart';

class MoreOptions extends StatelessWidget {
  const MoreOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        // The PopupMenuButton handles its own onTap through itemBuilder
        child: Material(
          color: Colors.transparent,
          child: PopupMenuButton(
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.more_vert),
            ),
            onSelected: (value) {},
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              const PopupMenuItem(
                value: "clearAllStats",
                child: Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.clear_all, color: Colors.black45)),
                    Text(
                      'Clear traffic statistics',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: "removeDuplicates",
                child: Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.control_point_duplicate,
                            color: Colors.black45)),
                    Text(
                      'Remove duplicates',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: "connectionTest",
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.network_ping, color: Colors.black45),
                    ),
                    Text(
                      'Connection test',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: "fragmentation",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NewProfilePage()),
                  );
                },
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.turn_sharp_left_outlined,
                          color: Colors.black45),
                    ),
                    Text(
                      'Fragmentation',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: "order",
                onTap: () {},
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.reorder, color: Colors.black45),
                    ),
                    Text(
                      'Order',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
