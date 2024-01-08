import 'package:defacto/ui/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

import 'configuration.dart';

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
  String ipv6Route = 'Disable'; // Example value for the IPv6 Route setting

  void _showEditDialog(String title, String currentValue, Function(String) onUpdate) {
    TextEditingController _controller = TextEditingController(text: currentValue);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: "Enter your value here"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                onUpdate(_controller.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


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
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text("Settings", style: TextStyle(color: Colors.white)),
        ),
        drawer: const MainDrawer(),
        backgroundColor: Colors.white,
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
      ),
    );
  }

  ListTile _buildSwitchSetting(String title, String subtitle, String switchKey) {
    return ListTile(
      leading: Icon(Icons.settings),
      title: Text(title, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.onBackground, fontWeight: FontWeight.bold)),
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
      title: Text(title, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.onBackground, fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      onTap: () {
        _showEditDialog('IPv6 Route', ipv6Route, (newValue) {
          setState(() {
            ipv6Route = newValue;
          });
        });
      },
    );
  }

  Widget _buildGroupTitle(String title) {
    return ListTile(
      leading: const Text(""),
      title: Text(title, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
    );
  }
}
