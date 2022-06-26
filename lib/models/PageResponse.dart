import 'package:json_annotation/json_annotation.dart';
import 'package:some_flutter/models/OrderModel.dart';

part 'PageResponse.g.dart';

@JsonSerializable()
class PageResponse {

  List<OrderModel> content = [];
  dynamic pageable;
  late bool last;
  late int totalElements;
  late int totalPages;
  late int numberOfElements;
  late int number;
  late int size;
  late bool first;
  dynamic sort;
  late bool empty;

  PageResponse(
      this.content,
      this.pageable,
      this.last,
      this.totalElements,
      this.totalPages,
      this.numberOfElements,
      this.number,
      this.size,
      this.first,
      this.sort,
      this.empty);

  factory PageResponse.fromJson(Map<String, dynamic> json) => _$PageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PageResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
