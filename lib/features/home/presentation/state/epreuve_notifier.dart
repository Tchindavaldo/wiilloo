import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/epreuve_group_model.dart';
import '../../data/models/epreuve_model.dart';
import '../../data/repositories/epreuve_repository.dart';
import 'epreuve_state.dart';

class EpreuveNotifier extends StateNotifier<EpreuveState> {
  final EpreuveRepository _repository;
  StreamSubscription? _socketSubscription;
  
  EpreuveNotifier(this._repository) : super(const EpreuveState()) {
    _initializeSocketListener();
  }
  
  void _initializeSocketListener() {
    // Connect to Socket.IO for real-time updates
    _repository.connectSocket();
    
    // Listen to repository events
    _socketSubscription = _repository.eventStream.listen((event) {
      switch (event.type) {
        case RepositoryEventType.created:
          _handleEpreuveCreated(event.data as EpreuveModel);
          break;
        case RepositoryEventType.updated:
          _handleEpreuveUpdated(event.data as EpreuveModel);
          break;
        case RepositoryEventType.deleted:
          _handleEpreuveDeleted(event.data as String);
          break;
        case RepositoryEventType.correctionUpdated:
          _handleCorrectionUpdated(event.data);
          break;
      }
    });
  }
  
  /// Initial load of epreuves
  Future<void> loadEpreuves({
    String groupBy = 'schoolName',
    int itemsPerGroup = 4,
    int groupsLimit = 18,
  }) async {
    if (state.isLoading) return;
    
    state = state.copyWith(
      isLoading: true,
      error: null,
    );
    
    try {
      final response = await _repository.fetchEpreuves(
        cursor: 0,
        groupBy: groupBy,
        itemsPerGroup: itemsPerGroup,
        groupsLimit: groupsLimit,
        lastDocId: null, // Pas de lastDocId pour le chargement initial
      );
      
      if (response.success) {
        // Extraire paginationState depuis nextPageParams
        final paginationState = response.nextPageParams?['paginationState'] as String?;
        
        state = state.copyWith(
          groups: response.items,
          isLoading: false,
          hasMore: response.pagination.hasMore,
          currentCursor: response.pagination.cursor,
          nextCursor: response.pagination.nextCursor,
          lastDocId: response.lastDoc?.lastDocId,
          paginationState: paginationState, // Stocker paginationState
          totalAvailable: response.pagination.totalAvailable,
          error: null,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
  
  /// Load more epreuves (infinite scroll)
  Future<void> loadMoreEpreuves({
    String groupBy = 'schoolName',
    int itemsPerGroup = 4,
    int groupsLimit = 18,
  }) async {
    if (!state.canLoadMore) return;
    
    state = state.copyWith(isLoadingMore: true);
    
    try {
      // Calculer le nextCursor localement pour éviter les problèmes du backend
      final nextCursor = state.currentCursor + groupsLimit;
      
      final response = await _repository.fetchEpreuves(
        cursor: nextCursor,
        groupBy: groupBy,
        itemsPerGroup: itemsPerGroup,
        groupsLimit: groupsLimit,
        lastDocId: state.lastDocId,
        paginationState: state.paginationState, // Utiliser paginationState du state
      );
      
      if (response.success) {
        // Extraire paginationState depuis nextPageParams
        final paginationState = response.nextPageParams?['paginationState'] as String?;
        
        state = state.copyWith(
          groups: [...state.groups, ...response.items],
          isLoadingMore: false,
          hasMore: response.pagination.hasMore,
          currentCursor: response.pagination.cursor,
          nextCursor: response.pagination.nextCursor,
          lastDocId: response.lastDoc?.lastDocId,
          paginationState: paginationState, // Mettre à jour paginationState
          totalAvailable: response.pagination.totalAvailable,
          error: null,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoadingMore: false,
        error: e.toString(),
      );
    }
  }
  
  /// Load more epreuves horizontally for a specific group
  Future<void> loadMoreHorizontal({
    required String groupId,
    String groupBy = 'schoolName',
    int itemsPerGroup = 4,
  }) async {
    // Find the group
    final groupIndex = state.groups.indexWhere((g) => g.id == groupId);
    if (groupIndex == -1) return;
    
    final group = state.groups[groupIndex];
    
    // Don't load if already loading or no more items
    if (group.isLoadingHorizontal || !group.hasMoreHorizontal) return;
    
    // Set loading state for this specific group
    final updatedGroups = [...state.groups];
    updatedGroups[groupIndex] = group.copyWith(isLoadingHorizontal: true);
    state = state.copyWith(groups: updatedGroups);
    
    try {
      final nextOffset = group.nextHorizontalCursor ?? 
                        (group.currentHorizontalOffset + itemsPerGroup);
      
      final response = await _repository.fetchMoreHorizontal(
        groupBy: groupBy,
        groupFilters: group.groupFields,
        groupOffset: nextOffset,
        itemsPerGroup: itemsPerGroup,
      );
      
      if (response.success && response.items.isNotEmpty) {
        final newGroupData = response.items.first;
        
        // Metadata is already parsed in API service
        // Merge new epreuves with existing ones (filter out nulls)
        final existingEpreuves = group.epreuves.where((e) => e != null).toList();
        final newEpreuves = newGroupData.epreuves.where((e) => e != null).toList();
        final mergedEpreuves = [...existingEpreuves, ...newEpreuves];
        
        // Update the group with new data from backend
        final updatedGroupsFinal = [...state.groups];
        updatedGroupsFinal[groupIndex] = group.copyWith(
          epreuves: mergedEpreuves,
          isLoadingHorizontal: false,
          hasMoreHorizontal: newGroupData.hasMoreHorizontal,
          nextHorizontalCursor: newGroupData.nextHorizontalCursor,
          currentHorizontalOffset: newGroupData.currentHorizontalOffset,
          totalInGroup: newGroupData.totalInGroup ?? group.totalInGroup,
        );
        
        state = state.copyWith(groups: updatedGroupsFinal);
      } else {
        // No more items
        final updatedGroupsFinal = [...state.groups];
        updatedGroupsFinal[groupIndex] = group.copyWith(
          isLoadingHorizontal: false,
          hasMoreHorizontal: false,
        );
        state = state.copyWith(groups: updatedGroupsFinal);
      }
    } catch (e) {
      // Handle error - stop loading
      final updatedGroupsError = [...state.groups];
      updatedGroupsError[groupIndex] = group.copyWith(
        isLoadingHorizontal: false,
      );
      state = state.copyWith(
        groups: updatedGroupsError,
        error: e.toString(),
      );
    }
  }
  
  /// Refresh the entire list
  Future<void> refreshEpreuves({
    String groupBy = 'schoolName',
    int itemsPerGroup = 4,
    int groupsLimit = 18,
  }) async {
    state = const EpreuveState();
    await loadEpreuves(
      groupBy: groupBy,
      itemsPerGroup: itemsPerGroup,
      groupsLimit: groupsLimit,
    );
  }
  
  /// Create a new epreuve
  Future<void> createEpreuve(Map<String, dynamic> data) async {
    try {
      await _repository.createEpreuve(data);
      // The socket will handle the UI update
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
  
  /// Update an existing epreuve
  Future<void> updateEpreuve(String id, Map<String, dynamic> data) async {
    try {
      await _repository.updateEpreuve(id, data);
      // The socket will handle the UI update
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
  
  /// Delete an epreuve
  Future<void> deleteEpreuve(String id) async {
    try {
      await _repository.deleteEpreuve(id);
      // The socket will handle the UI update
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
  
  /// Handle real-time epreuve creation
  void _handleEpreuveCreated(EpreuveModel epreuve) {
    // Find the appropriate group or create a new one
    final groups = [...state.groups];
    final groupIndex = groups.indexWhere(
      (g) => g.groupKey == epreuve.schoolName,
    );
    
    if (groupIndex != -1) {
      // Add to existing group
      final group = groups[groupIndex];
      final updatedEpreuves = [...group.epreuves, epreuve];
      groups[groupIndex] = group.copyWith(epreuves: updatedEpreuves);
    } else {
      // Create new group
      final newGroup = EpreuveGroupModel(
        id: 'realtime_${epreuve.schoolName}_${DateTime.now().millisecondsSinceEpoch}',
        groupBy: ['schoolName'],
        groupKey: epreuve.schoolName,
        groupFields: {'schoolName': epreuve.schoolName},
        epreuves: [epreuve],
      );
      groups.insert(0, newGroup);
    }
    
    state = state.copyWith(groups: groups);
  }
  
  /// Handle real-time epreuve update
  void _handleEpreuveUpdated(EpreuveModel epreuve) {
    final groups = [...state.groups];
    bool updated = false;
    
    for (int i = 0; i < groups.length; i++) {
      final group = groups[i];
      final epreuveIndex = group.epreuves.indexWhere(
        (e) => e?.id == epreuve.id,
      );
      
      if (epreuveIndex != -1) {
        final updatedEpreuves = [...group.epreuves];
        updatedEpreuves[epreuveIndex] = epreuve;
        groups[i] = group.copyWith(epreuves: updatedEpreuves);
        updated = true;
        break;
      }
    }
    
    if (updated) {
      state = state.copyWith(groups: groups);
    }
  }
  
  /// Handle real-time epreuve deletion
  void _handleEpreuveDeleted(String epreuveId) {
    final groups = [...state.groups];
    
    for (int i = 0; i < groups.length; i++) {
      final group = groups[i];
      final filteredEpreuves = group.epreuves.where(
        (e) => e?.id != epreuveId,
      ).toList();
      
      if (filteredEpreuves.length != group.epreuves.length) {
        if (filteredEpreuves.isEmpty) {
          // Remove empty group
          groups.removeAt(i);
        } else {
          groups[i] = group.copyWith(epreuves: filteredEpreuves);
        }
        break;
      }
    }
    
    state = state.copyWith(groups: groups);
  }
  
  /// Handle correction updates
  void _handleCorrectionUpdated(dynamic data) {
    // Implement correction update logic based on your data structure
    final epreuveId = data['epreuveId'] as String?;
    if (epreuveId == null) return;
    
    final groups = [...state.groups];
    
    for (int i = 0; i < groups.length; i++) {
      final group = groups[i];
      final epreuveIndex = group.epreuves.indexWhere(
        (e) => e?.id == epreuveId,
      );
      
      if (epreuveIndex != -1) {
        // Refresh this epreuve from backend
        _repository.getEpreuveById(epreuveId).then((updatedEpreuve) {
          _handleEpreuveUpdated(updatedEpreuve);
        });
        break;
      }
    }
  }
  
  
  @override
  void dispose() {
    _socketSubscription?.cancel();
    _repository.disconnectSocket();
    super.dispose();
  }
}
