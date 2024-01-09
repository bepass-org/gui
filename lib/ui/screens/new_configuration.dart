import 'package:flutter/material.dart';

class NewConfigurationPage extends StatefulWidget {
  const NewConfigurationPage({super.key});

  @override
  State<NewConfigurationPage> createState() => _NewConfigurationPageState();
}

class _NewConfigurationPageState extends State<NewConfigurationPage> {
  final TextEditingController _profileName = TextEditingController();
  final TextEditingController _tlsHeaderLength = TextEditingController();
  final TextEditingController _dohSdnsAddress = TextEditingController();
  final TextEditingController _dnsCacheTtl = TextEditingController();
  final TextEditingController _dnsReqTimeout = TextEditingController();
  final TextEditingController _sniChunksLenRange = TextEditingController();
  final TextEditingController _sniBFChunksLenRange = TextEditingController();
  final TextEditingController _delayBetweenEachPacket = TextEditingController();
  final TextEditingController _domainToIPMapping = TextEditingController();
  final TextEditingController _workerAddress = TextEditingController();
  final TextEditingController _workerCleanIpPort = TextEditingController();
  final TextEditingController _tlsPaddingRange = TextEditingController();
  final TextEditingController _udpBindAddress = TextEditingController();
  final TextEditingController _udpReadTimeout = TextEditingController();
  final TextEditingController _udpWriteTimeout = TextEditingController();
  final TextEditingController _udpLinkIdleTimeout = TextEditingController();

  bool _dnsFragmentation = false;
  bool _allowInSecure = false;
  bool _enableWorker = false;
  bool _enableTlsPadding = false;
  bool _dnsOnly = false;

  void _successSaved() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Configuration saved successfully'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                _saveConfiguration();
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _saveConfiguration,
          ),
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveConfiguration,
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: _saveConfiguration,
          ),
        ],
        title: const Text(
          'Profile Config',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          _profileNameW(),
          _buildGroup('General', [
            _buildEditableSetting('TLS Header Length',
                '5', _tlsHeaderLength, Icons.security),
            _buildEditableSetting('DOH or SDNS Address',
                'https://1.1.1.1/dns-query', _dohSdnsAddress, Icons.http),
          ]),
          _buildGroup('DNS Settings', [
            _buildEditableSetting('DNS Cache TTL', '1500',
                _dnsCacheTtl, Icons.timer),
            _buildEditableSetting('DNS Request Timeout',
                '10', _dnsReqTimeout, Icons.timelapse),
            _buildToggleSetting(
                'Enable DNS Fragmentation', _dnsFragmentation, Icons.dns),
          ]),
          _buildGroup('SNI Settings', [
            _buildEditableSetting(
                'SNI Chunks Length Range',
                '1,2',
                _sniChunksLenRange,
                Icons.code),
            _buildEditableSetting('Before and After SNI Chunks Length Range',
                '1,5', _sniBFChunksLenRange, Icons.code_off),
            _buildEditableSetting(
                'Delay between each packet',
                '10,20',
                _delayBetweenEachPacket,
                Icons.hourglass_empty),
          ]),
          _buildGroup('Worker Settings', [
            _buildToggleSetting('Enable Worker', _enableWorker, Icons.work),
            _buildToggleSetting('DNS Only', _dnsOnly, Icons.dns),
            _buildEditableSetting('Worker Address', 'worker-name.username.workers.dev',
                _workerAddress, Icons.web),
            _buildEditableSetting('Worker Clean IP:PORT', '192.168.1.1:443',
                _workerCleanIpPort, Icons.portable_wifi_off),
          ]),
          _buildGroup('TLS Settings', [
            _buildToggleSetting(
                'Allow InSecure', _allowInSecure, Icons.dangerous),
            _buildToggleSetting(
                'Enable TLS Padding', _enableTlsPadding, Icons.lock_outline),
            _buildEditableSetting(
                'TLS Padding Range',
                '10,1000',
                _tlsPaddingRange,
                Icons.format_line_spacing),
          ]),
          _buildGroup(
              'UDP Settings',
              [
                _buildEditableSetting('UDP Bind Address',
                    '127.0.0.1', _udpBindAddress, Icons.radar),
                _buildEditableSetting('UDP Read Timeout', '120',
                    _udpReadTimeout, Icons.timer_off),
                _buildEditableSetting(
                    'UDP Write Timeout',
                    '120',
                    _udpWriteTimeout,
                    Icons.edit_attributes),
                _buildEditableSetting(
                    'UDP Link Idle Timeout',
                    '120',
                    _udpLinkIdleTimeout,
                    Icons.link_off),
              ],
              lastOne: true),
        ],
      ),
    );
  }

  Widget _profileNameW() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildEditableSetting(
            'Profile Name', 'Enter profile name', _profileName, Icons.person),
        const Divider(
          color: Colors.black26,
        ),
      ],
    );
  }

  Widget _buildGroup(String title, List<Widget> settings, {lastOne = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: const Text(""),
          title: Text(title,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold)),
        ),
        ...settings,
        !lastOne
            ? const Divider(
                color: Colors.black26,
              )
            : const SizedBox(),
      ],
    );
  }

  Widget _buildToggleSetting(String title, bool value, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Switch(
        value: value,
        onChanged: (newValue) {
          setState(() {
            // Update the respective state variable
            switch (title) {
              case 'Enable DNS Fragmentation':
                _dnsFragmentation = newValue;
                break;
              case 'Allow InSecure':
                _allowInSecure = newValue;
                break;
              case 'Enable Worker':
                _enableWorker = newValue;
                break;
              case 'Enable TLS Padding':
                _enableTlsPadding = newValue;
                break;
              case 'DNS Only':
                _dnsOnly = newValue;
                break;
              default:
                break;
            }
          });
        },
      ),
    );
  }

  Widget _buildEditableSetting(String title, String hint,
      TextEditingController controller, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title, style: Theme.of(context).textTheme.titleMedium!),
      subtitle: Text(controller.text.isEmpty ? hint : controller.text),
      onTap: () => _showEditDialog(title, controller),
    );
  }

  void _saveConfiguration() {
    // Implement your save logic here
    Navigator.pop(context);
  }

  void _showEditDialog(String value, TextEditingController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Enter your value'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                setState(() {}); // Update the UI with the new value
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
