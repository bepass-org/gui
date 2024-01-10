class AddRouteModel {
  final AddRouteEnum id;
  final String value;

  AddRouteModel({required this.id, required this.value});

  AddRouteModel copyWith({
    AddRouteEnum? id,
    String? value,
  }) {
    return AddRouteModel(
      id: id ?? this.id,
      value: value ?? this.value,
    );
  }
}

enum AddRouteEnum { routeName, application, domain, ip, port, sourcePort, network, source, protocol, outbound }
