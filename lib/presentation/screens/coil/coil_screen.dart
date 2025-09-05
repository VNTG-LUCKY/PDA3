import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../view_models/coil_view_model.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_app_bar.dart';

class CoilScreen extends ConsumerWidget {
  const CoilScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coilState = ref.watch(coilViewModelProvider);

    return Scaffold(
      appBar: ManagementAppBar(
        title: '코일 관리',
        onRefresh: () => ref.read(coilViewModelProvider.notifier).loadCoils(),
      ),
      body: coilState.when(
        data: (coils) => coils.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.inventory_outlined,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '등록된 코일이 없습니다',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '새로고침 버튼을 눌러 데이터를 불러오거나\n새 코일을 추가해보세요',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[500],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    CustomButton(
                      text: '데이터 불러오기',
                      icon: const Icon(Icons.refresh, color: Colors.white),
                      onPressed: () => ref.read(coilViewModelProvider.notifier).loadCoils(),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: coils.length,
                itemBuilder: (context, index) {
                  final coil = coils[index];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(coil.coilNumber),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('제품: ${coil.productType}'),
                          Text('중량: ${coil.weight}kg'),
                          Text('상태: ${coil.status}'),
                        ],
                      ),
                      trailing: PopupMenuButton<String>(
                        onSelected: (value) {
                          switch (value) {
                            case 'edit':
                              _showEditDialog(context, ref, coil.id);
                              break;
                            case 'delete':
                              _showDeleteDialog(context, ref, coil.id);
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
                    ),
                  );
                },
              ),
        loading: () => const LoadingIndicator(message: '코일 데이터를 불러오는 중...'),
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
                onPressed: () => ref.read(coilViewModelProvider.notifier).loadCoils(),
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

  void _showCreateDialog(BuildContext context, WidgetRef ref) {
    // TODO: Implement create coil dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('새 코일 생성'),
        content: const Text('코일 생성 기능을 구현해주세요.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('닫기'),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, WidgetRef ref, String coilId) {
    // TODO: Implement edit coil dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('코일 수정'),
        content: const Text('코일 수정 기능을 구현해주세요.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('닫기'),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, WidgetRef ref, String coilId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('코일 삭제'),
        content: const Text('정말로 이 코일을 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              ref.read(coilViewModelProvider.notifier).deleteCoil(coilId);
              Navigator.of(context).pop();
            },
            child: const Text('삭제'),
          ),
        ],
      ),
    );
  }
}
