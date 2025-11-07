import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/epreuve_group_model.dart';

part 'epreuve_state.freezed.dart';

@freezed
class EpreuveState with _$EpreuveState {
  const factory EpreuveState({
    @Default([]) List<EpreuveGroupModel> groups,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(false) bool hasMore,
    @Default(0) int currentCursor,
    int? nextCursor,
    String? lastDocId,
    String? paginationState,
    String? error,
    @Default(0) int totalAvailable,
  }) = _EpreuveState;
  
  const EpreuveState._();
  
  /// Check if this is the initial load
  bool get isInitialLoad => groups.isEmpty && isLoading;
  
  /// Check if we have data
  bool get hasData => groups.isNotEmpty;
  
  /// Check if we can load more
  bool get canLoadMore => hasMore && !isLoadingMore && !isLoading;
}
