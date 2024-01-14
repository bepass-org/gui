import 'dart:collection';

import 'package:defacto/models/add_route_model.dart';
import 'package:defacto/models/route/route_model.dart';
import 'package:defacto/states/route/route_state.dart';
import 'package:defacto/ui/widgets/card/default_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../states/route/single_route_state.dart';

class AddRouteScreen extends ConsumerStatefulWidget {
RouteModel? routeModel;
int? index; // get index for better search and find on the list in delete and edit

AddRouteScreen({this.routeModel,this.index});

  @override
  ConsumerState<AddRouteScreen> createState() => _AddRouteScreenState(routeModel: routeModel);
}

class _AddRouteScreenState extends ConsumerState<AddRouteScreen> {
  final Map<AddRouteEnum, AddRouteModel> data = HashMap();
  TextEditingController _dialog_input_controller = TextEditingController();

  late StateNotifierProvider<SingleRouteStateNotifier, RouteModel?> SinglerouteStateProvider;
  RouteModel? routeModel;
  bool needUpdate = false;

  _AddRouteScreenState({this.routeModel}){
    SinglerouteStateProvider =
     StateNotifierProvider<SingleRouteStateNotifier, RouteModel?>((ref) {
       return SingleRouteStateNotifier(routeModel: routeModel??RouteModel());
     });

  }

  @override
  void initState() {
    super.initState();
    _fillDataList();
  }

  void _showAlertDialog(BuildContext context,{required String propertyName,String? value}) {
    _dialog_input_controller.text = value??"";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title:  Text('Route name'),
          content:  TextField(
            controller: _dialog_input_controller,
            decoration: InputDecoration(
              hintText: 'Enter value'
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                // Handle the confirm action
                // check input is empty or not
                if(_dialog_input_controller.text.isNotEmpty){

                  debugPrint("Input: ${_dialog_input_controller.text}");
                  // update item
                  ref.watch(SinglerouteStateProvider.notifier)?.UpdateRoute(propertyName: propertyName,newValue: _dialog_input_controller.text);

                  // set need update true
                  needUpdate = true;
                  // close dialog
                  Navigator.of(context).pop();
                }else{
                  // show message input is empty
                  debugPrint("Input is empty");
                }
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    routeModel = ref.watch(SinglerouteStateProvider);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title:  Text("Routing And Rules", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () {
              /// delete the [routeModel]
              /// send request of delete to the state
              /// before delete check [routeModel] is not null
              /// do this by checking [index] is null or not

              if(widget.index!=null)
                 ref.watch(routeStateProvider.notifier).DeleteRoute(widget.index!);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.delete),
          ),
          IconButton(
            onPressed: () {
              if(needUpdate && widget.index!=null){
                ref.watch(routeStateProvider.notifier).UpdateItem(routeModel!,widget.index!);
              }
              Navigator.pop(context);


            },
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
          onClick: () {
            // open dialog
            _showAlertDialog(context,value: routeModel?.routeName,propertyName: 'routeName');

          },
          padding: const EdgeInsets.only(left: 16.0, right: 16, top: 6),
          prefixWidget: const Icon(Icons.my_library_music_outlined, color: Color(0xff605b5b)),
          title: "Route Name",
          body: routeModel?.routeName ?? 'Not Set',
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
        body: routeModel?.domain ?? 'Not Set',
        onClick: () {

            // open dialog
          _showAlertDialog(context,value: routeModel?.domain,propertyName: 'domain');
        },
      ),
      const SizedBox(
        height: 24,
      ),
      DefaultListItem(
        padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 6),
        prefixWidget: const Icon(Icons.add_road, color: Color(0xff605b5b)),
        title: "ip",
        body: routeModel?.ip ?? 'Not Set',
        onClick: () {
          _showAlertDialog(context,value: routeModel?.ip,propertyName: 'ip');

        },
      ),
      const SizedBox(
        height: 24,
      ),
      DefaultListItem(
        padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 6),
        prefixWidget: const Icon(Icons.local_shipping, color: Color(0xff605b5b)),
        title: "port",
        body: routeModel?.port ?? 'Not Set',
        onClick: () {
          // open dialog
          _showAlertDialog(context,value: routeModel?.port,propertyName: 'port');

        },
      ),
      const SizedBox(
        height: 24,
      ),
      DefaultListItem(
        padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 6),
        prefixWidget: const Icon(Icons.home, color: Color(0xff605b5b)),
        title: "sourcePort",
        body: routeModel?.sourcePort ?? 'Not Set',
        onClick: () {
          // open dialog
          _showAlertDialog(context,value: routeModel?.sourcePort,propertyName: 'sourcePort');

        },
      ),
      const SizedBox(
        height: 24,
      ),
      DefaultListItem(
        padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 6),
        prefixWidget: const Icon(Icons.network_ping_sharp, color: Color(0xff605b5b)),
        title: "network",
        body: routeModel?.network ?? 'Not Set',
        onClick: () {
          // open dialog
          _showAlertDialog(context,value: routeModel?.network,propertyName: 'network');

        },
      ),
      const SizedBox(
        height: 24,
      ),
      DefaultListItem(
        padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 6),
        prefixWidget: const Icon(Icons.wine_bar, color: Color(0xff605b5b)),
        title: "source",
        body: routeModel?.source ?? 'Not Set',
        onClick: () {
          // open dialog
          _showAlertDialog(context,value: routeModel?.source,propertyName: 'source');

        },
      ),
      const SizedBox(
        height: 24,
      ),
      DefaultListItem(
        padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 6),
        prefixWidget: const Icon(Icons.propane_tank_outlined, color: Color(0xff605b5b)),
        title: "protocol",
        body: routeModel?.protocol ?? 'Not Set',
        onClick: () {
          // open dialog
          _showAlertDialog(context,value: routeModel?.protocol,propertyName: 'protocol');

        },
      ),
      const SizedBox(
        height: 24,
      ),
      DefaultListItem(
        padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 6),
        prefixWidget: const Icon(Icons.radio_outlined, color: Color(0xff605b5b)),
        title: "outbound",
        body: routeModel?.outbound ?? 'Not Set',
        onClick: () {
          // open dialog
          _showAlertDialog(context,value: routeModel?.outbound,propertyName: 'outbound');

        },
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
