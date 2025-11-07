// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'epreuve_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EpreuveModelImpl _$$EpreuveModelImplFromJson(
  Map<String, dynamic> json,
) => _$EpreuveModelImpl(
  id: json['id'] as String,
  titre: json['titre'] as String,
  description: json['description'] as String?,
  matiere: json['matiere'] as String,
  niveau: json['niveau'] as String,
  categorie: json['categorie'] as String,
  duree: (json['duree'] as num?)?.toInt() ?? 0,
  bareme: json['bareme'] as String?,
  schoolName: json['schoolName'] as String,
  annee: (json['annee'] as num).toInt(),
  downloadCount: (json['downloadCount'] as num?)?.toInt() ?? 0,
  fichiers:
      (json['fichiers'] as List<dynamic>?)
          ?.map((e) => FichierModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  createdBy: json['createdBy'] as String,
  status: json['status'] as String,
  corrections:
      (json['corrections'] as List<dynamic>?)
          ?.map((e) => CorrectionModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  correctionsCount: (json['correctionsCount'] as num?)?.toInt() ?? 0,
  hasCorrection: json['hasCorrection'] as bool? ?? false,
  createdAt: TimestampModel.fromJson(json['createdAt'] as Map<String, dynamic>),
  updatedAt: TimestampModel.fromJson(json['updatedAt'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$EpreuveModelImplToJson(_$EpreuveModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'titre': instance.titre,
      'description': instance.description,
      'matiere': instance.matiere,
      'niveau': instance.niveau,
      'categorie': instance.categorie,
      'duree': instance.duree,
      'bareme': instance.bareme,
      'schoolName': instance.schoolName,
      'annee': instance.annee,
      'downloadCount': instance.downloadCount,
      'fichiers': instance.fichiers,
      'createdBy': instance.createdBy,
      'status': instance.status,
      'corrections': instance.corrections,
      'correctionsCount': instance.correctionsCount,
      'hasCorrection': instance.hasCorrection,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

_$FichierModelImpl _$$FichierModelImplFromJson(Map<String, dynamic> json) =>
    _$FichierModelImpl(
      nom: json['nom'] as String?,
      url: json['url'] as String?,
      type: json['type'] as String?,
      taille: (json['taille'] as num?)?.toInt() ?? 0,
      uploadedAt: json['uploadedAt'] as String?,
    );

Map<String, dynamic> _$$FichierModelImplToJson(_$FichierModelImpl instance) =>
    <String, dynamic>{
      'nom': instance.nom,
      'url': instance.url,
      'type': instance.type,
      'taille': instance.taille,
      'uploadedAt': instance.uploadedAt,
    };

_$CorrectionModelImpl _$$CorrectionModelImplFromJson(
  Map<String, dynamic> json,
) => _$CorrectionModelImpl(
  id: json['id'] as String?,
  titre: json['titre'] as String?,
  qualityLevel: json['qualityLevel'] as String?,
  correcteur: json['correcteur'] == null
      ? null
      : CorrecteurModel.fromJson(json['correcteur'] as Map<String, dynamic>),
  commentaire: json['commentaire'] as String?,
  fileUrl: json['fileUrl'] as String?,
  fileName: json['fileName'] as String?,
  fileType: json['fileType'] as String?,
  fileSize: json['fileSize'] as String?,
  driveFileId: json['driveFileId'] as String?,
);

Map<String, dynamic> _$$CorrectionModelImplToJson(
  _$CorrectionModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'titre': instance.titre,
  'qualityLevel': instance.qualityLevel,
  'correcteur': instance.correcteur,
  'commentaire': instance.commentaire,
  'fileUrl': instance.fileUrl,
  'fileName': instance.fileName,
  'fileType': instance.fileType,
  'fileSize': instance.fileSize,
  'driveFileId': instance.driveFileId,
};

_$CorrecteurModelImpl _$$CorrecteurModelImplFromJson(
  Map<String, dynamic> json,
) => _$CorrecteurModelImpl(
  nom: json['nom'] as String,
  prenom: json['prenom'] as String,
  email: json['email'] as String,
  telephone: json['telephone'] as String,
);

Map<String, dynamic> _$$CorrecteurModelImplToJson(
  _$CorrecteurModelImpl instance,
) => <String, dynamic>{
  'nom': instance.nom,
  'prenom': instance.prenom,
  'email': instance.email,
  'telephone': instance.telephone,
};

_$TimestampModelImpl _$$TimestampModelImplFromJson(Map<String, dynamic> json) =>
    _$TimestampModelImpl(
      seconds: (json['_seconds'] as num).toInt(),
      nanoseconds: (json['_nanoseconds'] as num).toInt(),
    );

Map<String, dynamic> _$$TimestampModelImplToJson(
  _$TimestampModelImpl instance,
) => <String, dynamic>{
  '_seconds': instance.seconds,
  '_nanoseconds': instance.nanoseconds,
};
