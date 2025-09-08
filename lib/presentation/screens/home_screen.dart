import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../widgets/custom_button.dart';
import '../../data/providers/auth_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);

    return Scaffold(
        appBar: AppBar(
            title: const Text('PDA 메인'),
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
            actions: [
              IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () => _showLogoutDialog(context, ref),
                  tooltip: '로그아웃')
            ]),
        body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Welcome section with user info
                  Card(
                      elevation: 4,
                      child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(children: [
                            Icon(Icons.factory,
                                size: 64,
                                color: Theme.of(context).colorScheme.primary),
                            const SizedBox(height: 16),
                            Text('SeAH Steel PDA',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Text('코일, 위치, 출하를 통합 관리하는 시스템입니다',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: Colors.grey[600]),
                                textAlign: TextAlign.center),
                            if (currentUser != null) ...[
                              const SizedBox(height: 16),
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                      color: Colors.blue.shade50,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                          color: Colors.blue.shade200)),
                                  child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.business,
                                            size: 16,
                                            color: Colors.blue.shade700),
                                        const SizedBox(width: 4),
                                        Text(currentUser.companyName ?? '알수없음',
                                            style: TextStyle(
                                                color: Colors.blue.shade700,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12))
                                      ]))
                            ]
                          ]))),

                  const SizedBox(height: 32),

                  // Navigation buttons section
                  Text('메뉴',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),

                  // Coil Management Button
                  CustomButton(
                      text: '코일 관리',
                      icon: const Icon(Icons.inventory, color: Colors.white),
                      onPressed: () => _navigateToCoilScreen(context),
                      height: 60,
                      backgroundColor: Colors.blue),

                  const SizedBox(height: 16),

                  // Location Management Button
                  CustomButton(
                      text: '위치 관리',
                      icon: const Icon(Icons.location_on, color: Colors.white),
                      onPressed: () => _navigateToLocationScreen(context),
                      height: 60,
                      backgroundColor: Colors.green),

                  const SizedBox(height: 16),

                  // Shipment Management Button
                  CustomButton(
                      text: '출하 관리',
                      icon:
                          const Icon(Icons.local_shipping, color: Colors.white),
                      onPressed: () => _navigateToShipmentScreen(context),
                      height: 60,
                      backgroundColor: Colors.orange),

                  const Spacer(),

                  // Footer info
                  Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(children: [
                        Icon(Icons.info_outline,
                            size: 20, color: Colors.grey[600]),
                        const SizedBox(width: 8),
                        Expanded(
                            child: Text('각 메뉴를 선택하여 해당 관리 화면으로 이동하세요',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: Colors.grey[600])))
                      ]))
                ])));
  }

  void _navigateToCoilScreen(BuildContext context) {
    context.go('/coil');
  }

  void _navigateToLocationScreen(BuildContext context) {
    context.go('/location');
  }

  void _navigateToShipmentScreen(BuildContext context) {
    context.go('/shipment');
  }

  Future<void> _showLogoutDialog(BuildContext context, WidgetRef ref) async {
    final result = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
                title: const Text('로그아웃'),
                content: const Text('정말 로그아웃 하시겠습니까?'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('취소')),
                  ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white),
                      child: const Text('로그아웃'))
                ]));

    if (result == true && context.mounted) {
      try {
        await ref.read(authStateProvider.notifier).logout();
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('로그아웃되었습니다'), backgroundColor: Colors.green));
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('로그아웃 중 오류가 발생했습니다: ${e.toString()}'),
              backgroundColor: Colors.red));
        }
      }
    }
  }
}
