// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RouteModelImpl _$$RouteModelImplFromJson(Map<String, dynamic> json) =>
    _$RouteModelImpl(
      id: json['id'] as String?,
      routeName: json['routeName'] as String?,
      application: json['application'] as String?,
      active: json['active'] as bool?,
      ip: json['ip'] as String?,
      port: json['port'] as String?,
      sourcePort: json['sourcePort'] as String?,
      network: json['network'] as String?,
      source: json['source'] as String?,
      protocol: json['protocol'] as String?,
      outbound: json['outbound'] as String?,
    );

Map<String, dynamic> _$$RouteModelImplToJson(_$RouteModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'routeName': instance.routeName,
      'application': instance.application,
      'active': instance.active,
      'ip': instance.ip,
      'port': instance.port,
      'sourcePort': instance.sourcePort,
      'network': instance.network,
      'source': instance.source,
      'protocol': instance.protocol,
      'outbound': instance.outbound,
    };
