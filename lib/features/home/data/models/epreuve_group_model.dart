import 'package:freezed_annotation/freezed_annotation.dart';
import 'epreuve_model.dart';

part 'epreuve_group_model.freezed.dart';
part 'epreuve_group_model.g.dart';

@freezed
class EpreuveGroupModel with _$EpreuveGroupModel {
  const factory EpreuveGroupModel({
    required String id,
    required List<String> groupBy,
    required String groupKey,
    required Map<String, dynamic> groupFields,
    required List<EpreuveModel?> epreuves,
    // Horizontal pagination metadata
    @Default(false) bool hasMoreHorizontal,
    @Default(false) bool isLoadingHorizontal,
    int? nextHorizontalCursor,
    @Default(0) int currentHorizontalOffset,
    int? totalInGroup,
  }) = _EpreuveGroupModel;

  factory EpreuveGroupModel.fromJson(Map<String, dynamic> json) =>
      _$EpreuveGroupModelFromJson(json);
}

@freezed
class PaginationModel with _$PaginationModel {
  const factory PaginationModel({
    required int cursor,
    int? nextCursor,
    required int limit,
    required bool hasMore,
    required int totalAvailable,
  }) = _PaginationModel;

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      _$PaginationModelFromJson(json);
}

@freezed
class LastDocModel with _$LastDocModel {
  const factory LastDocModel({
    required String id,
    required String lastDocId,
    required String lastDocData,
  }) = _LastDocModel;

  factory LastDocModel.fromJson(Map<String, dynamic> json) =>
      _$LastDocModelFromJson(json);
}

@freezed
class EpreuvesResponseModel with _$EpreuvesResponseModel {
  const factory EpreuvesResponseModel({
    required bool success,
    required List<EpreuveGroupModel> items,
    required PaginationModel pagination,
    LastDocModel? lastDoc, // Optionnel car peut être null du backend
    Map<String, dynamic>? nextPageParams,
    required String source,
  }) = _EpreuvesResponseModel;

  factory EpreuvesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$EpreuvesResponseModelFromJson(json);
}
