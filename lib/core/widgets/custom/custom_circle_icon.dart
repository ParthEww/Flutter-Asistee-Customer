import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A circular icon widget with customizable padding, background color, and tap handler.
/// Supports SVG assets and provides a circular container with centered icon.
class CustomCircleIcon extends StatelessWidget {
  /// The SVG asset path for the icon
  final String iconPath;

  /// Padding around the icon within the circular container
  final EdgeInsetsGeometry padding;

  /// Background color of the circular container
  final Color backgroundColor;

  /// Optional tap callback handler
  final VoidCallback? onTap;

  /// Creates a circular icon widget
  const CustomCircleIcon({
    super.key,
    required this.iconPath,
    this.padding = const EdgeInsets.all(14),
    this.backgroundColor = Colors.blue,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          iconPath,
          fit: BoxFit.none,
        ),
      ),
    );
  }
}