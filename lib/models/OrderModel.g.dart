// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OrderModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      json['id'] as int?,
      json['restaurantId'] as int?,
      json['deliveryTime'] as int?,
      json['deliveryCost'] as int?,
      (json['deliveryWayLength'] as num?)?.toDouble(),
      json['deliveryFeeRate'] as int?,
      json['totalSumContent'] as int?,
      json['sum'] as int?,
      json['status'] as String?,
      json['freeDelivery'] as bool?,
      json['paymentMethod'] as String?,
      (json['longitude'] as num?)?.toDouble(),
      (json['latitude'] as num?)?.toDouble(),
      json['restaurantName'] as String?,
      json['phoneNumber'] as String?,
      json['fullName'] as String?,
      json['addressTypeEnum'] as String?,
      json['building'] as String?,
      json['floor'] as int?,
      json['house'] as String?,
      json['orderCount'] as int?,
      json['createdAt'] as String?,
      json['failedOrderCount'] as int?,
      json['taxiDriverPhoneNumber'] as String?,
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'restaurantId': instance.restaurantId,
      'deliveryTime': instance.deliveryTime,
      'deliveryCost': instance.deliveryCost,
      'deliveryWayLength': instance.deliveryWayLength,
      'deliveryFeeRate': instance.deliveryFeeRate,
      'totalSumContent': instance.totalSumContent,
      'sum': instance.sum,
      'status': instance.status,
      'freeDelivery': instance.freeDelivery,
      'paymentMethod': instance.paymentMethod,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'restaurantName': instance.restaurantName,
      'phoneNumber': instance.phoneNumber,
      'fullName': instance.fullName,
      'addressTypeEnum': instance.addressTypeEnum,
      'building': instance.building,
      'floor': instance.floor,
      'house': instance.house,
      'orderCount': instance.orderCount,
      'createdAt': instance.createdAt,
      'failedOrderCount': instance.failedOrderCount,
      'taxiDriverPhoneNumber': instance.taxiDriverPhoneNumber,
    };
