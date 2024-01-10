import 'package:defacto/enums/editable_dialog_types.dart';
import 'package:defacto/ui/widgets/form/group.dart';
import 'package:defacto/ui/widgets/form/input_editable.dart';
import 'package:defacto/ui/widgets/form/profile_name.dart';
import 'package:defacto/ui/widgets/form/switch_editable.dart';
import 'package:flutter/material.dart';

class NewProfilePage extends StatefulWidget {
  const NewProfilePage({super.key});

  @override
  State<NewProfilePage> createState() => _NewProfilePageState();
}

class _NewProfilePageState extends State<NewProfilePage> {
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
        iconTheme: const IconThemeData(color: Colors.white),
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
          const ProfileName(),
          GroupForm(
            title: "General",
            children: [
              InputEditable(
                icon: Icons.security,
                title: 'TLS Header Length',
                defaultValue: '5',
                dialogType: EditableDialogType.number,
                onChanged: (v) {},
              ),
              InputEditable(
                icon: Icons.http,
                title: 'DOH or SDNS Address',
                defaultValue: 'https://1.1.1.1/dns-query',
                dialogType: EditableDialogType.url,
                onChanged: (v) {},
              ),
            ],
          ),
          GroupForm(
            title: "DNS Settings",
            children: [
              InputEditable(
                icon: Icons.timer,
                title: 'DNS Cache TTL',
                defaultValue: '1500',
                dialogType: EditableDialogType.number,
                onChanged: (v) {},
              ),
              InputEditable(
                icon: Icons.timelapse,
                title: 'DNS Request Timeout',
                defaultValue: '10',
                dialogType: EditableDialogType.number,
                onChanged: (v) {},
              ),
              SwitchEditable(
                icon: Icons.dns,
                title: 'Enable DNS Fragmentation',
                value: _dnsFragmentation,
                onChanged: (v) {
                  setState(() {
                    _dnsFragmentation = v;
                  });
                },
              ),
            ],
          ),
          GroupForm(
            title: "SNI Settings",
            children: [
              InputEditable(
                icon: Icons.code,
                title: 'SNI Chunks Length Range',
                defaultValue: '1,2',
                dialogType: EditableDialogType.numberRange,
                onChanged: (v) {},
              ),
              InputEditable(
                icon: Icons.code_off,
                title: 'Before and After SNI Chunks Length Range',
                defaultValue: '1,5',
                dialogType: EditableDialogType.numberRange,
                onChanged: (v) {},
              ),
              InputEditable(
                icon: Icons.hourglass_empty,
                title: 'Delay between each packet',
                defaultValue: '10,20',
                dialogType: EditableDialogType.numberRange,
                onChanged: (v) {},
              ),
            ],
          ),
          GroupForm(
            title: "Worker Settings",
            children: [
              SwitchEditable(
                icon: Icons.work,
                title: 'Enable Worker',
                value: _enableWorker,
                onChanged: (v) {
                  setState(() {
                    _enableWorker = v;
                  });
                },
              ),
              SwitchEditable(
                icon: Icons.dns,
                title: 'DNS Only',
                value: _dnsOnly,
                onChanged: (v) {
                  setState(() {
                    _dnsOnly = v;
                  });
                },
              ),
              InputEditable(
                icon: Icons.web,
                title: 'Worker Address',
                defaultValue: 'https://id.username.workers.dev/dns-query',
                dialogType: EditableDialogType.numberRange,
                onChanged: (v) {},
              ),
              InputEditable(
                icon: Icons.portable_wifi_off,
                title: 'Worker Clean IP/Host',
                defaultValue: '192.168.1.1',
                dialogType: EditableDialogType.ip,
                onChanged: (v) {},
              ),
              InputEditable(
                icon: Icons.indeterminate_check_box_outlined,
                title: 'Worker Port',
                defaultValue: '443',
                dialogType: EditableDialogType.port,
                onChanged: (v) {},
              ),
            ],
          ),
          GroupForm(
            title: "TLS Settings",
            children: [
              SwitchEditable(
                icon: Icons.dangerous,
                title: 'Allow InSecure',
                value: _allowInSecure,
                onChanged: (v) {
                  setState(() {
                    _allowInSecure = v;
                  });
                },
              ),
              SwitchEditable(
                icon: Icons.lock_outline,
                title: 'Enable TLS Padding',
                value: _enableTlsPadding,
                onChanged: (v) {
                  setState(() {
                    _enableTlsPadding = v;
                  });
                },
              ),
              InputEditable(
                icon: Icons.format_line_spacing,
                title: 'TLS Padding Range',
                defaultValue: '10,1000',
                dialogType: EditableDialogType.numberRange,
                onChanged: (v) {},
              ),
            ],
          ),
          GroupForm(
            title: "UDP Settings",
            lastOne: true,
            children: [
              InputEditable(
                icon: Icons.radar,
                title: 'UDP Bind Address',
                defaultValue: '127.0.0.1',
                dialogType: EditableDialogType.ip,
                onChanged: (v) {},
              ),
              InputEditable(
                icon: Icons.timer_off,
                title: 'UDP Read Timeout',
                defaultValue: '120',
                dialogType: EditableDialogType.number,
                onChanged: (v) {},
              ),
              InputEditable(
                icon: Icons.edit_attributes,
                title: 'UDP Write Timeout',
                defaultValue: '120',
                dialogType: EditableDialogType.number,
                onChanged: (v) {},
              ),
              InputEditable(
                icon: Icons.link_off,
                title: 'UDP Link Idle Timeout',
                defaultValue: '120',
                dialogType: EditableDialogType.number,
                onChanged: (v) {},
              ),
            ],
          ),
        ],
      ),
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

  void _saveConfiguration() {
    // Implement your save logic here
    Navigator.pop(context);
  }
}
