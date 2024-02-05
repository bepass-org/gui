import 'dart:io';

import 'package:defacto/enums/form_editable_types.dart';
import 'package:defacto/ui/widgets/main_drawer.dart';
import 'package:defacto/ui/widgets/form/group.dart';
import 'package:defacto/ui/widgets/form/input_editable.dart';
import 'package:defacto/ui/widgets/form/switch_editable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../skeleton/skeleton_screen.dart';
import 'configuration.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:defacto/config/theme_provider.dart';

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
List<String> minTls = <String>[
  '1.3',
  '1.2',
];
List<String> serviceMode = <String>[
  'VPN',
  'Proxy',
];
List<String> tunImplementation = <String>['System', 'gVisor', 'Mixed'];
List<String> mtu = <String>[
  '1500',
  '9000',
];
List<String> speedNotification = <String>[
  '1s',
  'Disable',
  '500ms',
  '3s',
  '10s'
];
List<String> logLevel = <String>['warn', 'none', 'info', 'debug', 'trace'];

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

@HiveType(typeId: 0)
class ThemeIndexModel extends HiveObject {
  @HiveField(0)
  late int themeIndex;
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
    'httptovpn': false,
    'fromlan': false,
    'wakelock': false,
    'clashapi': false,
    'disablecertificate': false,
    'autoconnet': false,
    'Profile Traffic Statistics': true,
    'Always Show Address': false,
    'Metered Hint': false,
    'Show Direct Speed': true,
  };
  String ipv6Route = 'Disable';
  String dropdownValue = list.first;
  String ipv6Value = ipv6.first;
  String assetsproviderValue = assetsprovider.first;
  String muxValue = mux.first;
  String dnsValue = dns.first;
  String tlsValue = minTls.first;
  String serviceModeValue = serviceMode.first;
  String tunImplementationValue = tunImplementation.first;
  String mtuValue = mtu.first;
  String speedNotificationValue = speedNotification.first;
  String logLevelValue = logLevel.first;

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
      child: BasePage(
        scaffoldKey: _scaffoldKey,
        appBar: AppBar(
            automaticallyImplyLeading: Platform.isAndroid,
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: Platform.isAndroid?Theme.of(context).colorScheme.primary:Theme.of(context).colorScheme.background,
            title: const Text(
              "Settings",
              style: TextStyle(color: Colors.white),
            )),
       // drawer: const MainDrawer(),
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
                          final themeNotifier = ref.watch(themeProvider);

                          return GestureDetector(
                            child: Container(
                              height: 100,
                              width: 57,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 2),
                                color: colorsList[index],
                                shape: BoxShape.circle,
                              ),
                            ),
                            onTap: () {
                              themeNotifier.setTheme(index);
                            },
                          );
                        },
                      );
                    }),
                  ),
                ),
              ),
              ListTile(
                  leading: const Icon(Icons.update),
                  title: const Text('Service Mode'),
                  trailing: DropdownButton(
                    value: serviceModeValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    onChanged: (String? value) {
                      setState(() {
                        serviceModeValue = value!;
                      });
                    },
                    items: serviceMode
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )),
              ListTile(
                  leading: const Icon(Icons.restart_alt),
                  title: const Text('TUN Implementation'),
                  trailing: DropdownButton(
                    value: tunImplementationValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    onChanged: (String? value) {
                      setState(() {
                        tunImplementationValue = value!;
                      });
                    },
                    items: tunImplementation
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )),
              ListTile(
                  leading: const Icon(Icons.rounded_corner),
                  title: const Text('MTU'),
                  trailing: DropdownButton(
                    value: mtuValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    onChanged: (String? value) {
                      setState(() {
                        mtuValue = value!;
                      });
                    },
                    items: mtu.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )),
              ListTile(
                  leading: const Icon(Icons.timer),
                  title: const Text('Speed Notification Update Interval'),
                  trailing: DropdownButton(
                    value: speedNotificationValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    onChanged: (String? value) {
                      setState(() {
                        speedNotificationValue = value!;
                      });
                    },
                    items: speedNotification
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )),
              SwitchEditable(
                icon: Icons.person_off_outlined,
                title: 'Profile Traffic Statistics',
                value: switchStates['Profile Traffic Statistics']!,
                onChanged: (value) => setState(
                    () => switchStates['Profile Traffic Statistics'] = value),
              ),
              SwitchEditable(
                icon: Icons.cameraswitch,
                title: 'Always Show Address',
                value: switchStates['Always Show Address']!,
                onChanged: (value) =>
                    setState(() => switchStates['Always Show Address'] = value),
              ),
              SwitchEditable(
                icon: Icons.data_saver_on,
                title: 'Metered Hint',
                value: switchStates['Metered Hint']!,
                onChanged: (value) =>
                    setState(() => switchStates['Metered Hint'] = value),
              ),
              SwitchEditable(
                icon: Icons.speed,
                title: 'Show Direct Speed',
                value: switchStates['Show Direct Speed']!,
                onChanged: (value) =>
                    setState(() => switchStates['Show Direct Speed'] = value),
              ),
              ListTile(
                  leading: const Icon(Icons.bug_report),
                  title: const Text('Log Level'),
                  trailing: DropdownButton(
                    value: logLevelValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    onChanged: (String? value) {
                      setState(() {
                        logLevelValue = value!;
                      });
                    },
                    items:
                        logLevel.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )),
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
                    leading: const Icon(Icons.manage_search_rounded),
                    title: const Text('Enable Traffic Sniffing'),
                    trailing: DropdownButton(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_drop_down),
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
                    leading: const Icon(Icons.six_mp),
                    title: const Text('IPv6 Route'),
                    trailing: DropdownButton(
                      value: ipv6Value,
                      icon: const Icon(Icons.arrow_drop_down),
                      onChanged: (String? value) {
                        setState(() {
                          ipv6Value = value!;
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
                    leading: const Icon(Icons.folder_special),
                    title: const Text('Rule Assets Provider'),
                    trailing: DropdownButton(
                      value: assetsproviderValue,
                      icon: const Icon(Icons.arrow_drop_down),
                      onChanged: (String? value) {
                        setState(() {
                          assetsproviderValue = value!;
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
                    leading: const Icon(Icons.network_check),
                    title: const Text('Mux protocol'),
                    trailing: DropdownButton(
                      value: muxValue,
                      icon: const Icon(Icons.arrow_drop_down),
                      onChanged: (String? value) {
                        setState(() {
                          muxValue = value!;
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
                  leading: const Icon(Icons.select_all),
                  title: const Text('Domain strategy for Remote'),
                  trailing: DropdownButton(
                    value: dnsValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    onChanged: (String? value) {
                      setState(() {
                        dnsValue = value!;
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
                  leading: const Icon(Icons.select_all),
                  title: const Text('Domain strategy for Direct'),
                  trailing: DropdownButton(
                    value: dnsValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    onChanged: (String? value) {
                      setState(() {
                        dnsValue = value!;
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
                  leading: const Icon(Icons.select_all),
                  title: const Text('Domain strategy for Server Address'),
                  trailing: DropdownButton(
                    value: dnsValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    onChanged: (String? value) {
                      setState(() {
                        dnsValue = value!;
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
            ]),
            GroupForm(title: 'Inbound Settings', children: [
              InputEditable(
                icon: Icons.sailing,
                title: 'Proxy Port',
                defaultValue: '2080',
                dialogType: FormEditableTypes.string,
                onChanged: (value) => setState(() => ipv6Route = value),
              ),
              InputEditable(
                icon: Icons.sailing,
                title: 'Local DNS Port',
                defaultValue: '6450',
                dialogType: FormEditableTypes.string,
                onChanged: (value) => setState(() => ipv6Route = value),
              ),
              SwitchEditable(
                icon: Icons.http,
                title: 'Append HTTP Proxy to VPN',
                value: switchStates['httptovpn']!,
                onChanged: (value) =>
                    setState(() => switchStates['httptovpn'] = value),
              ),
              SwitchEditable(
                icon: Icons.arrow_circle_right,
                title: 'Allow Connections from the LAN',
                value: switchStates['fromlan']!,
                onChanged: (value) =>
                    setState(() => switchStates['fromlan'] = value),
              ),
            ]),
            GroupForm(title: 'Misc Settings', children: [
              InputEditable(
                icon: Icons.cast,
                title: 'Connection Test URL',
                defaultValue: 'http://cp.cloudflare.com',
                dialogType: FormEditableTypes.string,
                onChanged: (value) => setState(() => ipv6Route = value),
              ),
              SwitchEditable(
                icon: Icons.computer,
                title: 'Acquire Wakelock',
                value: switchStates['wakelock']!,
                onChanged: (value) =>
                    setState(() => switchStates['wakelock'] = value),
              ),
              SwitchEditable(
                icon: Icons.arrow_circle_right,
                title: 'Enable Clash API',
                value: switchStates['clashapi']!,
                onChanged: (value) =>
                    setState(() => switchStates['clashapi'] = value),
              ),
              ListTile(
                  leading: const Icon(Icons.https),
                  title: const Text('Subscription Min TLS Version'),
                  trailing: DropdownButton(
                    value: tlsValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    onChanged: (String? value) {
                      setState(() {
                        tlsValue = value!;
                      });
                    },
                    items: minTls.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )),
              SwitchEditable(
                icon: Icons.arrow_circle_right,
                title:
                    'Disable certificate checking when updating subscriptions',
                value: switchStates['disablecertificate']!,
                onChanged: (value) =>
                    setState(() => switchStates['disablecertificate'] = value),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
