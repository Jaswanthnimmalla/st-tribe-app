// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'groupbyin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupByInModel _$GroupByInModelFromJson(Map<String, dynamic> json) =>
    GroupByInModel(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      about: json['about'] as String?,
      coverImg: json['coverImg'] as String?,
      startDate: json['startDate'] as String?,
      target: json['target'] as num,
      sold: json['sold'] as num,
      location: json['location'] as String?,
      featured: json['featured'] as bool?,
      offerEndDate: json['offerEndDate'] as String?,
      originalPrice: json['originalPrice'] as num?,
      discountedPrice: json['discountedPrice'] as num?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      purchased: json['purchased'] as bool?,
      status: json['status'] as String?,
      pendingBookingId: json['pendingBookingId'],
    );

Map<String, dynamic> _$GroupByInModelToJson(GroupByInModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'about': instance.about,
      'coverImg': instance.coverImg,
      'startDate': instance.startDate,
      'target': instance.target,
      'sold': instance.sold,
      'location': instance.location,
      'featured': instance.featured,
      'offerEndDate': instance.offerEndDate,
      'originalPrice': instance.originalPrice,
      'discountedPrice': instance.discountedPrice,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'purchased': instance.purchased,
      'status': instance.status,
      'pendingBookingId': instance.pendingBookingId,
    };
