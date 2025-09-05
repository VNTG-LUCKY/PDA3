import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonStyle? style;
  final Widget? icon;
  final bool isLoading;
  final bool isDisabled;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.style,
    this.icon,
    this.isLoading = false,
    this.isDisabled = false,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final ButtonStyle buttonStyle = style ?? ElevatedButton.styleFrom(
      backgroundColor: backgroundColor ?? colorScheme.primary,
      foregroundColor: textColor ?? colorScheme.onPrimary,
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 2,
      disabledBackgroundColor: colorScheme.surfaceVariant,
      disabledForegroundColor: colorScheme.onSurfaceVariant,
    );

    Widget child;

    if (isLoading) {
      child = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                textColor ?? colorScheme.onPrimary,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(text),
        ],
      );
    } else if (icon != null) {
      child = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon!,
          const SizedBox(width: 8),
          Text(text),
        ],
      );
    } else {
      child = Text(text);
    }

    final button = ElevatedButton(
      onPressed: (isLoading || isDisabled) ? null : onPressed,
      style: buttonStyle,
      child: child,
    );

    if (width != null || height != null) {
      return SizedBox(
        width: width,
        height: height,
        child: button,
      );
    }

    return button;
  }
}

// Specialized button variants
class PrimaryButton extends CustomButton {
  const PrimaryButton({
    super.key,
    required super.text,
    required super.onPressed,
    super.icon,
    super.isLoading,
    super.isDisabled,
    super.width,
    super.height,
    super.padding,
  });
}

class SecondaryButton extends CustomButton {
  const SecondaryButton({
    super.key,
    required super.text,
    required super.onPressed,
    super.icon,
    super.isLoading,
    super.isDisabled,
    super.width,
    super.height,
    super.padding,
  }) : super(
    style: const ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(Colors.transparent),
      side: MaterialStatePropertyAll(BorderSide(color: Colors.grey)),
    ),
  );
}

class DangerButton extends CustomButton {
  const DangerButton({
    super.key,
    required super.text,
    required super.onPressed,
    super.icon,
    super.isLoading,
    super.isDisabled,
    super.width,
    super.height,
    super.padding,
  }) : super(
    backgroundColor: Colors.red,
    textColor: Colors.white,
  );
}

class SuccessButton extends CustomButton {
  const SuccessButton({
    super.key,
    required super.text,
    required super.onPressed,
    super.icon,
    super.isLoading,
    super.isDisabled,
    super.width,
    super.height,
    super.padding,
  }) : super(
    backgroundColor: Colors.green,
    textColor: Colors.white,
  );
}

// Icon button variants
class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String? tooltip;
  final Color? color;
  final double? size;
  final bool isDisabled;

  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
    this.color,
    this.size,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: isDisabled ? null : onPressed,
      icon: Icon(icon),
      tooltip: tooltip,
      color: color,
      iconSize: size,
    );
  }
}
