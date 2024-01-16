import 'package:defacto/enums/form_editable_types.dart';
import 'package:defacto/ui/widgets/main_drawer.dart';
import 'package:defacto/ui/widgets/form/group.dart';
import 'package:defacto/ui/widgets/form/input_editable.dart';
import 'package:defacto/ui/widgets/form/switch_editable.dart';
import 'package:flutter/material.dart';

import 'configuration.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:defacto/config/theme_provider.dart';
import 'package:defacto/config/styles.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Map<String, bool> switchStates = {
    'Enable Sniffing': true,
    'Bypass LAN': false,
    'Resolve Destination': true,
    'Use Proxy': false,
    'Enable Multiplexer': false,
    'Enable Traffic Sniffing': false,
  };
  String ipv6Route = 'Disable';

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
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (_scaffoldKey.currentState!.isDrawerOpen) {
          _scaffoldKey.currentState!.closeDrawer();
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ConfigurationScreen(),
            ),
          );
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Theme.of(context).colorScheme.background,
            title: const Text(
              "Settings",
            )),
        drawer: const MainDrawer(),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: ListView(
          children: <Widget>[
            GroupForm(
              title: 'Route Settings',
              children: [
                SwitchEditable(
                  icon: Icons.settings,
                  title: 'Apps VPN mode',
                  value: switchStates['Enable Sniffing']!,
                  onChanged: (value) =>
                      setState(() => switchStates['Enable Sniffing'] = value),
                ),
                SwitchEditable(
                  icon: Icons.settings,
                  title: 'Bypass LAN',
                  value: switchStates['Bypass LAN']!,
                  onChanged: (value) =>
                      setState(() => switchStates['Bypass LAN'] = value),
                ),
                InputEditable(
                  icon: Icons.edit,
                  title: 'Resolve Destination',
                  defaultValue: 'If the destination address is a domain',
                  dialogType: FormEditableTypes.string,
                  onChanged: (value) => setState(() {}),
                ),
                InputEditable(
                  icon: Icons.edit,
                  title: 'IPv6 Route',
                  defaultValue: ipv6Route,
                  dialogType: FormEditableTypes.string,
                  onChanged: (value) => setState(() => ipv6Route = value),
                ),
              ],
            ),
            GroupForm(
              title: 'Protocol Settings',
              lastOne: true,
              children: [
                SwitchEditable(
                  icon: Icons.settings,
                  title: 'Enable Multiplexer',
                  value: switchStates['Enable Multiplexer']!,
                  onChanged: (value) => setState(
                      () => switchStates['Enable Multiplexer'] = value),
                ),
                InputEditable(
                  icon: Icons.edit,
                  title: 'Rule Assets Provider',
                  hint: 'Chocolate4U/Iran-sing-box-rules',
                  defaultValue: 'If the destination address is a domain',
                  dialogType: FormEditableTypes.string,
                  onChanged: (value) => setState(() {}),
                ),
                SwitchEditable(
                  icon: Icons.settings,
                  title: 'Enable Traffic Sniffing',
                  value: switchStates['Enable Traffic Sniffing']!,
                  onChanged: (value) => setState(
                      () => switchStates['Enable Traffic Sniffing'] = value),
                ),
                InputEditable(
                  icon: Icons.edit,
                  title: 'Protocol Selection',
                  defaultValue: 'Automatic',
                  dialogType: FormEditableTypes.string,
                  onChanged: (value) => setState(() => ipv6Route = value),
                ),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ListView.builder(
                physics: const PageScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: colorsList.length,
                shrinkWrap: true,
                itemBuilder: ((context, index) {
                  return Consumer(
                    builder:
                        (BuildContext context, WidgetRef ref, Widget? child) {
                      final themeNotifer = ref.watch(themeProvider);
                      return GestureDetector(
                        child: Container(
                          height: 100,
                          width: 90,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 2),
                              color: colorsList[index],
                              shape: BoxShape.circle),
                        ),
                        onTap: () {
                          themeNotifer.setTheme(index);
                        },
                      );
                    },
                  );
                }),
              ),
            ),
            // ... Add more GroupForm widgets for other settings groups ...
          ],
        ),
      ),
    );
  }
}
