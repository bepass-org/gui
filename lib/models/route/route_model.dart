import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

class RouteModel  {

  String? id;
  String? routeName;
  String? application;
  String? domain;
  bool? active;
  String? ip;
  String? port;
  String? sourcePort;
  String? network;
  String? source;
  String? protocol;
  String? outbound;


  RouteModel(
      {
        this.id,
      this.routeName,
      this.application,
      this.domain,
      this.active,
      this.ip,
      this.port,
      this.sourcePort,
      this.network,
      this.source,
      this.protocol,
      this.outbound});

  Map<String, dynamic> toJson() {
     return {
       'id': id,
       'routeName': routeName,
       'application': application,
       'domain': domain,
       'active': active,
       'ip': ip,
       'port': port,
       'sourcePort': sourcePort,
       'network': network,
       'source': source,
       'protocol': protocol,
       'outbound': outbound,

     };
   }

  RouteModel.fromJson(Map<String , dynamic> item):
        id = item["id"],
        routeName = item['routeName'],
        application = item['application'],
        domain = item['domain'],
        active = item['active'],
        ip = item['ip'],
        port = item['port'],
        sourcePort = item['sourcePort'],
        network = item['network'],
        source = item['source'],
        protocol = item['protocol'],
        outbound = item['outbound'];

  RouteModel copyWith({
    String? id,
    String? routeName,
    String? application,
    String? domain,
    bool? active,
    String? ip,
    String? port,
    String? sourcePort,
    String? network,
    String? source,
    String? protocol,
    String? outbound,
  }) {
    return RouteModel(
      id: id,
      routeName: routeName ?? this.routeName,
      application: application ?? this.application,
      domain: domain ?? this.domain,
      active: active ?? this.active,
      ip: ip ?? this.ip,
      port: port ?? this.port,
      sourcePort: sourcePort ?? this.sourcePort,
      network: network ?? this.network,
      source: source ?? this.source,
      protocol: protocol ?? this.protocol,
      outbound: outbound ?? this.outbound,
    );
  }
}