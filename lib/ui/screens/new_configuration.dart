import 'package:defacto/ui/widgets/components.dart';
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
    // TODO: Save new configuration
    // INFO: Need to setup constructor to collect and make a new configuration
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeData.colorScheme.primary,
        leading: IconButton(
          icon: const Icon(Icons.close),
          color: themeData.colorScheme.onPrimary,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.check),
            color: themeData.colorScheme.onPrimary,
            onPressed: () {
              _successSaved();
            },
          ),
        ],
        title: Text(
          'Add Configuration',
          style:
              TextStyle(color: themeData.colorScheme.onPrimary, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CustomTextField(
                title: 'Profile Name',
                hint: 'Not set',
                controller: _profileName,
                themeData: themeData),
            CustomTextField(
                title: 'TLS Header Length',
                hint: '5',
                controller: _tlsHeaderLength,
                themeData: themeData),
            CustomTextField(
                title: 'DOH or SDNS Address',
                hint: 'https://yarp.lefolgoc.net/dns-query',
                controller: _dohSdnsAddress,
                themeData: themeData),
            Container(
                color: themeData.colorScheme.surface,
                child: Column(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 3.0),
                    ),
                    CustomIntegerField(
                        title: 'DNS Cache TTL',
                        defaultInput: 1800,
                        controller: _dnsCacheTtl,
                        themeData: themeData),
                    CustomIntegerField(
                        title: 'DNS Request Timeout',
                        defaultInput: 10,
                        controller: _dnsReqTimeout,
                        themeData: themeData),
                    CustomSwitchListTile(
                      title: 'Enable DNS Fragmentation',
                      value: _dnsFragmentation,
                      onChanged: (bool value) {
                        setState(() {
                          _dnsFragmentation = value;
                        });
                      },
                    ),
                    CustomTextField(
                        title: 'Sni Chunks Length Range',
                        hint: '1, 5',
                        controller: _sniChunksLenRange,
                        themeData: themeData),
                    CustomTextField(
                        title: 'Before and After Sni Chunks Length Range',
                        hint: '5, 10',
                        controller: _sniBFChunksLenRange,
                        themeData: themeData),
                    CustomTextField(
                        title: 'Delay between each packet',
                        hint: '30, 40',
                        controller: _delayBetweenEachPacket,
                        themeData: themeData),
                    CustomMultilineField(
                        title: 'Domain to IP mapping(hosts)',
                        hint: '''
example.com: 1.1.1.1
yarp.lefolgoc.net: 5.39.88.20''',
                        controller: _domainToIPMapping,
                        themeData: themeData),
                    CustomCheckboxListTile(
                        title: 'AllowInSecure',
                        value: _allowInSecure,
                        onChanged: (bool? value) {
                          setState(() {
                            _allowInSecure = value!;
                          });
                        }),
                    CustomCheckboxListTile(
                      title: 'Enable Worker',
                      value: _enableWorker,
                      onChanged: (bool? value) {
                        setState(() {
                          _enableWorker = value!;
                        });
                      },
                    ),
                    Visibility(
                        visible: _enableWorker,
                        child: Column(
                          children: [
                            CustomCheckboxListTile(
                                title: 'DNS Only',
                                value: _dnsOnly,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _dnsOnly = value!;
                                  });
                                }),
                            CustomTextField(
                                title: 'Worker Address',
                                hint:
                                    'https://example.user.worker.dev/dns-query',
                                controller: _workerAddress,
                                themeData: themeData),
                            CustomTextField(
                                title: 'Worker Clean IP:PORT',
                                hint: '104.31.16.104:443',
                                controller: _workerCleanIpPort,
                                themeData: themeData),
                          ],
                        )),
                    CustomCheckboxListTile(
                        title: 'Enable TLS Padding',
                        value: _enableTlsPadding,
                        onChanged: (bool? value) {
                          setState(() {
                            _enableTlsPadding = value!;
                          });
                        }),
                    if (_enableTlsPadding)
                      CustomTextField(
                          title: 'TLS Padding Range',
                          hint: '200, 500',
                          controller: _tlsPaddingRange,
                          themeData: themeData),
                    const Divider(
                      height: 2.0,
                      color: Colors.grey,
                    ),
                    CustomTextField(
                        title: 'udpBindAddress',
                        hint: '127.0.0.1',
                        controller: _udpBindAddress,
                        themeData: themeData),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 3.0),
                    ),
                    CustomIntegerField(
                        title: 'udpReadTimeout',
                        defaultInput: 120,
                        controller: _udpReadTimeout,
                        themeData: themeData),
                    CustomIntegerField(
                        title: 'udpWriteTimeout',
                        defaultInput: 120,
                        controller: _udpWriteTimeout,
                        themeData: themeData),
                    CustomIntegerField(
                        title: 'udpLinkIdleTimeout',
                        defaultInput: 120,
                        controller: _udpLinkIdleTimeout,
                        themeData: themeData),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
