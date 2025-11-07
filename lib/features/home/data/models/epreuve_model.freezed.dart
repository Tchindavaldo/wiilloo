// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'epreuve_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

EpreuveModel _$EpreuveModelFromJson(Map<String, dynamic> json) {
  return _EpreuveModel.fromJson(json);
}

/// @nodoc
mixin _$EpreuveModel {
  String get id => throw _privateConstructorUsedError;
  String get titre => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String get matiere => throw _privateConstructorUsedError;
  String get niveau => throw _privateConstructorUsedError;
  String get categorie => throw _privateConstructorUsedError;
  int get duree => throw _privateConstructorUsedError;
  String? get bareme => throw _privateConstructorUsedError;
  String get schoolName => throw _privateConstructorUsedError;
  int get annee => throw _privateConstructorUsedError;
  int get downloadCount => throw _privateConstructorUsedError;
  List<FichierModel> get fichiers => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  List<CorrectionModel> get corrections => throw _privateConstructorUsedError;
  int get correctionsCount => throw _privateConstructorUsedError;
  bool get hasCorrection => throw _privateConstructorUsedError;
  TimestampModel get createdAt => throw _privateConstructorUsedError;
  TimestampModel get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this EpreuveModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EpreuveModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EpreuveModelCopyWith<EpreuveModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EpreuveModelCopyWith<$Res> {
  factory $EpreuveModelCopyWith(
    EpreuveModel value,
    $Res Function(EpreuveModel) then,
  ) = _$EpreuveModelCopyWithImpl<$Res, EpreuveModel>;
  @useResult
  $Res call({
    String id,
    String titre,
    String? description,
    String matiere,
    String niveau,
    String categorie,
    int duree,
    String? bareme,
    String schoolName,
    int annee,
    int downloadCount,
    List<FichierModel> fichiers,
    String createdBy,
    String status,
    List<CorrectionModel> corrections,
    int correctionsCount,
    bool hasCorrection,
    TimestampModel createdAt,
    TimestampModel updatedAt,
  });

  $TimestampModelCopyWith<$Res> get createdAt;
  $TimestampModelCopyWith<$Res> get updatedAt;
}

/// @nodoc
class _$EpreuveModelCopyWithImpl<$Res, $Val extends EpreuveModel>
    implements $EpreuveModelCopyWith<$Res> {
  _$EpreuveModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EpreuveModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? titre = null,
    Object? description = freezed,
    Object? matiere = null,
    Object? niveau = null,
    Object? categorie = null,
    Object? duree = null,
    Object? bareme = freezed,
    Object? schoolName = null,
    Object? annee = null,
    Object? downloadCount = null,
    Object? fichiers = null,
    Object? createdBy = null,
    Object? status = null,
    Object? corrections = null,
    Object? correctionsCount = null,
    Object? hasCorrection = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            titre: null == titre
                ? _value.titre
                : titre // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            matiere: null == matiere
                ? _value.matiere
                : matiere // ignore: cast_nullable_to_non_nullable
                      as String,
            niveau: null == niveau
                ? _value.niveau
                : niveau // ignore: cast_nullable_to_non_nullable
                      as String,
            categorie: null == categorie
                ? _value.categorie
                : categorie // ignore: cast_nullable_to_non_nullable
                      as String,
            duree: null == duree
                ? _value.duree
                : duree // ignore: cast_nullable_to_non_nullable
                      as int,
            bareme: freezed == bareme
                ? _value.bareme
                : bareme // ignore: cast_nullable_to_non_nullable
                      as String?,
            schoolName: null == schoolName
                ? _value.schoolName
                : schoolName // ignore: cast_nullable_to_non_nullable
                      as String,
            annee: null == annee
                ? _value.annee
                : annee // ignore: cast_nullable_to_non_nullable
                      as int,
            downloadCount: null == downloadCount
                ? _value.downloadCount
                : downloadCount // ignore: cast_nullable_to_non_nullable
                      as int,
            fichiers: null == fichiers
                ? _value.fichiers
                : fichiers // ignore: cast_nullable_to_non_nullable
                      as List<FichierModel>,
            createdBy: null == createdBy
                ? _value.createdBy
                : createdBy // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            corrections: null == corrections
                ? _value.corrections
                : corrections // ignore: cast_nullable_to_non_nullable
                      as List<CorrectionModel>,
            correctionsCount: null == correctionsCount
                ? _value.correctionsCount
                : correctionsCount // ignore: cast_nullable_to_non_nullable
                      as int,
            hasCorrection: null == hasCorrection
                ? _value.hasCorrection
                : hasCorrection // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as TimestampModel,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as TimestampModel,
          )
          as $Val,
    );
  }

  /// Create a copy of EpreuveModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TimestampModelCopyWith<$Res> get createdAt {
    return $TimestampModelCopyWith<$Res>(_value.createdAt, (value) {
      return _then(_value.copyWith(createdAt: value) as $Val);
    });
  }

  /// Create a copy of EpreuveModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TimestampModelCopyWith<$Res> get updatedAt {
    return $TimestampModelCopyWith<$Res>(_value.updatedAt, (value) {
      return _then(_value.copyWith(updatedAt: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EpreuveModelImplCopyWith<$Res>
    implements $EpreuveModelCopyWith<$Res> {
  factory _$$EpreuveModelImplCopyWith(
    _$EpreuveModelImpl value,
    $Res Function(_$EpreuveModelImpl) then,
  ) = __$$EpreuveModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String titre,
    String? description,
    String matiere,
    String niveau,
    String categorie,
    int duree,
    String? bareme,
    String schoolName,
    int annee,
    int downloadCount,
    List<FichierModel> fichiers,
    String createdBy,
    String status,
    List<CorrectionModel> corrections,
    int correctionsCount,
    bool hasCorrection,
    TimestampModel createdAt,
    TimestampModel updatedAt,
  });

  @override
  $TimestampModelCopyWith<$Res> get createdAt;
  @override
  $TimestampModelCopyWith<$Res> get updatedAt;
}

/// @nodoc
class __$$EpreuveModelImplCopyWithImpl<$Res>
    extends _$EpreuveModelCopyWithImpl<$Res, _$EpreuveModelImpl>
    implements _$$EpreuveModelImplCopyWith<$Res> {
  __$$EpreuveModelImplCopyWithImpl(
    _$EpreuveModelImpl _value,
    $Res Function(_$EpreuveModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EpreuveModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? titre = null,
    Object? description = freezed,
    Object? matiere = null,
    Object? niveau = null,
    Object? categorie = null,
    Object? duree = null,
    Object? bareme = freezed,
    Object? schoolName = null,
    Object? annee = null,
    Object? downloadCount = null,
    Object? fichiers = null,
    Object? createdBy = null,
    Object? status = null,
    Object? corrections = null,
    Object? correctionsCount = null,
    Object? hasCorrection = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$EpreuveModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        titre: null == titre
            ? _value.titre
            : titre // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        matiere: null == matiere
            ? _value.matiere
            : matiere // ignore: cast_nullable_to_non_nullable
                  as String,
        niveau: null == niveau
            ? _value.niveau
            : niveau // ignore: cast_nullable_to_non_nullable
                  as String,
        categorie: null == categorie
            ? _value.categorie
            : categorie // ignore: cast_nullable_to_non_nullable
                  as String,
        duree: null == duree
            ? _value.duree
            : duree // ignore: cast_nullable_to_non_nullable
                  as int,
        bareme: freezed == bareme
            ? _value.bareme
            : bareme // ignore: cast_nullable_to_non_nullable
                  as String?,
        schoolName: null == schoolName
            ? _value.schoolName
            : schoolName // ignore: cast_nullable_to_non_nullable
                  as String,
        annee: null == annee
            ? _value.annee
            : annee // ignore: cast_nullable_to_non_nullable
                  as int,
        downloadCount: null == downloadCount
            ? _value.downloadCount
            : downloadCount // ignore: cast_nullable_to_non_nullable
                  as int,
        fichiers: null == fichiers
            ? _value._fichiers
            : fichiers // ignore: cast_nullable_to_non_nullable
                  as List<FichierModel>,
        createdBy: null == createdBy
            ? _value.createdBy
            : createdBy // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        corrections: null == corrections
            ? _value._corrections
            : corrections // ignore: cast_nullable_to_non_nullable
                  as List<CorrectionModel>,
        correctionsCount: null == correctionsCount
            ? _value.correctionsCount
            : correctionsCount // ignore: cast_nullable_to_non_nullable
                  as int,
        hasCorrection: null == hasCorrection
            ? _value.hasCorrection
            : hasCorrection // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as TimestampModel,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as TimestampModel,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EpreuveModelImpl implements _EpreuveModel {
  const _$EpreuveModelImpl({
    required this.id,
    required this.titre,
    this.description,
    required this.matiere,
    required this.niveau,
    required this.categorie,
    this.duree = 0,
    this.bareme,
    required this.schoolName,
    required this.annee,
    this.downloadCount = 0,
    final List<FichierModel> fichiers = const [],
    required this.createdBy,
    required this.status,
    final List<CorrectionModel> corrections = const [],
    this.correctionsCount = 0,
    this.hasCorrection = false,
    required this.createdAt,
    required this.updatedAt,
  }) : _fichiers = fichiers,
       _corrections = corrections;

  factory _$EpreuveModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EpreuveModelImplFromJson(json);

  @override
  final String id;
  @override
  final String titre;
  @override
  final String? description;
  @override
  final String matiere;
  @override
  final String niveau;
  @override
  final String categorie;
  @override
  @JsonKey()
  final int duree;
  @override
  final String? bareme;
  @override
  final String schoolName;
  @override
  final int annee;
  @override
  @JsonKey()
  final int downloadCount;
  final List<FichierModel> _fichiers;
  @override
  @JsonKey()
  List<FichierModel> get fichiers {
    if (_fichiers is EqualUnmodifiableListView) return _fichiers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fichiers);
  }

  @override
  final String createdBy;
  @override
  final String status;
  final List<CorrectionModel> _corrections;
  @override
  @JsonKey()
  List<CorrectionModel> get corrections {
    if (_corrections is EqualUnmodifiableListView) return _corrections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_corrections);
  }

  @override
  @JsonKey()
  final int correctionsCount;
  @override
  @JsonKey()
  final bool hasCorrection;
  @override
  final TimestampModel createdAt;
  @override
  final TimestampModel updatedAt;

  @override
  String toString() {
    return 'EpreuveModel(id: $id, titre: $titre, description: $description, matiere: $matiere, niveau: $niveau, categorie: $categorie, duree: $duree, bareme: $bareme, schoolName: $schoolName, annee: $annee, downloadCount: $downloadCount, fichiers: $fichiers, createdBy: $createdBy, status: $status, corrections: $corrections, correctionsCount: $correctionsCount, hasCorrection: $hasCorrection, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EpreuveModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.titre, titre) || other.titre == titre) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.matiere, matiere) || other.matiere == matiere) &&
            (identical(other.niveau, niveau) || other.niveau == niveau) &&
            (identical(other.categorie, categorie) ||
                other.categorie == categorie) &&
            (identical(other.duree, duree) || other.duree == duree) &&
            (identical(other.bareme, bareme) || other.bareme == bareme) &&
            (identical(other.schoolName, schoolName) ||
                other.schoolName == schoolName) &&
            (identical(other.annee, annee) || other.annee == annee) &&
            (identical(other.downloadCount, downloadCount) ||
                other.downloadCount == downloadCount) &&
            const DeepCollectionEquality().equals(other._fichiers, _fichiers) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(
              other._corrections,
              _corrections,
            ) &&
            (identical(other.correctionsCount, correctionsCount) ||
                other.correctionsCount == correctionsCount) &&
            (identical(other.hasCorrection, hasCorrection) ||
                other.hasCorrection == hasCorrection) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    titre,
    description,
    matiere,
    niveau,
    categorie,
    duree,
    bareme,
    schoolName,
    annee,
    downloadCount,
    const DeepCollectionEquality().hash(_fichiers),
    createdBy,
    status,
    const DeepCollectionEquality().hash(_corrections),
    correctionsCount,
    hasCorrection,
    createdAt,
    updatedAt,
  ]);

  /// Create a copy of EpreuveModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EpreuveModelImplCopyWith<_$EpreuveModelImpl> get copyWith =>
      __$$EpreuveModelImplCopyWithImpl<_$EpreuveModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EpreuveModelImplToJson(this);
  }
}

abstract class _EpreuveModel implements EpreuveModel {
  const factory _EpreuveModel({
    required final String id,
    required final String titre,
    final String? description,
    required final String matiere,
    required final String niveau,
    required final String categorie,
    final int duree,
    final String? bareme,
    required final String schoolName,
    required final int annee,
    final int downloadCount,
    final List<FichierModel> fichiers,
    required final String createdBy,
    required final String status,
    final List<CorrectionModel> corrections,
    final int correctionsCount,
    final bool hasCorrection,
    required final TimestampModel createdAt,
    required final TimestampModel updatedAt,
  }) = _$EpreuveModelImpl;

  factory _EpreuveModel.fromJson(Map<String, dynamic> json) =
      _$EpreuveModelImpl.fromJson;

  @override
  String get id;
  @override
  String get titre;
  @override
  String? get description;
  @override
  String get matiere;
  @override
  String get niveau;
  @override
  String get categorie;
  @override
  int get duree;
  @override
  String? get bareme;
  @override
  String get schoolName;
  @override
  int get annee;
  @override
  int get downloadCount;
  @override
  List<FichierModel> get fichiers;
  @override
  String get createdBy;
  @override
  String get status;
  @override
  List<CorrectionModel> get corrections;
  @override
  int get correctionsCount;
  @override
  bool get hasCorrection;
  @override
  TimestampModel get createdAt;
  @override
  TimestampModel get updatedAt;

  /// Create a copy of EpreuveModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EpreuveModelImplCopyWith<_$EpreuveModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FichierModel _$FichierModelFromJson(Map<String, dynamic> json) {
  return _FichierModel.fromJson(json);
}

/// @nodoc
mixin _$FichierModel {
  String? get nom => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  int get taille => throw _privateConstructorUsedError;
  String? get uploadedAt => throw _privateConstructorUsedError;

  /// Serializes this FichierModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FichierModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FichierModelCopyWith<FichierModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FichierModelCopyWith<$Res> {
  factory $FichierModelCopyWith(
    FichierModel value,
    $Res Function(FichierModel) then,
  ) = _$FichierModelCopyWithImpl<$Res, FichierModel>;
  @useResult
  $Res call({
    String? nom,
    String? url,
    String? type,
    int taille,
    String? uploadedAt,
  });
}

/// @nodoc
class _$FichierModelCopyWithImpl<$Res, $Val extends FichierModel>
    implements $FichierModelCopyWith<$Res> {
  _$FichierModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FichierModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nom = freezed,
    Object? url = freezed,
    Object? type = freezed,
    Object? taille = null,
    Object? uploadedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            nom: freezed == nom
                ? _value.nom
                : nom // ignore: cast_nullable_to_non_nullable
                      as String?,
            url: freezed == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String?,
            type: freezed == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String?,
            taille: null == taille
                ? _value.taille
                : taille // ignore: cast_nullable_to_non_nullable
                      as int,
            uploadedAt: freezed == uploadedAt
                ? _value.uploadedAt
                : uploadedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FichierModelImplCopyWith<$Res>
    implements $FichierModelCopyWith<$Res> {
  factory _$$FichierModelImplCopyWith(
    _$FichierModelImpl value,
    $Res Function(_$FichierModelImpl) then,
  ) = __$$FichierModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? nom,
    String? url,
    String? type,
    int taille,
    String? uploadedAt,
  });
}

/// @nodoc
class __$$FichierModelImplCopyWithImpl<$Res>
    extends _$FichierModelCopyWithImpl<$Res, _$FichierModelImpl>
    implements _$$FichierModelImplCopyWith<$Res> {
  __$$FichierModelImplCopyWithImpl(
    _$FichierModelImpl _value,
    $Res Function(_$FichierModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FichierModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nom = freezed,
    Object? url = freezed,
    Object? type = freezed,
    Object? taille = null,
    Object? uploadedAt = freezed,
  }) {
    return _then(
      _$FichierModelImpl(
        nom: freezed == nom
            ? _value.nom
            : nom // ignore: cast_nullable_to_non_nullable
                  as String?,
        url: freezed == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String?,
        type: freezed == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String?,
        taille: null == taille
            ? _value.taille
            : taille // ignore: cast_nullable_to_non_nullable
                  as int,
        uploadedAt: freezed == uploadedAt
            ? _value.uploadedAt
            : uploadedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FichierModelImpl implements _FichierModel {
  const _$FichierModelImpl({
    this.nom,
    this.url,
    this.type,
    this.taille = 0,
    this.uploadedAt,
  });

  factory _$FichierModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FichierModelImplFromJson(json);

  @override
  final String? nom;
  @override
  final String? url;
  @override
  final String? type;
  @override
  @JsonKey()
  final int taille;
  @override
  final String? uploadedAt;

  @override
  String toString() {
    return 'FichierModel(nom: $nom, url: $url, type: $type, taille: $taille, uploadedAt: $uploadedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FichierModelImpl &&
            (identical(other.nom, nom) || other.nom == nom) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.taille, taille) || other.taille == taille) &&
            (identical(other.uploadedAt, uploadedAt) ||
                other.uploadedAt == uploadedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, nom, url, type, taille, uploadedAt);

  /// Create a copy of FichierModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FichierModelImplCopyWith<_$FichierModelImpl> get copyWith =>
      __$$FichierModelImplCopyWithImpl<_$FichierModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FichierModelImplToJson(this);
  }
}

abstract class _FichierModel implements FichierModel {
  const factory _FichierModel({
    final String? nom,
    final String? url,
    final String? type,
    final int taille,
    final String? uploadedAt,
  }) = _$FichierModelImpl;

  factory _FichierModel.fromJson(Map<String, dynamic> json) =
      _$FichierModelImpl.fromJson;

  @override
  String? get nom;
  @override
  String? get url;
  @override
  String? get type;
  @override
  int get taille;
  @override
  String? get uploadedAt;

  /// Create a copy of FichierModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FichierModelImplCopyWith<_$FichierModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CorrectionModel _$CorrectionModelFromJson(Map<String, dynamic> json) {
  return _CorrectionModel.fromJson(json);
}

/// @nodoc
mixin _$CorrectionModel {
  String? get id => throw _privateConstructorUsedError;
  String? get titre => throw _privateConstructorUsedError;
  String? get qualityLevel => throw _privateConstructorUsedError;
  CorrecteurModel? get correcteur => throw _privateConstructorUsedError;
  String? get commentaire => throw _privateConstructorUsedError;
  String? get fileUrl => throw _privateConstructorUsedError;
  String? get fileName => throw _privateConstructorUsedError;
  String? get fileType => throw _privateConstructorUsedError;
  String? get fileSize => throw _privateConstructorUsedError;
  String? get driveFileId => throw _privateConstructorUsedError;

  /// Serializes this CorrectionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CorrectionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CorrectionModelCopyWith<CorrectionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CorrectionModelCopyWith<$Res> {
  factory $CorrectionModelCopyWith(
    CorrectionModel value,
    $Res Function(CorrectionModel) then,
  ) = _$CorrectionModelCopyWithImpl<$Res, CorrectionModel>;
  @useResult
  $Res call({
    String? id,
    String? titre,
    String? qualityLevel,
    CorrecteurModel? correcteur,
    String? commentaire,
    String? fileUrl,
    String? fileName,
    String? fileType,
    String? fileSize,
    String? driveFileId,
  });

  $CorrecteurModelCopyWith<$Res>? get correcteur;
}

/// @nodoc
class _$CorrectionModelCopyWithImpl<$Res, $Val extends CorrectionModel>
    implements $CorrectionModelCopyWith<$Res> {
  _$CorrectionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CorrectionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? titre = freezed,
    Object? qualityLevel = freezed,
    Object? correcteur = freezed,
    Object? commentaire = freezed,
    Object? fileUrl = freezed,
    Object? fileName = freezed,
    Object? fileType = freezed,
    Object? fileSize = freezed,
    Object? driveFileId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            titre: freezed == titre
                ? _value.titre
                : titre // ignore: cast_nullable_to_non_nullable
                      as String?,
            qualityLevel: freezed == qualityLevel
                ? _value.qualityLevel
                : qualityLevel // ignore: cast_nullable_to_non_nullable
                      as String?,
            correcteur: freezed == correcteur
                ? _value.correcteur
                : correcteur // ignore: cast_nullable_to_non_nullable
                      as CorrecteurModel?,
            commentaire: freezed == commentaire
                ? _value.commentaire
                : commentaire // ignore: cast_nullable_to_non_nullable
                      as String?,
            fileUrl: freezed == fileUrl
                ? _value.fileUrl
                : fileUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            fileName: freezed == fileName
                ? _value.fileName
                : fileName // ignore: cast_nullable_to_non_nullable
                      as String?,
            fileType: freezed == fileType
                ? _value.fileType
                : fileType // ignore: cast_nullable_to_non_nullable
                      as String?,
            fileSize: freezed == fileSize
                ? _value.fileSize
                : fileSize // ignore: cast_nullable_to_non_nullable
                      as String?,
            driveFileId: freezed == driveFileId
                ? _value.driveFileId
                : driveFileId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of CorrectionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CorrecteurModelCopyWith<$Res>? get correcteur {
    if (_value.correcteur == null) {
      return null;
    }

    return $CorrecteurModelCopyWith<$Res>(_value.correcteur!, (value) {
      return _then(_value.copyWith(correcteur: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CorrectionModelImplCopyWith<$Res>
    implements $CorrectionModelCopyWith<$Res> {
  factory _$$CorrectionModelImplCopyWith(
    _$CorrectionModelImpl value,
    $Res Function(_$CorrectionModelImpl) then,
  ) = __$$CorrectionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    String? titre,
    String? qualityLevel,
    CorrecteurModel? correcteur,
    String? commentaire,
    String? fileUrl,
    String? fileName,
    String? fileType,
    String? fileSize,
    String? driveFileId,
  });

  @override
  $CorrecteurModelCopyWith<$Res>? get correcteur;
}

/// @nodoc
class __$$CorrectionModelImplCopyWithImpl<$Res>
    extends _$CorrectionModelCopyWithImpl<$Res, _$CorrectionModelImpl>
    implements _$$CorrectionModelImplCopyWith<$Res> {
  __$$CorrectionModelImplCopyWithImpl(
    _$CorrectionModelImpl _value,
    $Res Function(_$CorrectionModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CorrectionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? titre = freezed,
    Object? qualityLevel = freezed,
    Object? correcteur = freezed,
    Object? commentaire = freezed,
    Object? fileUrl = freezed,
    Object? fileName = freezed,
    Object? fileType = freezed,
    Object? fileSize = freezed,
    Object? driveFileId = freezed,
  }) {
    return _then(
      _$CorrectionModelImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        titre: freezed == titre
            ? _value.titre
            : titre // ignore: cast_nullable_to_non_nullable
                  as String?,
        qualityLevel: freezed == qualityLevel
            ? _value.qualityLevel
            : qualityLevel // ignore: cast_nullable_to_non_nullable
                  as String?,
        correcteur: freezed == correcteur
            ? _value.correcteur
            : correcteur // ignore: cast_nullable_to_non_nullable
                  as CorrecteurModel?,
        commentaire: freezed == commentaire
            ? _value.commentaire
            : commentaire // ignore: cast_nullable_to_non_nullable
                  as String?,
        fileUrl: freezed == fileUrl
            ? _value.fileUrl
            : fileUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        fileName: freezed == fileName
            ? _value.fileName
            : fileName // ignore: cast_nullable_to_non_nullable
                  as String?,
        fileType: freezed == fileType
            ? _value.fileType
            : fileType // ignore: cast_nullable_to_non_nullable
                  as String?,
        fileSize: freezed == fileSize
            ? _value.fileSize
            : fileSize // ignore: cast_nullable_to_non_nullable
                  as String?,
        driveFileId: freezed == driveFileId
            ? _value.driveFileId
            : driveFileId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CorrectionModelImpl implements _CorrectionModel {
  const _$CorrectionModelImpl({
    this.id,
    this.titre,
    this.qualityLevel,
    this.correcteur,
    this.commentaire,
    this.fileUrl,
    this.fileName,
    this.fileType,
    this.fileSize,
    this.driveFileId,
  });

  factory _$CorrectionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CorrectionModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String? titre;
  @override
  final String? qualityLevel;
  @override
  final CorrecteurModel? correcteur;
  @override
  final String? commentaire;
  @override
  final String? fileUrl;
  @override
  final String? fileName;
  @override
  final String? fileType;
  @override
  final String? fileSize;
  @override
  final String? driveFileId;

  @override
  String toString() {
    return 'CorrectionModel(id: $id, titre: $titre, qualityLevel: $qualityLevel, correcteur: $correcteur, commentaire: $commentaire, fileUrl: $fileUrl, fileName: $fileName, fileType: $fileType, fileSize: $fileSize, driveFileId: $driveFileId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CorrectionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.titre, titre) || other.titre == titre) &&
            (identical(other.qualityLevel, qualityLevel) ||
                other.qualityLevel == qualityLevel) &&
            (identical(other.correcteur, correcteur) ||
                other.correcteur == correcteur) &&
            (identical(other.commentaire, commentaire) ||
                other.commentaire == commentaire) &&
            (identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName) &&
            (identical(other.fileType, fileType) ||
                other.fileType == fileType) &&
            (identical(other.fileSize, fileSize) ||
                other.fileSize == fileSize) &&
            (identical(other.driveFileId, driveFileId) ||
                other.driveFileId == driveFileId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    titre,
    qualityLevel,
    correcteur,
    commentaire,
    fileUrl,
    fileName,
    fileType,
    fileSize,
    driveFileId,
  );

  /// Create a copy of CorrectionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CorrectionModelImplCopyWith<_$CorrectionModelImpl> get copyWith =>
      __$$CorrectionModelImplCopyWithImpl<_$CorrectionModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CorrectionModelImplToJson(this);
  }
}

abstract class _CorrectionModel implements CorrectionModel {
  const factory _CorrectionModel({
    final String? id,
    final String? titre,
    final String? qualityLevel,
    final CorrecteurModel? correcteur,
    final String? commentaire,
    final String? fileUrl,
    final String? fileName,
    final String? fileType,
    final String? fileSize,
    final String? driveFileId,
  }) = _$CorrectionModelImpl;

  factory _CorrectionModel.fromJson(Map<String, dynamic> json) =
      _$CorrectionModelImpl.fromJson;

  @override
  String? get id;
  @override
  String? get titre;
  @override
  String? get qualityLevel;
  @override
  CorrecteurModel? get correcteur;
  @override
  String? get commentaire;
  @override
  String? get fileUrl;
  @override
  String? get fileName;
  @override
  String? get fileType;
  @override
  String? get fileSize;
  @override
  String? get driveFileId;

  /// Create a copy of CorrectionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CorrectionModelImplCopyWith<_$CorrectionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CorrecteurModel _$CorrecteurModelFromJson(Map<String, dynamic> json) {
  return _CorrecteurModel.fromJson(json);
}

/// @nodoc
mixin _$CorrecteurModel {
  String get nom => throw _privateConstructorUsedError;
  String get prenom => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get telephone => throw _privateConstructorUsedError;

  /// Serializes this CorrecteurModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CorrecteurModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CorrecteurModelCopyWith<CorrecteurModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CorrecteurModelCopyWith<$Res> {
  factory $CorrecteurModelCopyWith(
    CorrecteurModel value,
    $Res Function(CorrecteurModel) then,
  ) = _$CorrecteurModelCopyWithImpl<$Res, CorrecteurModel>;
  @useResult
  $Res call({String nom, String prenom, String email, String telephone});
}

/// @nodoc
class _$CorrecteurModelCopyWithImpl<$Res, $Val extends CorrecteurModel>
    implements $CorrecteurModelCopyWith<$Res> {
  _$CorrecteurModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CorrecteurModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nom = null,
    Object? prenom = null,
    Object? email = null,
    Object? telephone = null,
  }) {
    return _then(
      _value.copyWith(
            nom: null == nom
                ? _value.nom
                : nom // ignore: cast_nullable_to_non_nullable
                      as String,
            prenom: null == prenom
                ? _value.prenom
                : prenom // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            telephone: null == telephone
                ? _value.telephone
                : telephone // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CorrecteurModelImplCopyWith<$Res>
    implements $CorrecteurModelCopyWith<$Res> {
  factory _$$CorrecteurModelImplCopyWith(
    _$CorrecteurModelImpl value,
    $Res Function(_$CorrecteurModelImpl) then,
  ) = __$$CorrecteurModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String nom, String prenom, String email, String telephone});
}

/// @nodoc
class __$$CorrecteurModelImplCopyWithImpl<$Res>
    extends _$CorrecteurModelCopyWithImpl<$Res, _$CorrecteurModelImpl>
    implements _$$CorrecteurModelImplCopyWith<$Res> {
  __$$CorrecteurModelImplCopyWithImpl(
    _$CorrecteurModelImpl _value,
    $Res Function(_$CorrecteurModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CorrecteurModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nom = null,
    Object? prenom = null,
    Object? email = null,
    Object? telephone = null,
  }) {
    return _then(
      _$CorrecteurModelImpl(
        nom: null == nom
            ? _value.nom
            : nom // ignore: cast_nullable_to_non_nullable
                  as String,
        prenom: null == prenom
            ? _value.prenom
            : prenom // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        telephone: null == telephone
            ? _value.telephone
            : telephone // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CorrecteurModelImpl implements _CorrecteurModel {
  const _$CorrecteurModelImpl({
    required this.nom,
    required this.prenom,
    required this.email,
    required this.telephone,
  });

  factory _$CorrecteurModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CorrecteurModelImplFromJson(json);

  @override
  final String nom;
  @override
  final String prenom;
  @override
  final String email;
  @override
  final String telephone;

  @override
  String toString() {
    return 'CorrecteurModel(nom: $nom, prenom: $prenom, email: $email, telephone: $telephone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CorrecteurModelImpl &&
            (identical(other.nom, nom) || other.nom == nom) &&
            (identical(other.prenom, prenom) || other.prenom == prenom) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.telephone, telephone) ||
                other.telephone == telephone));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, nom, prenom, email, telephone);

  /// Create a copy of CorrecteurModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CorrecteurModelImplCopyWith<_$CorrecteurModelImpl> get copyWith =>
      __$$CorrecteurModelImplCopyWithImpl<_$CorrecteurModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CorrecteurModelImplToJson(this);
  }
}

abstract class _CorrecteurModel implements CorrecteurModel {
  const factory _CorrecteurModel({
    required final String nom,
    required final String prenom,
    required final String email,
    required final String telephone,
  }) = _$CorrecteurModelImpl;

  factory _CorrecteurModel.fromJson(Map<String, dynamic> json) =
      _$CorrecteurModelImpl.fromJson;

  @override
  String get nom;
  @override
  String get prenom;
  @override
  String get email;
  @override
  String get telephone;

  /// Create a copy of CorrecteurModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CorrecteurModelImplCopyWith<_$CorrecteurModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TimestampModel _$TimestampModelFromJson(Map<String, dynamic> json) {
  return _TimestampModel.fromJson(json);
}

/// @nodoc
mixin _$TimestampModel {
  @JsonKey(name: '_seconds')
  int get seconds => throw _privateConstructorUsedError;
  @JsonKey(name: '_nanoseconds')
  int get nanoseconds => throw _privateConstructorUsedError;

  /// Serializes this TimestampModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TimestampModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimestampModelCopyWith<TimestampModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimestampModelCopyWith<$Res> {
  factory $TimestampModelCopyWith(
    TimestampModel value,
    $Res Function(TimestampModel) then,
  ) = _$TimestampModelCopyWithImpl<$Res, TimestampModel>;
  @useResult
  $Res call({
    @JsonKey(name: '_seconds') int seconds,
    @JsonKey(name: '_nanoseconds') int nanoseconds,
  });
}

/// @nodoc
class _$TimestampModelCopyWithImpl<$Res, $Val extends TimestampModel>
    implements $TimestampModelCopyWith<$Res> {
  _$TimestampModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimestampModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? seconds = null, Object? nanoseconds = null}) {
    return _then(
      _value.copyWith(
            seconds: null == seconds
                ? _value.seconds
                : seconds // ignore: cast_nullable_to_non_nullable
                      as int,
            nanoseconds: null == nanoseconds
                ? _value.nanoseconds
                : nanoseconds // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TimestampModelImplCopyWith<$Res>
    implements $TimestampModelCopyWith<$Res> {
  factory _$$TimestampModelImplCopyWith(
    _$TimestampModelImpl value,
    $Res Function(_$TimestampModelImpl) then,
  ) = __$$TimestampModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: '_seconds') int seconds,
    @JsonKey(name: '_nanoseconds') int nanoseconds,
  });
}

/// @nodoc
class __$$TimestampModelImplCopyWithImpl<$Res>
    extends _$TimestampModelCopyWithImpl<$Res, _$TimestampModelImpl>
    implements _$$TimestampModelImplCopyWith<$Res> {
  __$$TimestampModelImplCopyWithImpl(
    _$TimestampModelImpl _value,
    $Res Function(_$TimestampModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TimestampModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? seconds = null, Object? nanoseconds = null}) {
    return _then(
      _$TimestampModelImpl(
        seconds: null == seconds
            ? _value.seconds
            : seconds // ignore: cast_nullable_to_non_nullable
                  as int,
        nanoseconds: null == nanoseconds
            ? _value.nanoseconds
            : nanoseconds // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TimestampModelImpl implements _TimestampModel {
  const _$TimestampModelImpl({
    @JsonKey(name: '_seconds') required this.seconds,
    @JsonKey(name: '_nanoseconds') required this.nanoseconds,
  });

  factory _$TimestampModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimestampModelImplFromJson(json);

  @override
  @JsonKey(name: '_seconds')
  final int seconds;
  @override
  @JsonKey(name: '_nanoseconds')
  final int nanoseconds;

  @override
  String toString() {
    return 'TimestampModel(seconds: $seconds, nanoseconds: $nanoseconds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimestampModelImpl &&
            (identical(other.seconds, seconds) || other.seconds == seconds) &&
            (identical(other.nanoseconds, nanoseconds) ||
                other.nanoseconds == nanoseconds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, seconds, nanoseconds);

  /// Create a copy of TimestampModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimestampModelImplCopyWith<_$TimestampModelImpl> get copyWith =>
      __$$TimestampModelImplCopyWithImpl<_$TimestampModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TimestampModelImplToJson(this);
  }
}

abstract class _TimestampModel implements TimestampModel {
  const factory _TimestampModel({
    @JsonKey(name: '_seconds') required final int seconds,
    @JsonKey(name: '_nanoseconds') required final int nanoseconds,
  }) = _$TimestampModelImpl;

  factory _TimestampModel.fromJson(Map<String, dynamic> json) =
      _$TimestampModelImpl.fromJson;

  @override
  @JsonKey(name: '_seconds')
  int get seconds;
  @override
  @JsonKey(name: '_nanoseconds')
  int get nanoseconds;

  /// Create a copy of TimestampModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimestampModelImplCopyWith<_$TimestampModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
