import 'dart:io';

import 'package:defacto/ui/screens/configuration.dart';
import 'package:defacto/ui/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const gapBetweenCards = Gap(8);//this is the gap between cards
    const gapBetweenHeaderAndElements = Gap(8);//this is the gap between header and elements in the card for example between title and description
    const gapBetweenElementsInTheCard = Gap(0);//this is the gap between elements in the card
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
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text("About", style: TextStyle(color: Colors.white)),
        ),
        drawer: const MainDrawer(),
        backgroundColor: Theme.of(context).colorScheme.background,
        //using listview to avoid overflow in small screen
        body: ListView(
          padding: const EdgeInsets.all(16.0),//padding for all sides in the listview
          children: [
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Defacto Proxy App",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    gapBetweenHeaderAndElements,
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "Bypassing the Great Firewall (GFW)",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            gapBetweenCards,
            // Versions Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MetaWithIcon(
                      icon: Icons.update,
                      title: "Version",
                      description: "1.0.0",
                    ),
                    gapBetweenElementsInTheCard,
                    const MetaWithIcon(
                      icon: Icons.layers,
                      title: "Version (sing-box)",
                      description: "sing-box-1.0.0\nsing-box-1.0.1\nsing-box-2.0.0",
                    ),
                    gapBetweenElementsInTheCard,
                    InkWell(
                      onTap: (){
                        //todo: redirect to the donate page
                        debugPrint("I am tapped :)");
                      },
                      child: const MetaWithIcon(
                        icon: Icons.wallet_giftcard_outlined,
                        title: "Donate",
                        description: "Well, Every penny counts!",
                      ),
                    ),
                    gapBetweenElementsInTheCard,
                    if(Platform.isAndroid)
                      //add button to ignore battery optimization
                      InkWell(
                        onTap: (){
                          //todo: ignore this feature requires install new package
                          debugPrint("I am tapped :)");
                        },
                        child: const MetaWithIcon(
                          icon: Icons.battery_1_bar_sharp,
                          title: "Ignore Battery Optimization",
                          description: "This will help to keep the app running in background",
                        ),
                      ),
                  ],
                ),
              ),
            ),
            gapBetweenCards,
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Project",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    gapBetweenHeaderAndElements,
                    InkWell(
                      onTap: (){
                        //open github project page
                        launchUrlString("https://github.com/bepass-org");
                      },
                      child: const MetaWithIcon(
                        icon: Icons.code,
                        title: "Source code"
                      ),
                    ),
                    gapBetweenElementsInTheCard,
                    InkWell(
                      onTap: (){
                        //todo: add telegram group link
                        debugPrint("I am tapped :)");
                      },
                      child: const MetaWithIcon(
                          icon: Icons.telegram,
                          title: "Telegram update channel"
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Links Card
            gapBetweenCards,
            // Licenses Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "License",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    gapBetweenHeaderAndElements,
                    InkWell(
                      onTap: (){
                        //open github project page
                        launchUrlString("https://github.com/bepass-org");
                      },
                      child: const MetaWithIcon(
                          icon: Icons.copyright,
                          title: "License details"
                      ),
                    ),
                    gapBetweenHeaderAndElements,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class MetaWithIcon extends StatelessWidget {
  const MetaWithIcon({super.key, required this.icon, required this.title, this.description});
  final IconData icon;
  final String title;
  final String? description;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),//this padding help clickable item easier to touch
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 24,
          ),
          const Gap(16),
          Expanded(//expanded to fill the remaining space
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                if(description != null)
                  Text(
                  description!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
