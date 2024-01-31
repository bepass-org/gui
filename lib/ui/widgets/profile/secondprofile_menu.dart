import 'package:defacto/ui/screens/other/new_profile.dart';
import 'package:flutter/material.dart';

void showSecondPopupMenu(BuildContext context) {
  showMenu(
    context: context,
    position: const RelativeRect.fromLTRB(1, 50, 0, 0),
    items: <PopupMenuEntry>[
      PopupMenuItem(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewProfilePage()),
            );
          },
          child: const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.handyman_outlined, color: Colors.black45),
              ),
              Text(
                'Default',
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
