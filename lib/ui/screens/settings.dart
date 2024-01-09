import 'package:defacto/enums/editable_dialog_types.dart';
import 'package:defacto/ui/widgets/main_drawer.dart';
import 'package:defacto/ui/widgets/form/group.dart';
import 'package:defacto/ui/widgets/form/input_editable.dart';
import 'package:defacto/ui/widgets/form/switch_editable.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Map<String, bool> switchStates = {
    'Enable Sniffing': true,
    'Bypass LAN': false,
    'Resolve Destination': true,
    'Use Proxy': false,
    'Enable Multiplexer': false,
    'Enable Traffic Sniffing': false,
  };
  String ipv6Route = 'Disable';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("Settings", style: TextStyle(color: Colors.white)),
      ),
      drawer: const MainDrawer(),
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          GroupForm(
            title: 'Route Settings',
            children: [
              SwitchEditable(
                icon: Icons.settings,
                title: 'Apps VPN mode',
                value: switchStates['Enable Sniffing']!,
                onChanged: (value) => setState(() => switchStates['Enable Sniffing'] = value),
              ),
              SwitchEditable(
                icon: Icons.settings,
                title: 'Bypass LAN',
                value: switchStates['Bypass LAN']!,
                onChanged: (value) => setState(() => switchStates['Bypass LAN'] = value),
              ),
              InputEditable(
                icon: Icons.edit,
                title: 'Resolve Destination',
                defaultValue: 'If the destination address is a domain',
                dialogType: EditableDialogType.string,
                onChanged: (value) => setState(() {}),
              ),
              InputEditable(
                icon: Icons.edit,
                title: 'IPv6 Route',
                defaultValue: ipv6Route,
                dialogType: EditableDialogType.string,
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
                onChanged: (value) => setState(() => switchStates['Enable Multiplexer'] = value),
              ),
              InputEditable(
                icon: Icons.edit,
                title: 'Rule Assets Provider',
                hint: 'Chocolate4U/Iran-sing-box-rules',
                defaultValue: 'If the destination address is a domain',
                dialogType: EditableDialogType.string,
                onChanged: (value) => setState(() {}),
              ),
              SwitchEditable(
                icon: Icons.settings,
                title: 'Enable Traffic Sniffing',
                value: switchStates['Enable Traffic Sniffing']!,
                onChanged: (value) => setState(() => switchStates['Enable Traffic Sniffing'] = value),
              ),
              InputEditable(
                icon: Icons.edit,
                title: 'Protocol Selection',
                defaultValue: 'Automatic',
                dialogType: EditableDialogType.string,
                onChanged: (value) => setState(() => ipv6Route = value),
              ),
            ],
          ),
          // ... Add more GroupForm widgets for other settings groups ...
        ],
      ),
    );
  }
}