import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../view_models/shipment_view_model.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_app_bar.dart';

class ShipmentScreen extends ConsumerWidget {
  const ShipmentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shipmentState = ref.watch(shipmentViewModelProvider);

    return Scaffold(
      appBar: ManagementAppBar(
        title: '출하 관리',
        onRefresh: () => ref.read(shipmentViewModelProvider.notifier).loadShipments(),
        additionalActions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context, ref),
            tooltip: '필터',
          ),
        ],
      ),
      body: shipmentState.when(
        data: (shipments) => shipments.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.local_shipping_outlined,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '등록된 출하가 없습니다',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '새로고침 버튼을 눌러 데이터를 불러오거나\n새 출하를 추가해보세요',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[500],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    CustomButton(
                      text: '데이터 불러오기',
                      icon: const Icon(Icons.refresh, color: Colors.white),
                      onPressed: () => ref.read(shipmentViewModelProvider.notifier).loadShipments(),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: shipments.length,
                itemBuilder: (context, index) {
                  final shipment = shipments[index];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: _getStatusColor(shipment['status']),
                        child: Icon(
                          _getStatusIcon(shipment['status']),
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        shipment['shipmentNumber'] ?? '출하번호 없음',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('고객: ${shipment['customer'] ?? 'N/A'}'),
                          Text('상태: ${_getStatusText(shipment['status'])}'),
                          Text('예정일: ${shipment['scheduledDate'] ?? 'N/A'}'),
                          Text('수량: ${shipment['quantity'] ?? 'N/A'}개'),
                        ],
                      ),
                      trailing: PopupMenuButton<String>(
                        onSelected: (value) {
                          switch (value) {
                            case 'view':
                              _showShipmentDetails(context, shipment);
                              break;
                            case 'edit':
                              _showEditDialog(context, ref, shipment);
                              break;
                            case 'delete':
                              _showDeleteDialog(context, ref, shipment['id']);
                              break;
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'view',
                            child: Text('상세 보기'),
                          ),
                          const PopupMenuItem(
                            value: 'edit',
                            child: Text('수정'),
                          ),
                          const PopupMenuItem(
                            value: 'delete',
                            child: Text('삭제'),
                          ),
                        ],
                      ),
                      onTap: () => _showShipmentDetails(context, shipment),
                    ),
                  );
                },
              ),
        loading: () => const LoadingIndicator(message: '출하 데이터를 불러오는 중...'),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red[400],
              ),
              const SizedBox(height: 16),
              Text(
                '데이터를 불러올 수 없습니다',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.red[600],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '네트워크 연결을 확인하고 다시 시도해주세요',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: '다시 시도',
                icon: const Icon(Icons.refresh, color: Colors.white),
                onPressed: () => ref.read(shipmentViewModelProvider.notifier).loadShipments(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'in_progress':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return Icons.schedule;
      case 'in_progress':
        return Icons.local_shipping;
      case 'completed':
        return Icons.check_circle;
      case 'cancelled':
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }

  String _getStatusText(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return '대기중';
      case 'in_progress':
        return '진행중';
      case 'completed':
        return '완료';
      case 'cancelled':
        return '취소됨';
      default:
        return '알 수 없음';
    }
  }

  void _showShipmentDetails(BuildContext context, Map<String, dynamic> shipment) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(shipment['shipmentNumber'] ?? '출하 상세'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('고객: ${shipment['customer'] ?? 'N/A'}'),
              Text('상태: ${_getStatusText(shipment['status'])}'),
              Text('예정일: ${shipment['scheduledDate'] ?? 'N/A'}'),
              Text('실제 출하일: ${shipment['actualDate'] ?? 'N/A'}'),
              Text('수량: ${shipment['quantity'] ?? 'N/A'}개'),
              Text('총 중량: ${shipment['totalWeight'] ?? 'N/A'}kg'),
              Text('운송업체: ${shipment['carrier'] ?? 'N/A'}'),
              Text('트럭번호: ${shipment['truckNumber'] ?? 'N/A'}'),
              Text('비고: ${shipment['remarks'] ?? 'N/A'}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('닫기'),
          ),
        ],
      ),
    );
  }

  void _showCreateDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('새 출하 생성'),
        content: const Text('출하 생성 기능을 구현해주세요.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('닫기'),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, WidgetRef ref, Map<String, dynamic> shipment) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('출하 수정'),
        content: const Text('출하 수정 기능을 구현해주세요.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('닫기'),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, WidgetRef ref, String? shipmentId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('출하 삭제'),
        content: const Text('정말로 이 출하를 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              if (shipmentId != null) {
                ref.read(shipmentViewModelProvider.notifier).deleteShipment(shipmentId);
              }
              Navigator.of(context).pop();
            },
            child: const Text('삭제'),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('필터 설정'),
        content: const Text('필터 기능을 구현해주세요.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('닫기'),
          ),
        ],
      ),
    );
  }
}
