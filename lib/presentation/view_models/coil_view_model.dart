import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/coil_model.dart';
import '../../data/services/pda_api_service.dart';

class CoilViewModel extends StateNotifier<AsyncValue<List<CoilModel>>> {
  final PdaApiService _apiService;

  CoilViewModel(this._apiService) : super(const AsyncValue.data([])) {
    // Don't auto-load data on initialization to avoid API timeout
    // loadCoils();
  }

  Future<void> loadCoils({
    int page = 1,
    int limit = 20,
    String? search,
    String? status,
  }) async {
    try {
      state = const AsyncValue.loading();
      final coils = await _apiService.getCoils(
        page: page,
        limit: limit,
        search: search,
        status: status,
      );
      state = AsyncValue.data(coils);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> createCoil(Map<String, dynamic> coilData) async {
    try {
      await _apiService.createCoil(coilData);
      await loadCoils(); // Reload the list
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> updateCoil(String id, Map<String, dynamic> coilData) async {
    try {
      await _apiService.updateCoil(id, coilData);
      await loadCoils(); // Reload the list
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> deleteCoil(String id) async {
    try {
      await _apiService.deleteCoil(id);
      await loadCoils(); // Reload the list
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<CoilModel?> getCoilById(String id) async {
    try {
      return await _apiService.getCoilById(id);
    } catch (error) {
      // Handle error silently or show a snackbar
      return null;
    }
  }

  void searchCoils(String query) {
    loadCoils(search: query);
  }

  void filterByStatus(String? status) {
    loadCoils(status: status);
  }

  void refresh() {
    loadCoils();
  }
}

final coilViewModelProvider = StateNotifierProvider<CoilViewModel, AsyncValue<List<CoilModel>>>((ref) {
  final apiService = ref.watch(pdaApiServiceProvider);
  return CoilViewModel(apiService);
});
