import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/services/pda_api_service.dart';

class ShipmentViewModel extends StateNotifier<AsyncValue<List<Map<String, dynamic>>>> {
  final PdaApiService _apiService;

  ShipmentViewModel(this._apiService) : super(const AsyncValue.data([])) {
    // Don't auto-load data on initialization to avoid API timeout
    // loadShipments();
  }

  Future<void> loadShipments({
    int page = 1,
    int limit = 20,
    String? status,
  }) async {
    try {
      state = const AsyncValue.loading();
      final shipments = await _apiService.getShipments(
        page: page,
        limit: limit,
        status: status,
      );
      state = AsyncValue.data(shipments);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> createShipment(Map<String, dynamic> shipmentData) async {
    try {
      await _apiService.createShipment(shipmentData);
      await loadShipments(); // Reload the list
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> updateShipment(String id, Map<String, dynamic> shipmentData) async {
    try {
      // TODO: Implement update shipment API call
      // await _apiService.updateShipment(id, shipmentData);
      await loadShipments(); // Reload the list
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> deleteShipment(String id) async {
    try {
      // TODO: Implement delete shipment API call
      // await _apiService.deleteShipment(id);
      await loadShipments(); // Reload the list
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Map<String, dynamic>? getShipmentById(String id) {
    final currentState = state;
    if (currentState is AsyncData<List<Map<String, dynamic>>>) {
      try {
        return currentState.value.firstWhere((shipment) => shipment['id'] == id);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  List<Map<String, dynamic>> searchShipments(String query) {
    final currentState = state;
    if (currentState is AsyncData<List<Map<String, dynamic>>>) {
      return currentState.value.where((shipment) {
        final shipmentNumber = shipment['shipmentNumber']?.toString().toLowerCase() ?? '';
        final customer = shipment['customer']?.toString().toLowerCase() ?? '';
        final carrier = shipment['carrier']?.toString().toLowerCase() ?? '';
        final searchQuery = query.toLowerCase();
        
        return shipmentNumber.contains(searchQuery) || 
               customer.contains(searchQuery) || 
               carrier.contains(searchQuery);
      }).toList();
    }
    return [];
  }

  List<Map<String, dynamic>> filterByStatus(String status) {
    final currentState = state;
    if (currentState is AsyncData<List<Map<String, dynamic>>>) {
      return currentState.value.where((shipment) {
        return shipment['status']?.toString().toLowerCase() == status.toLowerCase();
      }).toList();
    }
    return [];
  }

  List<Map<String, dynamic>> filterByCustomer(String customer) {
    final currentState = state;
    if (currentState is AsyncData<List<Map<String, dynamic>>>) {
      return currentState.value.where((shipment) {
        return shipment['customer']?.toString().toLowerCase() == customer.toLowerCase();
      }).toList();
    }
    return [];
  }

  List<Map<String, dynamic>> filterByDateRange(DateTime startDate, DateTime endDate) {
    final currentState = state;
    if (currentState is AsyncData<List<Map<String, dynamic>>>) {
      return currentState.value.where((shipment) {
        final scheduledDateStr = shipment['scheduledDate']?.toString();
        if (scheduledDateStr == null) return false;
        
        try {
          final scheduledDate = DateTime.parse(scheduledDateStr);
          return scheduledDate.isAfter(startDate) && scheduledDate.isBefore(endDate);
        } catch (e) {
          return false;
        }
      }).toList();
    }
    return [];
  }

  Future<void> updateShipmentStatus(String id, String newStatus) async {
    try {
      await updateShipment(id, {'status': newStatus});
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  void refresh() {
    loadShipments();
  }

  // Statistics methods
  int getTotalShipments() {
    final currentState = state;
    if (currentState is AsyncData<List<Map<String, dynamic>>>) {
      return currentState.value.length;
    }
    return 0;
  }

  int getShipmentsByStatus(String status) {
    return filterByStatus(status).length;
  }

  double getTotalWeight() {
    final currentState = state;
    if (currentState is AsyncData<List<Map<String, dynamic>>>) {
      return currentState.value.fold(0.0, (sum, shipment) {
        final weight = shipment['totalWeight'];
        if (weight is num) {
          return sum + weight.toDouble();
        }
        return sum;
      });
    }
    return 0.0;
  }
}

final shipmentViewModelProvider = StateNotifierProvider<ShipmentViewModel, AsyncValue<List<Map<String, dynamic>>>>((ref) {
  final apiService = ref.watch(pdaApiServiceProvider);
  return ShipmentViewModel(apiService);
});
