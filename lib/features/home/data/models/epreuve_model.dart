import 'package:freezed_annotation/freezed_annotation.dart';

part 'epreuve_model.freezed.dart';
part 'epreuve_model.g.dart';

@freezed
class EpreuveModel with _$EpreuveModel {
  const factory EpreuveModel({
    required String id,
    required String titre,
    String? description,
    required String matiere,
    required String niveau,
    required String categorie,
    @Default(0) int duree,
    String? bareme,
    required String schoolName,
    required int annee,
    @Default(0) int downloadCount,
    @Default([]) List<FichierModel> fichiers,
    required String createdBy,
    required String status,
    @Default([]) List<CorrectionModel> corrections,
    @Default(0) int correctionsCount,
    @Default(false) bool hasCorrection,
    required TimestampModel createdAt,
    required TimestampModel updatedAt,
  }) = _EpreuveModel;

  factory EpreuveModel.fromJson(Map<String, dynamic> json) =>
      _$EpreuveModelFromJson(json);
}

@freezed
class FichierModel with _$FichierModel {
  const factory FichierModel({
    String? nom,
    String? url,
    String? type,
    @Default(0) int taille,
    String? uploadedAt,
  }) = _FichierModel;

  factory FichierModel.fromJson(Map<String, dynamic> json) =>
      _$FichierModelFromJson(json);
}

@freezed
class CorrectionModel with _$CorrectionModel {
  const factory CorrectionModel({
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
  }) = _CorrectionModel;

  factory CorrectionModel.fromJson(Map<String, dynamic> json) =>
      _$CorrectionModelFromJson(json);
}

@freezed
class CorrecteurModel with _$CorrecteurModel {
  const factory CorrecteurModel({
    required String nom,
    required String prenom,
    required String email,
    required String telephone,
  }) = _CorrecteurModel;

  factory CorrecteurModel.fromJson(Map<String, dynamic> json) =>
      _$CorrecteurModelFromJson(json);
}

@freezed
class TimestampModel with _$TimestampModel {
  const factory TimestampModel({
    @JsonKey(name: '_seconds') required int seconds,
    @JsonKey(name: '_nanoseconds') required int nanoseconds,
  }) = _TimestampModel;

  factory TimestampModel.fromJson(Map<String, dynamic> json) =>
      _$TimestampModelFromJson(json);
}
