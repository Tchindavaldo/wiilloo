import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/epreuve_repository.dart';
import '../../data/services/epreuve_api_service.dart';
import '../../data/services/epreuve_socket_service.dart';
import '../state/epreuve_notifier.dart';
import '../state/epreuve_state.dart';

/// Provider for the API service
final epreuveApiServiceProvider = Provider<EpreuveApiService>((ref) {
  return EpreuveApiService();
});

/// Provider for the Socket.IO service
final epreuveSocketServiceProvider = Provider<EpreuveSocketService>((ref) {
  return EpreuveSocketService();
});

/// Provider for the repository
final epreuveRepositoryProvider = Provider<EpreuveRepository>((ref) {
  final apiService = ref.watch(epreuveApiServiceProvider);
  final socketService = ref.watch(epreuveSocketServiceProvider);
  
  return EpreuveRepository(
    apiService: apiService,
    socketService: socketService,
  );
});

/// Main state notifier provider for epreuves
final epreuveNotifierProvider = StateNotifierProvider<EpreuveNotifier, EpreuveState>((ref) {
  final repository = ref.watch(epreuveRepositoryProvider);
  return EpreuveNotifier(repository);
});

/// Computed providers for specific state slices

/// Check if initial loading
final isInitialLoadingProvider = Provider<bool>((ref) {
  final state = ref.watch(epreuveNotifierProvider);
  return state.isInitialLoad;
});

/// Check if loading more
final isLoadingMoreProvider = Provider<bool>((ref) {
  final state = ref.watch(epreuveNotifierProvider);
  return state.isLoadingMore;
});

/// Check if has error
final hasErrorProvider = Provider<bool>((ref) {
  final state = ref.watch(epreuveNotifierProvider);
  return state.error != null;
});

/// Get error message
final errorMessageProvider = Provider<String?>((ref) {
  final state = ref.watch(epreuveNotifierProvider);
  return state.error;
});

/// Check if can load more
final canLoadMoreProvider = Provider<bool>((ref) {
  final state = ref.watch(epreuveNotifierProvider);
  return state.canLoadMore;
});

/// Get groups count
final groupsCountProvider = Provider<int>((ref) {
  final state = ref.watch(epreuveNotifierProvider);
  return state.groups.length;
});
