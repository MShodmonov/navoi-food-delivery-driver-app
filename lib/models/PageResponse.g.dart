// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PageResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageResponse _$PageResponseFromJson(Map<String, dynamic> json) => PageResponse(
      (json['content'] as List<dynamic>)
          .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['pageable'],
      json['last'] as bool,
      json['totalElements'] as int,
      json['totalPages'] as int,
      json['numberOfElements'] as int,
      json['number'] as int,
      json['size'] as int,
      json['first'] as bool,
      json['sort'],
      json['empty'] as bool,
    );

Map<String, dynamic> _$PageResponseToJson(PageResponse instance) =>
    <String, dynamic>{
      'content': instance.content,
      'pageable': instance.pageable,
      'last': instance.last,
      'totalElements': instance.totalElements,
      'totalPages': instance.totalPages,
      'numberOfElements': instance.numberOfElements,
      'number': instance.number,
      'size': instance.size,
      'first': instance.first,
      'sort': instance.sort,
      'empty': instance.empty,
    };
