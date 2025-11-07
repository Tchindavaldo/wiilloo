// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'epreuve_group_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

EpreuveGroupModel _$EpreuveGroupModelFromJson(Map<String, dynamic> json) {
  return _EpreuveGroupModel.fromJson(json);
}

/// @nodoc
mixin _$EpreuveGroupModel {
  String get id => throw _privateConstructorUsedError;
  List<String> get groupBy => throw _privateConstructorUsedError;
  String get groupKey => throw _privateConstructorUsedError;
  Map<String, dynamic> get groupFields => throw _privateConstructorUsedError;
  List<EpreuveModel?> get epreuves =>
      throw _privateConstructorUsedError; // Horizontal pagination metadata
  bool get hasMoreHorizontal => throw _privateConstructorUsedError;
  bool get isLoadingHorizontal => throw _privateConstructorUsedError;
  int? get nextHorizontalCursor => throw _privateConstructorUsedError;
  int get currentHorizontalOffset => throw _privateConstructorUsedError;
  int? get totalInGroup => throw _privateConstructorUsedError;

  /// Serializes this EpreuveGroupModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EpreuveGroupModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EpreuveGroupModelCopyWith<EpreuveGroupModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EpreuveGroupModelCopyWith<$Res> {
  factory $EpreuveGroupModelCopyWith(
    EpreuveGroupModel value,
    $Res Function(EpreuveGroupModel) then,
  ) = _$EpreuveGroupModelCopyWithImpl<$Res, EpreuveGroupModel>;
  @useResult
  $Res call({
    String id,
    List<String> groupBy,
    String groupKey,
    Map<String, dynamic> groupFields,
    List<EpreuveModel?> epreuves,
    bool hasMoreHorizontal,
    bool isLoadingHorizontal,
    int? nextHorizontalCursor,
    int currentHorizontalOffset,
    int? totalInGroup,
  });
}

/// @nodoc
class _$EpreuveGroupModelCopyWithImpl<$Res, $Val extends EpreuveGroupModel>
    implements $EpreuveGroupModelCopyWith<$Res> {
  _$EpreuveGroupModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EpreuveGroupModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupBy = null,
    Object? groupKey = null,
    Object? groupFields = null,
    Object? epreuves = null,
    Object? hasMoreHorizontal = null,
    Object? isLoadingHorizontal = null,
    Object? nextHorizontalCursor = freezed,
    Object? currentHorizontalOffset = null,
    Object? totalInGroup = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            groupBy: null == groupBy
                ? _value.groupBy
                : groupBy // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            groupKey: null == groupKey
                ? _value.groupKey
                : groupKey // ignore: cast_nullable_to_non_nullable
                      as String,
            groupFields: null == groupFields
                ? _value.groupFields
                : groupFields // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            epreuves: null == epreuves
                ? _value.epreuves
                : epreuves // ignore: cast_nullable_to_non_nullable
                      as List<EpreuveModel?>,
            hasMoreHorizontal: null == hasMoreHorizontal
                ? _value.hasMoreHorizontal
                : hasMoreHorizontal // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLoadingHorizontal: null == isLoadingHorizontal
                ? _value.isLoadingHorizontal
                : isLoadingHorizontal // ignore: cast_nullable_to_non_nullable
                      as bool,
            nextHorizontalCursor: freezed == nextHorizontalCursor
                ? _value.nextHorizontalCursor
                : nextHorizontalCursor // ignore: cast_nullable_to_non_nullable
                      as int?,
            currentHorizontalOffset: null == currentHorizontalOffset
                ? _value.currentHorizontalOffset
                : currentHorizontalOffset // ignore: cast_nullable_to_non_nullable
                      as int,
            totalInGroup: freezed == totalInGroup
                ? _value.totalInGroup
                : totalInGroup // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EpreuveGroupModelImplCopyWith<$Res>
    implements $EpreuveGroupModelCopyWith<$Res> {
  factory _$$EpreuveGroupModelImplCopyWith(
    _$EpreuveGroupModelImpl value,
    $Res Function(_$EpreuveGroupModelImpl) then,
  ) = __$$EpreuveGroupModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    List<String> groupBy,
    String groupKey,
    Map<String, dynamic> groupFields,
    List<EpreuveModel?> epreuves,
    bool hasMoreHorizontal,
    bool isLoadingHorizontal,
    int? nextHorizontalCursor,
    int currentHorizontalOffset,
    int? totalInGroup,
  });
}

/// @nodoc
class __$$EpreuveGroupModelImplCopyWithImpl<$Res>
    extends _$EpreuveGroupModelCopyWithImpl<$Res, _$EpreuveGroupModelImpl>
    implements _$$EpreuveGroupModelImplCopyWith<$Res> {
  __$$EpreuveGroupModelImplCopyWithImpl(
    _$EpreuveGroupModelImpl _value,
    $Res Function(_$EpreuveGroupModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EpreuveGroupModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupBy = null,
    Object? groupKey = null,
    Object? groupFields = null,
    Object? epreuves = null,
    Object? hasMoreHorizontal = null,
    Object? isLoadingHorizontal = null,
    Object? nextHorizontalCursor = freezed,
    Object? currentHorizontalOffset = null,
    Object? totalInGroup = freezed,
  }) {
    return _then(
      _$EpreuveGroupModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        groupBy: null == groupBy
            ? _value._groupBy
            : groupBy // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        groupKey: null == groupKey
            ? _value.groupKey
            : groupKey // ignore: cast_nullable_to_non_nullable
                  as String,
        groupFields: null == groupFields
            ? _value._groupFields
            : groupFields // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        epreuves: null == epreuves
            ? _value._epreuves
            : epreuves // ignore: cast_nullable_to_non_nullable
                  as List<EpreuveModel?>,
        hasMoreHorizontal: null == hasMoreHorizontal
            ? _value.hasMoreHorizontal
            : hasMoreHorizontal // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingHorizontal: null == isLoadingHorizontal
            ? _value.isLoadingHorizontal
            : isLoadingHorizontal // ignore: cast_nullable_to_non_nullable
                  as bool,
        nextHorizontalCursor: freezed == nextHorizontalCursor
            ? _value.nextHorizontalCursor
            : nextHorizontalCursor // ignore: cast_nullable_to_non_nullable
                  as int?,
        currentHorizontalOffset: null == currentHorizontalOffset
            ? _value.currentHorizontalOffset
            : currentHorizontalOffset // ignore: cast_nullable_to_non_nullable
                  as int,
        totalInGroup: freezed == totalInGroup
            ? _value.totalInGroup
            : totalInGroup // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EpreuveGroupModelImpl implements _EpreuveGroupModel {
  const _$EpreuveGroupModelImpl({
    required this.id,
    required final List<String> groupBy,
    required this.groupKey,
    required final Map<String, dynamic> groupFields,
    required final List<EpreuveModel?> epreuves,
    this.hasMoreHorizontal = false,
    this.isLoadingHorizontal = false,
    this.nextHorizontalCursor,
    this.currentHorizontalOffset = 0,
    this.totalInGroup,
  }) : _groupBy = groupBy,
       _groupFields = groupFields,
       _epreuves = epreuves;

  factory _$EpreuveGroupModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EpreuveGroupModelImplFromJson(json);

  @override
  final String id;
  final List<String> _groupBy;
  @override
  List<String> get groupBy {
    if (_groupBy is EqualUnmodifiableListView) return _groupBy;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_groupBy);
  }

  @override
  final String groupKey;
  final Map<String, dynamic> _groupFields;
  @override
  Map<String, dynamic> get groupFields {
    if (_groupFields is EqualUnmodifiableMapView) return _groupFields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_groupFields);
  }

  final List<EpreuveModel?> _epreuves;
  @override
  List<EpreuveModel?> get epreuves {
    if (_epreuves is EqualUnmodifiableListView) return _epreuves;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_epreuves);
  }

  // Horizontal pagination metadata
  @override
  @JsonKey()
  final bool hasMoreHorizontal;
  @override
  @JsonKey()
  final bool isLoadingHorizontal;
  @override
  final int? nextHorizontalCursor;
  @override
  @JsonKey()
  final int currentHorizontalOffset;
  @override
  final int? totalInGroup;

  @override
  String toString() {
    return 'EpreuveGroupModel(id: $id, groupBy: $groupBy, groupKey: $groupKey, groupFields: $groupFields, epreuves: $epreuves, hasMoreHorizontal: $hasMoreHorizontal, isLoadingHorizontal: $isLoadingHorizontal, nextHorizontalCursor: $nextHorizontalCursor, currentHorizontalOffset: $currentHorizontalOffset, totalInGroup: $totalInGroup)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EpreuveGroupModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._groupBy, _groupBy) &&
            (identical(other.groupKey, groupKey) ||
                other.groupKey == groupKey) &&
            const DeepCollectionEquality().equals(
              other._groupFields,
              _groupFields,
            ) &&
            const DeepCollectionEquality().equals(other._epreuves, _epreuves) &&
            (identical(other.hasMoreHorizontal, hasMoreHorizontal) ||
                other.hasMoreHorizontal == hasMoreHorizontal) &&
            (identical(other.isLoadingHorizontal, isLoadingHorizontal) ||
                other.isLoadingHorizontal == isLoadingHorizontal) &&
            (identical(other.nextHorizontalCursor, nextHorizontalCursor) ||
                other.nextHorizontalCursor == nextHorizontalCursor) &&
            (identical(
                  other.currentHorizontalOffset,
                  currentHorizontalOffset,
                ) ||
                other.currentHorizontalOffset == currentHorizontalOffset) &&
            (identical(other.totalInGroup, totalInGroup) ||
                other.totalInGroup == totalInGroup));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    const DeepCollectionEquality().hash(_groupBy),
    groupKey,
    const DeepCollectionEquality().hash(_groupFields),
    const DeepCollectionEquality().hash(_epreuves),
    hasMoreHorizontal,
    isLoadingHorizontal,
    nextHorizontalCursor,
    currentHorizontalOffset,
    totalInGroup,
  );

  /// Create a copy of EpreuveGroupModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EpreuveGroupModelImplCopyWith<_$EpreuveGroupModelImpl> get copyWith =>
      __$$EpreuveGroupModelImplCopyWithImpl<_$EpreuveGroupModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$EpreuveGroupModelImplToJson(this);
  }
}

abstract class _EpreuveGroupModel implements EpreuveGroupModel {
  const factory _EpreuveGroupModel({
    required final String id,
    required final List<String> groupBy,
    required final String groupKey,
    required final Map<String, dynamic> groupFields,
    required final List<EpreuveModel?> epreuves,
    final bool hasMoreHorizontal,
    final bool isLoadingHorizontal,
    final int? nextHorizontalCursor,
    final int currentHorizontalOffset,
    final int? totalInGroup,
  }) = _$EpreuveGroupModelImpl;

  factory _EpreuveGroupModel.fromJson(Map<String, dynamic> json) =
      _$EpreuveGroupModelImpl.fromJson;

  @override
  String get id;
  @override
  List<String> get groupBy;
  @override
  String get groupKey;
  @override
  Map<String, dynamic> get groupFields;
  @override
  List<EpreuveModel?> get epreuves; // Horizontal pagination metadata
  @override
  bool get hasMoreHorizontal;
  @override
  bool get isLoadingHorizontal;
  @override
  int? get nextHorizontalCursor;
  @override
  int get currentHorizontalOffset;
  @override
  int? get totalInGroup;

  /// Create a copy of EpreuveGroupModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EpreuveGroupModelImplCopyWith<_$EpreuveGroupModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PaginationModel _$PaginationModelFromJson(Map<String, dynamic> json) {
  return _PaginationModel.fromJson(json);
}

/// @nodoc
mixin _$PaginationModel {
  int get cursor => throw _privateConstructorUsedError;
  int? get nextCursor => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;
  int get totalAvailable => throw _privateConstructorUsedError;

  /// Serializes this PaginationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaginationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaginationModelCopyWith<PaginationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginationModelCopyWith<$Res> {
  factory $PaginationModelCopyWith(
    PaginationModel value,
    $Res Function(PaginationModel) then,
  ) = _$PaginationModelCopyWithImpl<$Res, PaginationModel>;
  @useResult
  $Res call({
    int cursor,
    int? nextCursor,
    int limit,
    bool hasMore,
    int totalAvailable,
  });
}

/// @nodoc
class _$PaginationModelCopyWithImpl<$Res, $Val extends PaginationModel>
    implements $PaginationModelCopyWith<$Res> {
  _$PaginationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaginationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cursor = null,
    Object? nextCursor = freezed,
    Object? limit = null,
    Object? hasMore = null,
    Object? totalAvailable = null,
  }) {
    return _then(
      _value.copyWith(
            cursor: null == cursor
                ? _value.cursor
                : cursor // ignore: cast_nullable_to_non_nullable
                      as int,
            nextCursor: freezed == nextCursor
                ? _value.nextCursor
                : nextCursor // ignore: cast_nullable_to_non_nullable
                      as int?,
            limit: null == limit
                ? _value.limit
                : limit // ignore: cast_nullable_to_non_nullable
                      as int,
            hasMore: null == hasMore
                ? _value.hasMore
                : hasMore // ignore: cast_nullable_to_non_nullable
                      as bool,
            totalAvailable: null == totalAvailable
                ? _value.totalAvailable
                : totalAvailable // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaginationModelImplCopyWith<$Res>
    implements $PaginationModelCopyWith<$Res> {
  factory _$$PaginationModelImplCopyWith(
    _$PaginationModelImpl value,
    $Res Function(_$PaginationModelImpl) then,
  ) = __$$PaginationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int cursor,
    int? nextCursor,
    int limit,
    bool hasMore,
    int totalAvailable,
  });
}

/// @nodoc
class __$$PaginationModelImplCopyWithImpl<$Res>
    extends _$PaginationModelCopyWithImpl<$Res, _$PaginationModelImpl>
    implements _$$PaginationModelImplCopyWith<$Res> {
  __$$PaginationModelImplCopyWithImpl(
    _$PaginationModelImpl _value,
    $Res Function(_$PaginationModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaginationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cursor = null,
    Object? nextCursor = freezed,
    Object? limit = null,
    Object? hasMore = null,
    Object? totalAvailable = null,
  }) {
    return _then(
      _$PaginationModelImpl(
        cursor: null == cursor
            ? _value.cursor
            : cursor // ignore: cast_nullable_to_non_nullable
                  as int,
        nextCursor: freezed == nextCursor
            ? _value.nextCursor
            : nextCursor // ignore: cast_nullable_to_non_nullable
                  as int?,
        limit: null == limit
            ? _value.limit
            : limit // ignore: cast_nullable_to_non_nullable
                  as int,
        hasMore: null == hasMore
            ? _value.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        totalAvailable: null == totalAvailable
            ? _value.totalAvailable
            : totalAvailable // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PaginationModelImpl implements _PaginationModel {
  const _$PaginationModelImpl({
    required this.cursor,
    this.nextCursor,
    required this.limit,
    required this.hasMore,
    required this.totalAvailable,
  });

  factory _$PaginationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaginationModelImplFromJson(json);

  @override
  final int cursor;
  @override
  final int? nextCursor;
  @override
  final int limit;
  @override
  final bool hasMore;
  @override
  final int totalAvailable;

  @override
  String toString() {
    return 'PaginationModel(cursor: $cursor, nextCursor: $nextCursor, limit: $limit, hasMore: $hasMore, totalAvailable: $totalAvailable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginationModelImpl &&
            (identical(other.cursor, cursor) || other.cursor == cursor) &&
            (identical(other.nextCursor, nextCursor) ||
                other.nextCursor == nextCursor) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.totalAvailable, totalAvailable) ||
                other.totalAvailable == totalAvailable));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    cursor,
    nextCursor,
    limit,
    hasMore,
    totalAvailable,
  );

  /// Create a copy of PaginationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginationModelImplCopyWith<_$PaginationModelImpl> get copyWith =>
      __$$PaginationModelImplCopyWithImpl<_$PaginationModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PaginationModelImplToJson(this);
  }
}

abstract class _PaginationModel implements PaginationModel {
  const factory _PaginationModel({
    required final int cursor,
    final int? nextCursor,
    required final int limit,
    required final bool hasMore,
    required final int totalAvailable,
  }) = _$PaginationModelImpl;

  factory _PaginationModel.fromJson(Map<String, dynamic> json) =
      _$PaginationModelImpl.fromJson;

  @override
  int get cursor;
  @override
  int? get nextCursor;
  @override
  int get limit;
  @override
  bool get hasMore;
  @override
  int get totalAvailable;

  /// Create a copy of PaginationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaginationModelImplCopyWith<_$PaginationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LastDocModel _$LastDocModelFromJson(Map<String, dynamic> json) {
  return _LastDocModel.fromJson(json);
}

/// @nodoc
mixin _$LastDocModel {
  String get id => throw _privateConstructorUsedError;
  String get lastDocId => throw _privateConstructorUsedError;
  String get lastDocData => throw _privateConstructorUsedError;

  /// Serializes this LastDocModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LastDocModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LastDocModelCopyWith<LastDocModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LastDocModelCopyWith<$Res> {
  factory $LastDocModelCopyWith(
    LastDocModel value,
    $Res Function(LastDocModel) then,
  ) = _$LastDocModelCopyWithImpl<$Res, LastDocModel>;
  @useResult
  $Res call({String id, String lastDocId, String lastDocData});
}

/// @nodoc
class _$LastDocModelCopyWithImpl<$Res, $Val extends LastDocModel>
    implements $LastDocModelCopyWith<$Res> {
  _$LastDocModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LastDocModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? lastDocId = null,
    Object? lastDocData = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            lastDocId: null == lastDocId
                ? _value.lastDocId
                : lastDocId // ignore: cast_nullable_to_non_nullable
                      as String,
            lastDocData: null == lastDocData
                ? _value.lastDocData
                : lastDocData // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LastDocModelImplCopyWith<$Res>
    implements $LastDocModelCopyWith<$Res> {
  factory _$$LastDocModelImplCopyWith(
    _$LastDocModelImpl value,
    $Res Function(_$LastDocModelImpl) then,
  ) = __$$LastDocModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String lastDocId, String lastDocData});
}

/// @nodoc
class __$$LastDocModelImplCopyWithImpl<$Res>
    extends _$LastDocModelCopyWithImpl<$Res, _$LastDocModelImpl>
    implements _$$LastDocModelImplCopyWith<$Res> {
  __$$LastDocModelImplCopyWithImpl(
    _$LastDocModelImpl _value,
    $Res Function(_$LastDocModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LastDocModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? lastDocId = null,
    Object? lastDocData = null,
  }) {
    return _then(
      _$LastDocModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        lastDocId: null == lastDocId
            ? _value.lastDocId
            : lastDocId // ignore: cast_nullable_to_non_nullable
                  as String,
        lastDocData: null == lastDocData
            ? _value.lastDocData
            : lastDocData // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LastDocModelImpl implements _LastDocModel {
  const _$LastDocModelImpl({
    required this.id,
    required this.lastDocId,
    required this.lastDocData,
  });

  factory _$LastDocModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LastDocModelImplFromJson(json);

  @override
  final String id;
  @override
  final String lastDocId;
  @override
  final String lastDocData;

  @override
  String toString() {
    return 'LastDocModel(id: $id, lastDocId: $lastDocId, lastDocData: $lastDocData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LastDocModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.lastDocId, lastDocId) ||
                other.lastDocId == lastDocId) &&
            (identical(other.lastDocData, lastDocData) ||
                other.lastDocData == lastDocData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, lastDocId, lastDocData);

  /// Create a copy of LastDocModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LastDocModelImplCopyWith<_$LastDocModelImpl> get copyWith =>
      __$$LastDocModelImplCopyWithImpl<_$LastDocModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LastDocModelImplToJson(this);
  }
}

abstract class _LastDocModel implements LastDocModel {
  const factory _LastDocModel({
    required final String id,
    required final String lastDocId,
    required final String lastDocData,
  }) = _$LastDocModelImpl;

  factory _LastDocModel.fromJson(Map<String, dynamic> json) =
      _$LastDocModelImpl.fromJson;

  @override
  String get id;
  @override
  String get lastDocId;
  @override
  String get lastDocData;

  /// Create a copy of LastDocModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LastDocModelImplCopyWith<_$LastDocModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EpreuvesResponseModel _$EpreuvesResponseModelFromJson(
  Map<String, dynamic> json,
) {
  return _EpreuvesResponseModel.fromJson(json);
}

/// @nodoc
mixin _$EpreuvesResponseModel {
  bool get success => throw _privateConstructorUsedError;
  List<EpreuveGroupModel> get items => throw _privateConstructorUsedError;
  PaginationModel get pagination => throw _privateConstructorUsedError;
  LastDocModel? get lastDoc =>
      throw _privateConstructorUsedError; // Optionnel car peut être null du backend
  Map<String, dynamic>? get nextPageParams =>
      throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;

  /// Serializes this EpreuvesResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EpreuvesResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EpreuvesResponseModelCopyWith<EpreuvesResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EpreuvesResponseModelCopyWith<$Res> {
  factory $EpreuvesResponseModelCopyWith(
    EpreuvesResponseModel value,
    $Res Function(EpreuvesResponseModel) then,
  ) = _$EpreuvesResponseModelCopyWithImpl<$Res, EpreuvesResponseModel>;
  @useResult
  $Res call({
    bool success,
    List<EpreuveGroupModel> items,
    PaginationModel pagination,
    LastDocModel? lastDoc,
    Map<String, dynamic>? nextPageParams,
    String source,
  });

  $PaginationModelCopyWith<$Res> get pagination;
  $LastDocModelCopyWith<$Res>? get lastDoc;
}

/// @nodoc
class _$EpreuvesResponseModelCopyWithImpl<
  $Res,
  $Val extends EpreuvesResponseModel
>
    implements $EpreuvesResponseModelCopyWith<$Res> {
  _$EpreuvesResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EpreuvesResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? items = null,
    Object? pagination = null,
    Object? lastDoc = freezed,
    Object? nextPageParams = freezed,
    Object? source = null,
  }) {
    return _then(
      _value.copyWith(
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<EpreuveGroupModel>,
            pagination: null == pagination
                ? _value.pagination
                : pagination // ignore: cast_nullable_to_non_nullable
                      as PaginationModel,
            lastDoc: freezed == lastDoc
                ? _value.lastDoc
                : lastDoc // ignore: cast_nullable_to_non_nullable
                      as LastDocModel?,
            nextPageParams: freezed == nextPageParams
                ? _value.nextPageParams
                : nextPageParams // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            source: null == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }

  /// Create a copy of EpreuvesResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaginationModelCopyWith<$Res> get pagination {
    return $PaginationModelCopyWith<$Res>(_value.pagination, (value) {
      return _then(_value.copyWith(pagination: value) as $Val);
    });
  }

  /// Create a copy of EpreuvesResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LastDocModelCopyWith<$Res>? get lastDoc {
    if (_value.lastDoc == null) {
      return null;
    }

    return $LastDocModelCopyWith<$Res>(_value.lastDoc!, (value) {
      return _then(_value.copyWith(lastDoc: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EpreuvesResponseModelImplCopyWith<$Res>
    implements $EpreuvesResponseModelCopyWith<$Res> {
  factory _$$EpreuvesResponseModelImplCopyWith(
    _$EpreuvesResponseModelImpl value,
    $Res Function(_$EpreuvesResponseModelImpl) then,
  ) = __$$EpreuvesResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool success,
    List<EpreuveGroupModel> items,
    PaginationModel pagination,
    LastDocModel? lastDoc,
    Map<String, dynamic>? nextPageParams,
    String source,
  });

  @override
  $PaginationModelCopyWith<$Res> get pagination;
  @override
  $LastDocModelCopyWith<$Res>? get lastDoc;
}

/// @nodoc
class __$$EpreuvesResponseModelImplCopyWithImpl<$Res>
    extends
        _$EpreuvesResponseModelCopyWithImpl<$Res, _$EpreuvesResponseModelImpl>
    implements _$$EpreuvesResponseModelImplCopyWith<$Res> {
  __$$EpreuvesResponseModelImplCopyWithImpl(
    _$EpreuvesResponseModelImpl _value,
    $Res Function(_$EpreuvesResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EpreuvesResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? items = null,
    Object? pagination = null,
    Object? lastDoc = freezed,
    Object? nextPageParams = freezed,
    Object? source = null,
  }) {
    return _then(
      _$EpreuvesResponseModelImpl(
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<EpreuveGroupModel>,
        pagination: null == pagination
            ? _value.pagination
            : pagination // ignore: cast_nullable_to_non_nullable
                  as PaginationModel,
        lastDoc: freezed == lastDoc
            ? _value.lastDoc
            : lastDoc // ignore: cast_nullable_to_non_nullable
                  as LastDocModel?,
        nextPageParams: freezed == nextPageParams
            ? _value._nextPageParams
            : nextPageParams // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        source: null == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EpreuvesResponseModelImpl implements _EpreuvesResponseModel {
  const _$EpreuvesResponseModelImpl({
    required this.success,
    required final List<EpreuveGroupModel> items,
    required this.pagination,
    this.lastDoc,
    final Map<String, dynamic>? nextPageParams,
    required this.source,
  }) : _items = items,
       _nextPageParams = nextPageParams;

  factory _$EpreuvesResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EpreuvesResponseModelImplFromJson(json);

  @override
  final bool success;
  final List<EpreuveGroupModel> _items;
  @override
  List<EpreuveGroupModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final PaginationModel pagination;
  @override
  final LastDocModel? lastDoc;
  // Optionnel car peut être null du backend
  final Map<String, dynamic>? _nextPageParams;
  // Optionnel car peut être null du backend
  @override
  Map<String, dynamic>? get nextPageParams {
    final value = _nextPageParams;
    if (value == null) return null;
    if (_nextPageParams is EqualUnmodifiableMapView) return _nextPageParams;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final String source;

  @override
  String toString() {
    return 'EpreuvesResponseModel(success: $success, items: $items, pagination: $pagination, lastDoc: $lastDoc, nextPageParams: $nextPageParams, source: $source)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EpreuvesResponseModelImpl &&
            (identical(other.success, success) || other.success == success) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.pagination, pagination) ||
                other.pagination == pagination) &&
            (identical(other.lastDoc, lastDoc) || other.lastDoc == lastDoc) &&
            const DeepCollectionEquality().equals(
              other._nextPageParams,
              _nextPageParams,
            ) &&
            (identical(other.source, source) || other.source == source));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    success,
    const DeepCollectionEquality().hash(_items),
    pagination,
    lastDoc,
    const DeepCollectionEquality().hash(_nextPageParams),
    source,
  );

  /// Create a copy of EpreuvesResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EpreuvesResponseModelImplCopyWith<_$EpreuvesResponseModelImpl>
  get copyWith =>
      __$$EpreuvesResponseModelImplCopyWithImpl<_$EpreuvesResponseModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$EpreuvesResponseModelImplToJson(this);
  }
}

abstract class _EpreuvesResponseModel implements EpreuvesResponseModel {
  const factory _EpreuvesResponseModel({
    required final bool success,
    required final List<EpreuveGroupModel> items,
    required final PaginationModel pagination,
    final LastDocModel? lastDoc,
    final Map<String, dynamic>? nextPageParams,
    required final String source,
  }) = _$EpreuvesResponseModelImpl;

  factory _EpreuvesResponseModel.fromJson(Map<String, dynamic> json) =
      _$EpreuvesResponseModelImpl.fromJson;

  @override
  bool get success;
  @override
  List<EpreuveGroupModel> get items;
  @override
  PaginationModel get pagination;
  @override
  LastDocModel? get lastDoc; // Optionnel car peut être null du backend
  @override
  Map<String, dynamic>? get nextPageParams;
  @override
  String get source;

  /// Create a copy of EpreuvesResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EpreuvesResponseModelImplCopyWith<_$EpreuvesResponseModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
