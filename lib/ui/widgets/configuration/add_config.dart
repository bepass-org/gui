import 'package:defacto/ui/screens/new_configuration.dart';
import 'package:flutter/material.dart';

class AddConfig extends StatelessWidget {
  const AddConfig({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      child: const Icon(Icons.note_add),
      onSelected: (value) {
        if (value == "profile") {
          // add desired output
        }else if(value == "settings"){
          // add desired output
        }else if(value == "logout"){
          // add desired output
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        const PopupMenuItem(
          value: "scan",
          child: Row(
            children: [
              Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.qr_code)
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
                  child: Icon(Icons.content_paste)
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
                child: Icon(Icons.document_scanner),
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
              MaterialPageRoute(builder: (context) => NewConfigurationPage()),
            );
          },
          child: const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.handyman_outlined),
              ),
              Text(
                'Manual Settings',
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ],
    );
  }
}