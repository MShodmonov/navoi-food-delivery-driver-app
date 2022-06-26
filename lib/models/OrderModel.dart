
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'OrderModel.g.dart';
@JsonSerializable()
class OrderModel{

  late int? id;
  late int? restaurantId;
  late int? deliveryTime;
  late int? deliveryCost;
  late double? deliveryWayLength;
  late int? deliveryFeeRate;
  late int? totalSumContent;
  late int? sum;
  late String? status;
  late bool? freeDelivery;
  late String? paymentMethod;
  late double? longitude;
  late double? latitude;
  late String? restaurantName;
  late String? phoneNumber;
  late String? fullName;
  late String? addressTypeEnum;
  late String? building;
  late int? floor;
  late String? house;
  late int? orderCount;
  late String? createdAt;
  late int? failedOrderCount;
  late String? taxiDriverPhoneNumber;

  // initialDriverFee

  String getRestaurantName(){
    if(restaurantName == null){
      return "Unknown";
    }else{
      return restaurantName!;
    }
  }

  String getPhoneNumber(){
    if(phoneNumber == null){
      return "Unknown";
    }else{
      return phoneNumber!;
    }
  }

  String getAddress(){
    String address = "";
    if(addressTypeEnum != null){
      if(addressTypeEnum == "FLAT"){
        address = "$address Kvartira";
      } else if(addressTypeEnum == "HOUSE"){
        address = "$address Hovli";
      } else if(addressTypeEnum == "OFFICE"){
        address = "$address Ofis, ";
      }
    }
    if(building != null){
      address = "$address bino: $building,";
    }
    if(floor != null){
      address = "$address etash: $floor,";
    }
    return address;
  }

  String getDrivingInfo(){
    String info = "";
    if(deliveryCost != null){
      info = "$info Yetkazish narxi: $deliveryCost,";
    }
    if(deliveryTime != null){
      info = "$info Taxminan vaqt: $deliveryTime,";
    }
    if(deliveryWayLength != null){
      info = "$info Taxminan uzoqligi: $deliveryWayLength";
    }
      return info;
  }

  String getSum(){
    if(sum != null){
      return "$sum";
    }else {
      return "Unknown";
    }
  }

  String getPaymentMethod(){
    if(sum != null){
      if(paymentMethod =="CASH"){
        return "Naxt Pul";
      } else {
        return "Plastik";
      }
    }else {
      return "Unknown";
    }
  }

  String getOrderStatus(){
    if(sum != null){
      if(status =="CREATED" || status == "PENDING" || status == "ACCEPTED" || status == "PREPARING"){
        return "Tayyorlanmoqda";
      } else if (status =="READY_TO_DELIVER"){
        return "TAYYOR";
      } else if (status =="ON_THE_WAY") {
        return "Yo'lda";
      } else if (status =="DELIVERED"){
        return "Yetkazib berildi";
      } else if (status =="CLIENT_FAILED"){
        return "Client buyurtmani olmadi";
      } else if (status =="TAXI_FAILED"){
        return "Taxi haydovchi buyurtmani yetkazib bermadi";
      }  else if (status =="RESTAURANT_FAILED"){
        return "Restaurant Buyurtmani qabul qilmadi";
      } else {
        return "Unknown";
      }
    }else {
      return "Unknown";
    }
  }

  String getStatus(){
    if(status != null) {
      return "$status";
    } else {
      return "unknown";
    }
  }

  String getOrderId(){
    if(id != null) {
      return "$id";
    } else {
      return "unknown";
    }
  }



  OrderModel(
      this.id,
      this.restaurantId,
      this.deliveryTime,
      this.deliveryCost,
      this.deliveryWayLength,
      this.deliveryFeeRate,
      this.totalSumContent,
      this.sum,
      this.status,
      this.freeDelivery,
      this.paymentMethod,
      this.longitude,
      this.latitude,
      this.restaurantName,
      this.phoneNumber,
      this.fullName,
      this.addressTypeEnum,
      this.building,
      this.floor,
      this.house,
      this.orderCount,
      this.createdAt,
      this.failedOrderCount,
      this.taxiDriverPhoneNumber);

  factory OrderModel.fromJson(Map<String, dynamic> json) => _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
