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

List<String> list = <String>[
  'Off',
  'Sniff Result for Routing',
  'Sniff Result for Destination'
];

List<String> ipv6 = <String>['Disable', 'Enable', 'Prefer', 'Only'];
List<String> assetsprovider = <String>[
  'Official',
  'Loyalsoldier',
  'Chocolate4U'
];
List<String> mux = <String>['h2mux', 'smux', 'yamux'];
List<String> dns = <String>[
  'auto',
  'prefer_ipv6',
  'prefer_ipv4',
  'ipv4_only',
  'ipv6_only'
];

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
    'Bypass LAN in core': false,
    'Resolve Destination': true,
    'Use Proxy': false,
    'Enable Multiplexer': false,
    'Enable Traffic Sniffing': false,
    'allow insecure': false,
    'dns routing': true,
    'fakedns': false,
  };
  String ipv6Route = 'Disable';
  String dropdownValue = list.first;
  String ipv6Value = ipv6.first;
  String assetsproviderValue = assetsprovider.first;
  String muxValue = mux.first;
  String dnsValue = dns.first;

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
            GroupForm(title: 'App Settings', children: [
              Padding(
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
                        builder: (BuildContext context, WidgetRef ref,
                            Widget? child) {
                          final themeNotifer = ref.watch(themeProvider);
                          return GestureDetector(
                            child: Container(
                              height: 100,
                              width: 57,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.black, width: 2),
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
              ),
            ]),
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
                SwitchEditable(
                  icon: Icons.settings,
                  title: 'Bypass LAN in core',
                  value: switchStates['Bypass LAN in core']!,
                  onChanged: (value) => setState(
                      () => switchStates['Bypass LAN in core'] = value),
                ),
                ListTile(
                    leading: Icon(Icons.manage_search_rounded),
                    title: Text('Enable Traffic Sniffing'),
                    trailing: DropdownButton(
                      value: dropdownValue,
                      icon: Icon(Icons.arrow_drop_down),
                      onChanged: (String? value) {
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )),
                SwitchEditable(
                  icon: Icons.route,
                  title: 'Resolve Destination',
                  value: switchStates['Resolve Destination']!,
                  onChanged: (value) => setState(
                      () => switchStates['Resolve Destination'] = value),
                ),
                ListTile(
                    leading: Icon(Icons.six_mp),
                    title: Text('IPv6 Route'),
                    trailing: DropdownButton(
                      value: ipv6Value,
                      icon: Icon(Icons.arrow_drop_down),
                      onChanged: (String? value) {
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      items: ipv6.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )),
                ListTile(
                    leading: Icon(Icons.folder_special),
                    title: Text('Rule Assets Provider'),
                    trailing: DropdownButton(
                      value: assetsproviderValue,
                      icon: Icon(Icons.arrow_drop_down),
                      onChanged: (String? value) {
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      items: assetsprovider
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )),
              ],
            ),
            GroupForm(
              title: 'Protocol Settings',
              children: [
                SwitchEditable(
                  icon: Icons.settings,
                  title: 'Enable Multiplexer',
                  value: switchStates['Enable Multiplexer']!,
                  onChanged: (value) => setState(
                      () => switchStates['Enable Multiplexer'] = value),
                ),
                ListTile(
                    leading: Icon(Icons.network_check),
                    title: Text('Mux protocol'),
                    trailing: DropdownButton(
                      value: muxValue,
                      icon: Icon(Icons.arrow_drop_down),
                      onChanged: (String? value) {
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      items: mux.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )),
                InputEditable(
                  icon: Icons.edit,
                  title: 'Mux Concurrent Connections',
                  defaultValue: '8',
                  dialogType: FormEditableTypes.string,
                  onChanged: (value) => setState(() => ipv6Route = value),
                ),
                SwitchEditable(
                  icon: Icons.lock_open,
                  title: 'Always Allow Insecure',
                  value: switchStates['allow insecure']!,
                  onChanged: (value) =>
                      setState(() => switchStates['allow insecure'] = value),
                ),
              ],
            ),
            GroupForm(title: 'DNS Settings', children: [
              InputEditable(
                icon: Icons.dns,
                title: 'Remote DNS',
                defaultValue: 'https://8.8.8.8/dns-query',
                dialogType: FormEditableTypes.string,
                onChanged: (value) => setState(() => ipv6Route = value),
              ),
              ListTile(
                  leading: Icon(Icons.select_all),
                  title: Text('Domain strategy for Remote'),
                  trailing: DropdownButton(
                    value: dnsValue,
                    icon: Icon(Icons.arrow_drop_down),
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    items: dns.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )),
              InputEditable(
                icon: Icons.dns,
                title: 'Direct DNS',
                defaultValue: 'https://223.5.5.5/dns-query',
                dialogType: FormEditableTypes.string,
                onChanged: (value) => setState(() => ipv6Route = value),
              ),
              ListTile(
                  leading: Icon(Icons.select_all),
                  title: Text('Domain strategy for Direct'),
                  trailing: DropdownButton(
                    value: dnsValue,
                    icon: Icon(Icons.arrow_drop_down),
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    items: dns.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )),
              ListTile(
                  leading: Icon(Icons.select_all),
                  title: Text('Domain strategy for Server Address'),
                  trailing: DropdownButton(
                    value: dnsValue,
                    icon: Icon(Icons.arrow_drop_down),
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    items: dns.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )),
              SwitchEditable(
                icon: Icons.lock_open,
                title: 'Enable DNS Routing',
                value: switchStates['dns routing']!,
                onChanged: (value) =>
                    setState(() => switchStates['dns routing'] = value),
              ),
              SwitchEditable(
                icon: Icons.lock,
                title: 'Enable FakeDNS',
                value: switchStates['fakedns']!,
                onChanged: (value) =>
                    setState(() => switchStates['fakedns'] = value),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
