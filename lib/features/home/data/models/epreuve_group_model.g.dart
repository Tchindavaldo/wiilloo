// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'epreuve_group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EpreuveGroupModelImpl _$$EpreuveGroupModelImplFromJson(
  Map<String, dynamic> json,
) => _$EpreuveGroupModelImpl(
  id: json['id'] as String,
  groupBy: (json['groupBy'] as List<dynamic>).map((e) => e as String).toList(),
  groupKey: json['groupKey'] as String,
  groupFields: json['groupFields'] as Map<String, dynamic>,
  epreuves: (json['epreuves'] as List<dynamic>)
      .map(
        (e) =>
            e == null ? null : EpreuveModel.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
  hasMoreHorizontal: json['hasMoreHorizontal'] as bool? ?? false,
  isLoadingHorizontal: json['isLoadingHorizontal'] as bool? ?? false,
  nextHorizontalCursor: (json['nextHorizontalCursor'] as num?)?.toInt(),
  currentHorizontalOffset:
      (json['currentHorizontalOffset'] as num?)?.toInt() ?? 0,
  totalInGroup: (json['totalInGroup'] as num?)?.toInt(),
);

Map<String, dynamic> _$$EpreuveGroupModelImplToJson(
  _$EpreuveGroupModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'groupBy': instance.groupBy,
  'groupKey': instance.groupKey,
  'groupFields': instance.groupFields,
  'epreuves': instance.epreuves,
  'hasMoreHorizontal': instance.hasMoreHorizontal,
  'isLoadingHorizontal': instance.isLoadingHorizontal,
  'nextHorizontalCursor': instance.nextHorizontalCursor,
  'currentHorizontalOffset': instance.currentHorizontalOffset,
  'totalInGroup': instance.totalInGroup,
};

_$PaginationModelImpl _$$PaginationModelImplFromJson(
  Map<String, dynamic> json,
) => _$PaginationModelImpl(
  cursor: (json['cursor'] as num).toInt(),
  nextCursor: (json['nextCursor'] as num?)?.toInt(),
  limit: (json['limit'] as num).toInt(),
  hasMore: json['hasMore'] as bool,
  totalAvailable: (json['totalAvailable'] as num).toInt(),
);

Map<String, dynamic> _$$PaginationModelImplToJson(
  _$PaginationModelImpl instance,
) => <String, dynamic>{
  'cursor': instance.cursor,
  'nextCursor': instance.nextCursor,
  'limit': instance.limit,
  'hasMore': instance.hasMore,
  'totalAvailable': instance.totalAvailable,
};

_$LastDocModelImpl _$$LastDocModelImplFromJson(Map<String, dynamic> json) =>
    _$LastDocModelImpl(
      id: json['id'] as String,
      lastDocId: json['lastDocId'] as String,
      lastDocData: json['lastDocData'] as String,
    );

Map<String, dynamic> _$$LastDocModelImplToJson(_$LastDocModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lastDocId': instance.lastDocId,
      'lastDocData': instance.lastDocData,
    };

_$EpreuvesResponseModelImpl _$$EpreuvesResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$EpreuvesResponseModelImpl(
  success: json['success'] as bool,
  items: (json['items'] as List<dynamic>)
      .map((e) => EpreuveGroupModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  pagination: PaginationModel.fromJson(
    json['pagination'] as Map<String, dynamic>,
  ),
  lastDoc: json['lastDoc'] == null
      ? null
      : LastDocModel.fromJson(json['lastDoc'] as Map<String, dynamic>),
  nextPageParams: json['nextPageParams'] as Map<String, dynamic>?,
  source: json['source'] as String,
);

Map<String, dynamic> _$$EpreuvesResponseModelImplToJson(
  _$EpreuvesResponseModelImpl instance,
) => <String, dynamic>{
  'success': instance.success,
  'items': instance.items,
  'pagination': instance.pagination,
  'lastDoc': instance.lastDoc,
  'nextPageParams': instance.nextPageParams,
  'source': instance.source,
};
