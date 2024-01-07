import 'package:defacto/ui/widgets/main_drawer.dart';
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
    // Other toggles...
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      drawer: const MainDrawer(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ListView(
        children: <Widget>[
          _buildGroupTitle('Route Settings'),
          _buildSwitchSetting('Apps VPN mode', 'Configure VPN mode for selected apps', 'Enable Sniffing'),
          _buildSwitchSetting('Bypass LAN', 'Bypass LAN in Core', 'Bypass LAN'),
          _buildEditableSetting('Resolve Destination', 'If the destination address is a domainIf the destination address is a domainIf the destination address is a domain', 'Resolve Destination'),
          _buildEditableSetting('IPv6 Route', 'Disable', 'Use Proxy'),
          Divider(),
          _buildGroupTitle('Protocol Settings'),
          _buildSwitchSetting('Enable Multiplexer', 'Mux is designed to reduce TCP handshake latency...', 'Enable Sniffing'),
          _buildEditableSetting('Rule Assets Provider', 'Chocolate4U/Iran-sing-box-rules', 'Use Proxy'),
          _buildSwitchSetting('Enable Traffic Sniffing', 'Sniff result for routing', 'Resolve Destination'),
          _buildEditableSetting('Protocol Selection', 'Automatic', 'Use Proxy'),
          Divider(),
          // Add more groups and settings here
        ],
      ),
    );
  }

  ListTile _buildSwitchSetting(String title, String subtitle, String switchKey) {
    return ListTile(
      leading: Icon(Icons.settings),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Switch(
        value: switchStates[switchKey]!,
        onChanged: (newValue) {
          setState(() {
            switchStates[switchKey] = newValue;
          });
        },
      ),
    );
  }

  ListTile _buildEditableSetting(String title, String subtitle, String switchKey) {
    return ListTile(
      leading: Icon(Icons.edit),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: () {
        // Handle tap to edit
      },
    );
  }

  Widget _buildGroupTitle(String title) {
    return ListTile(
      leading: const Text(""),
      title: Text(title, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.onBackground, fontWeight: FontWeight.bold)),
    );
  }
}
