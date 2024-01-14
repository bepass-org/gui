import 'dart:collection';

import 'package:defacto/models/add_route_model.dart';
import 'package:defacto/models/route/route_model.dart';
import 'package:defacto/states/route/route_state.dart';
import 'package:defacto/ui/widgets/card/default_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddRouteScreen extends ConsumerStatefulWidget {
RouteModel? routeModel;
int? index; // get index for better search and find on the list in delete and edit

AddRouteScreen({this.routeModel,this.index});

  @override
  ConsumerState<AddRouteScreen> createState() => _AddRouteScreenState();
}

class _AddRouteScreenState extends ConsumerState<AddRouteScreen> {
  final Map<AddRouteEnum, AddRouteModel> data = HashMap();

  @override
  void initState() {
    super.initState();
    _fillDataList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("Routing And Rules", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () {
              /// delete the [widget.routeModel]
              /// send request of delete to the state
              /// before delete check [widget.routeModel] is not null
              ///
              if(widget.routeModel!=null)
                 ref.watch(routeStateProvider.notifier).DeleteRoute(widget.index!);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.delete),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ..._headerWidget(),
            Divider(color: Colors.grey.withOpacity(0.4)),
            ..._routeSettingWidget(),
          ],
        ),
      ),
    );
  }

  List<Widget> _headerWidget() {
    return [
      DefaultListItem(
        padding: const EdgeInsets.only(left: 16.0, right: 16, top: 6),
        prefixWidget: const Icon(Icons.my_library_music_outlined, color: Color(0xff605b5b)),
        title: "Route Name",
        body: widget.routeModel?.routeName ?? 'Not Set',
      ),
      const SizedBox(
        height: 30,
      ),
      // DefaultListItem(
      //   padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 6),
      //   prefixWidget: const Icon(Icons.waves, color: Color(0xff605b5b)),
      //   title: "Applications",
      //   body: data[AddRouteEnum.application]?.value ?? 'Not Set',
      // )
    ];
  }

  List<Widget> _routeSettingWidget() {
    return [
      Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(top: 14, bottom: 16),
        padding: const EdgeInsets.only(left: 66),
        child: Text(
          'Route Setting',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      DefaultListItem(
        padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 6),
        prefixWidget: const Icon(Icons.apartment, color: Color(0xff605b5b)),
        title: "domain",
        body: widget.routeModel?.routeName ?? 'Not Set',
        onClick: () {
          // TODO : logic goes here
          debugPrint('OPEN DIALOG TO GET INFO');
        },
      ),
      const SizedBox(
        height: 24,
      ),
      DefaultListItem(
        padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 6),
        prefixWidget: const Icon(Icons.add_road, color: Color(0xff605b5b)),
        title: "ip",
        body: widget.routeModel?.ip ?? 'Not Set',
      ),
      const SizedBox(
        height: 24,
      ),
      DefaultListItem(
        padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 6),
        prefixWidget: const Icon(Icons.local_shipping, color: Color(0xff605b5b)),
        title: "port",
        body: widget.routeModel?.port ?? 'Not Set',
      ),
      const SizedBox(
        height: 24,
      ),
      DefaultListItem(
        padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 6),
        prefixWidget: const Icon(Icons.home, color: Color(0xff605b5b)),
        title: "sourcePort",
        body: widget.routeModel?.sourcePort ?? 'Not Set',
      ),
      const SizedBox(
        height: 24,
      ),
      DefaultListItem(
        padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 6),
        prefixWidget: const Icon(Icons.network_ping_sharp, color: Color(0xff605b5b)),
        title: "network",
        body: widget.routeModel?.network ?? 'Not Set',
      ),
      const SizedBox(
        height: 24,
      ),
      DefaultListItem(
        padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 6),
        prefixWidget: const Icon(Icons.wine_bar, color: Color(0xff605b5b)),
        title: "source",
        body: widget.routeModel?.source ?? 'Not Set',
      ),
      const SizedBox(
        height: 24,
      ),
      DefaultListItem(
        padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 6),
        prefixWidget: const Icon(Icons.propane_tank_outlined, color: Color(0xff605b5b)),
        title: "protocol",
        body: widget.routeModel?.protocol ?? 'Not Set',
      ),
      const SizedBox(
        height: 24,
      ),
      DefaultListItem(
        padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 6),
        prefixWidget: const Icon(Icons.radio_outlined, color: Color(0xff605b5b)),
        title: "outbound",
        body: widget.routeModel?.outbound ?? 'Not Set',
      ),
    ];
  }

  void _fillDataList() {
    data[AddRouteEnum.routeName] = (AddRouteModel(id: AddRouteEnum.routeName, value: "Not Set"));
    data[AddRouteEnum.application] = (AddRouteModel(id: AddRouteEnum.application, value: "Not Set"));
    data[AddRouteEnum.domain] = (AddRouteModel(id: AddRouteEnum.domain, value: "Not Set"));
    data[AddRouteEnum.ip] = (AddRouteModel(id: AddRouteEnum.ip, value: "Not Set"));
    data[AddRouteEnum.port] = (AddRouteModel(id: AddRouteEnum.port, value: "Not Set"));
    data[AddRouteEnum.sourcePort] = (AddRouteModel(id: AddRouteEnum.sourcePort, value: "Not Set"));
    data[AddRouteEnum.network] = (AddRouteModel(id: AddRouteEnum.network, value: "Not Set"));
    data[AddRouteEnum.source] = (AddRouteModel(id: AddRouteEnum.source, value: "Not Set"));
    data[AddRouteEnum.protocol] = (AddRouteModel(id: AddRouteEnum.protocol, value: "Not Set"));
    data[AddRouteEnum.outbound] = (AddRouteModel(id: AddRouteEnum.outbound, value: "Not Set"));


    print("--- name: ${data[AddRouteEnum.routeName]?.value}" );
  }
}
