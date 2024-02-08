import 'dart:convert';
import 'dart:io';
import 'package:defacto/ui/screens/skeleton/skeleton_screen.dart';
import 'package:defacto/ui/widgets/card/default_card.dart';
import 'package:defacto/ui/widgets/card/default_list_item.dart';
import 'package:defacto/ui/widgets/form/group.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:html/dom.dart' as DOOM;
import 'package:url_launcher/url_launcher.dart';
import 'package:html/parser.dart' show parse;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  List<Map<String, dynamic>> about_template = [];

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  Future<void> loadSettings() async {
    String aboutContent =
        await rootBundle.loadString('assets/fake_data/about_template.json');

    setState(() {
      about_template = (json.decode(aboutContent) as List<dynamic>)
          .cast<Map<String, dynamic>>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
          automaticallyImplyLeading: Platform.isAndroid,
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Platform.isAndroid
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.background,
          title: Text(
            "About",
            style: TextStyle(
                color: Platform.isAndroid
                    ? Colors.white
                    : Theme.of(context).colorScheme.primary),
          )),
      // drawer: const MainDrawer(),
      body: ListView.builder(
        itemCount:
            about_template.isEmpty ? 0 : about_template[0]['groups'].length,
        itemBuilder: (context, index) {
          var group = about_template[0]['groups'][index];
          return GroupForm(
            title: group['name'],
            children: [
              Column(
                children: [
                  DefaultCard(child: _appInfoWidget(context, group)),
                  for (var field in group['fields'])
                    DefaultCard(child: _fieldInfoWidget(context, field)),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}

Widget _appInfoWidget(BuildContext context, Map<String, dynamic> group) {
  String capitalizedTitle = group['id'].toUpperCase();
  return Column(children: [
    DefaultListItem(
      title: capitalizedTitle,
      addDivider: true,
      additionalInput: group['label'],
      body: (group['descType'] != 'hidden') ? group['description'] : null,
      prefixWidget: const Icon(Icons.info_outline_rounded),
    ),
  ]);
}

Widget _fieldInfoWidget(BuildContext context, Map<String, dynamic> field) {
  String capitalizedTitle = field['id'].toUpperCase();
  // Check if the description contains a URL or email
  var bodyWidget = _createBodyWidget(context, field['description']);
  return Column(children: [
    DefaultListItem(
      title: capitalizedTitle,
      addDivider: false,
      additionalInput: field['label'],
      bodyWidget: bodyWidget, // Updated to use the new bodyWidget
      prefixWidget: Icon(MdiIcons.fromString(field['icon'])),
    ),
  ]);
}

Widget _createBodyWidget(BuildContext context, String? text) {
  if (text == null || text.isEmpty) return const SizedBox.shrink();

  // Parse the HTML content
  var document = parse(text);
  List<DOOM.Node> nodes = document.body!.nodes;

  List<InlineSpan> spans = [];

  void parseNode(DOOM.Node node) {
    if (node.nodeType == DOOM.Node.TEXT_NODE) {
      // Handle text nodes
      spans.add(
        TextSpan(text: node.text, style: TextStyle(color: Colors.black)),
      );
    } else if (node.nodeType == DOOM.Node.ELEMENT_NODE) {
      DOOM.Element element = node as DOOM.Element;
      if (element.localName == 'a') {
        // Handle <a> tags
        var href = element.attributes['href'];

        if (href != null && href.startsWith('mailto:')) {
          // Handle mailto links
          var email = href.replaceFirst('mailto:', '');
          spans.add(
            TextSpan(
              text: element.text,
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  // Use the _sendEmail function to open the email app
                  _sendEmail(email);
                },
            ),
          );
        } else {
          // Handle other links
          spans.add(
            TextSpan(
              text: element.text,
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  if (href != null && await canLaunchUrl(Uri.parse(href))) {
                    await launchUrl(Uri.parse(href));
                  } else {
                    throw 'Could not launch $href';
                  }
                },
            ),
          );
        }
      } else {
        // Recursively parse child nodes for other elements
        element.nodes.forEach(parseNode);
      }
    }
  }

  nodes.forEach(parseNode);

  return RichText(
    text: TextSpan(children: spans),
  );
}

void _sendEmail(String email) async {
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: email,
    queryParameters: {
      'subject': 'Your Subject Here',
      'body': 'Your email body here',
    },
  );
  await launchUrl(emailLaunchUri);
}
