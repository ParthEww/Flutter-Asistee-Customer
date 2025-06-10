import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCircleIcon extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final String iconPath;
  final VoidCallback? onPressed;

  const CustomCircleIcon({
    Key? key,
    required this.iconPath,
    this.padding = const EdgeInsets.all(14),
    this.backgroundColor = Colors.blue,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
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