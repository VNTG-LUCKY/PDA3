import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/services/pda_api_service.dart';

class LocationViewModel extends StateNotifier<AsyncValue<List<Map<String, dynamic>>>> {
  final PdaApiService _apiService;

  LocationViewModel(this._apiService) : super(const AsyncValue.data([])) {
    // Don't auto-load data on initialization to avoid API timeout
    // loadLocations();
  }

  Future<void> loadLocations() async {
    try {
      state = const AsyncValue.loading();
      final locations = await _apiService.getLocations();
      state = AsyncValue.data(locations);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> createLocation(Map<String, dynamic> locationData) async {
    try {
      // TODO: Implement create location API call
      // await _apiService.createLocation(locationData);
      await loadLocations(); // Reload the list
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> updateLocation(String id, Map<String, dynamic> locationData) async {
    try {
      // TODO: Implement update location API call
      // await _apiService.updateLocation(id, locationData);
      await loadLocations(); // Reload the list
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> deleteLocation(String id) async {
    try {
      // TODO: Implement delete location API call
      // await _apiService.deleteLocation(id);
      await loadLocations(); // Reload the list
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Map<String, dynamic>? getLocationById(String id) {
    final currentState = state;
    if (currentState is AsyncData<List<Map<String, dynamic>>>) {
      try {
        return currentState.value.firstWhere((location) => location['id'] == id);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  List<Map<String, dynamic>> searchLocations(String query) {
    final currentState = state;
    if (currentState is AsyncData<List<Map<String, dynamic>>>) {
      return currentState.value.where((location) {
        final name = location['name']?.toString().toLowerCase() ?? '';
        final code = location['code']?.toString().toLowerCase() ?? '';
        final zone = location['zone']?.toString().toLowerCase() ?? '';
        final searchQuery = query.toLowerCase();
        
        return name.contains(searchQuery) || 
               code.contains(searchQuery) || 
               zone.contains(searchQuery);
      }).toList();
    }
    return [];
  }

  List<Map<String, dynamic>> filterByZone(String zone) {
    final currentState = state;
    if (currentState is AsyncData<List<Map<String, dynamic>>>) {
      return currentState.value.where((location) {
        return location['zone']?.toString().toLowerCase() == zone.toLowerCase();
      }).toList();
    }
    return [];
  }

  List<Map<String, dynamic>> filterByType(String type) {
    final currentState = state;
    if (currentState is AsyncData<List<Map<String, dynamic>>>) {
      return currentState.value.where((location) {
        return location['type']?.toString().toLowerCase() == type.toLowerCase();
      }).toList();
    }
    return [];
  }

  void refresh() {
    loadLocations();
  }
}

final locationViewModelProvider = StateNotifierProvider<LocationViewModel, AsyncValue<List<Map<String, dynamic>>>>((ref) {
  final apiService = ref.watch(pdaApiServiceProvider);
  return LocationViewModel(apiService);
});
