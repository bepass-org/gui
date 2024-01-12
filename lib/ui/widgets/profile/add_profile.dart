import 'package:defacto/ui/other_screens/new_profile.dart';
import 'package:flutter/material.dart';

class AddProfile extends StatelessWidget {
  const AddProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      // The PopupMenuButton handles its own onTap through itemBuilder
      child: Material(
        color: Colors.transparent,
        child: PopupMenuButton(
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.note_add),
          ),
          onSelected: (value) {},
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            const PopupMenuItem(
              value: "scan",
              child: Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.qr_code, color: Colors.black45)
                  ),
                  Text(
                    'Scan QR Code',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
            const PopupMenuItem(
              value: "clipboard",
              child: Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.content_paste, color: Colors.black45)
                  ),
                  Text(
                    'Import from Clipboard',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
            const PopupMenuItem(
              value: "fromFile",
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.document_scanner, color: Colors.black45),
                  ),
                  Text(
                    'Import from file',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: "manual",
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
                    'Manual Settings',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}