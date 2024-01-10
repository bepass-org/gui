import 'package:defacto/states/widgets/item/default_card_misc_data.dart';
import 'package:defacto/states/widgets/item/default_list_item.dart';
import 'package:defacto/ui/screens/configuration.dart';
import 'package:defacto/ui/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:defacto/states/widgets/item/default_card.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ConfigurationScreen(),
          ),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .primary,
          title: const Text("About", style: TextStyle(color: Colors.white)),
        ),
        drawer: const MainDrawer(),
        // backgroundColor: Theme.of(context).colorScheme.background,
        backgroundColor: Colors.white,
        body: Material(
          // color: Theme.of(context).colorScheme.background,
          color: Colors.white,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DefaultCard(
                  child: _bepassWidget(context),
                ),
                DefaultCard(child: _appInfoWidget(context)),
                DefaultCard(child: _projectWidget(context)),
                DefaultCard(child: HtmlWidget(_htmlContent(), onTapUrl: _launchUrl)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bepassWidget(BuildContext context) {
    final data = DefaultCardMiscData(
      title: "Bepass Mobile",
      body: "The universal proxy toolchain for Android. written in Kotlin",
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data.title,
          style: Theme
              .of(context)
              .textTheme
              .titleSmall!
              .copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          height: 14,
        ),
        Text(
            data.body,
            style: Theme
                .of(context)
                .textTheme
                .labelLarge
        ),
      ],
    );
  }

  Widget _appInfoWidget(BuildContext context) {
    return const Column(
      children: [
        DefaultListItem(
          title: "Version",
          body: "1.2.3",
          prefixWidget: Icon(Icons.history),
        ),
        SizedBox(
          height: 14,
        ),
        DefaultListItem(
          title: "Version (bepass-core)",
          body: "bepass-extra: 1.4.0-rc3\ngo1.21.0@android/arm64\nwith_contract...",
          prefixWidget: Icon(Icons.add_chart),
        ),
        SizedBox(
          height: 14,
        ),
        DefaultListItem(
          title: "Donate",
          body: "I love money",
          prefixWidget: Icon(Icons.card_giftcard),
        ),
        SizedBox(
          height: 14,
        ),
        DefaultListItem(
          title: "Ignore battery optimizations",
          body: "Remove some restrictions",
          prefixWidget: Icon(Icons.av_timer_outlined),
        ),
      ],
    );
  }

  Widget _projectWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Project',
          style: Theme
              .of(context)
              .textTheme
              .titleSmall!
              .copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const DefaultListItem(
          title: "Source code",
          prefixWidget: Icon(Icons.bloodtype_outlined),
        ),
        const SizedBox(
          height: 14,
        ),
        const DefaultListItem(
          title: "Telegram update channel",
          prefixWidget: Icon(Icons.telegram_sharp),
        ),
      ],
    );
  }

  Future<bool> _launchUrl(url) async =>
      await canLaunchUrl(Uri.parse(url)) ? await launchUrl(Uri.parse(url)) : throw Exception('Could not launch $url');

  String _htmlContent() {
    return '''
    <h4>License</h4>
    <p style="font-size: 12px;color: #605b5b;">
    Copyright (C) 2023 by bepass-org &lt;<a href="mailto:contact-sagernet@sekai.icu">contact-bepass@bepass.org</a>&gt;<br><br>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.<br><br>

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.<br><br>

    You should have received a copy of the GNU General Public License
    along with this program. If not, see <a href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.<br><br>

    In addition, no derivative work may use the name or imply association
    with this application without prior consent.<br><br>
</p>

  ''';
  }
}
