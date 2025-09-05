import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../view_models/location_view_model.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_app_bar.dart';

class LocationScreen extends ConsumerWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationState = ref.watch(locationViewModelProvider);

    return Scaffold(
      appBar: ManagementAppBar(
        title: '위치 관리',
        onRefresh: () => ref.read(locationViewModelProvider.notifier).loadLocations(),
      ),
      body: locationState.when(
        data: (locations) => locations.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_off_outlined,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '등록된 위치가 없습니다',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '새로고침 버튼을 눌러 데이터를 불러오거나\n새 위치를 추가해보세요',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[500],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    CustomButton(
                      text: '데이터 불러오기',
                      icon: const Icon(Icons.refresh, color: Colors.white),
                      onPressed: () => ref.read(locationViewModelProvider.notifier).loadLocations(),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: locations.length,
                itemBuilder: (context, index) {
                  final location = locations[index];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: const Icon(Icons.location_on),
                      title: Text(location['name'] ?? '알 수 없는 위치'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('코드: ${location['code'] ?? 'N/A'}'),
                          Text('구역: ${location['zone'] ?? 'N/A'}'),
                          Text('타입: ${location['type'] ?? 'N/A'}'),
                        ],
                      ),
                      trailing: PopupMenuButton<String>(
                        onSelected: (value) {
                          switch (value) {
                            case 'edit':
                              _showEditDialog(context, ref, location);
                              break;
                            case 'delete':
                              _showDeleteDialog(context, ref, location['id']);
                              break;
                          }
                        },
                        itemBuilder: (context) => [
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
                      onTap: () => _showLocationDetails(context, location),
                    ),
                  );
                },
              ),
        loading: () => const LoadingIndicator(message: '위치 데이터를 불러오는 중...'),
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
                onPressed: () => ref.read(locationViewModelProvider.notifier).loadLocations(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateDialog(context, ref),
        child: const Icon(Icons.add_location),
      ),
    );
  }

  void _showLocationDetails(BuildContext context, Map<String, dynamic> location) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(location['name'] ?? '위치 상세'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('코드: ${location['code'] ?? 'N/A'}'),
            Text('구역: ${location['zone'] ?? 'N/A'}'),
            Text('타입: ${location['type'] ?? 'N/A'}'),
            Text('설명: ${location['description'] ?? 'N/A'}'),
            Text('생성일: ${location['createdAt'] ?? 'N/A'}'),
          ],
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
        title: const Text('새 위치 생성'),
        content: const Text('위치 생성 기능을 구현해주세요.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('닫기'),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, WidgetRef ref, Map<String, dynamic> location) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('위치 수정'),
        content: const Text('위치 수정 기능을 구현해주세요.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('닫기'),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, WidgetRef ref, String? locationId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('위치 삭제'),
        content: const Text('정말로 이 위치를 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              if (locationId != null) {
                // TODO: Implement delete location
                // ref.read(locationViewModelProvider.notifier).deleteLocation(locationId);
              }
              Navigator.of(context).pop();
            },
            child: const Text('삭제'),
          ),
        ],
      ),
    );
  }
}
