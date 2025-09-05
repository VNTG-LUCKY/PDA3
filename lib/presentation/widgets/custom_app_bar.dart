import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Widget? leading;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.backgroundColor,
    this.foregroundColor,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      leading: automaticallyImplyLeading
          ? (leading ??
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => _handleBackNavigation(context),
              ))
          : leading,
      actions: actions,
    );
  }

  void _handleBackNavigation(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/');
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// Specialized AppBar for management screens
class ManagementAppBar extends CustomAppBar {
  final VoidCallback? onRefresh;
  final List<Widget>? additionalActions;

  const ManagementAppBar({
    super.key,
    required super.title,
    this.onRefresh,
    this.additionalActions,
    super.backgroundColor,
    super.foregroundColor,
  });

  @override
  List<Widget>? get actions {
    final List<Widget> actionsList = [];
    
    if (onRefresh != null) {
      actionsList.add(
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: onRefresh,
          tooltip: '새로고침',
        ),
      );
    }

    if (additionalActions != null) {
      actionsList.addAll(additionalActions!);
    }

    return actionsList.isNotEmpty ? actionsList : null;
  }
}
