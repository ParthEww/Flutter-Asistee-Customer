import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_yay_rider_driver/core/widgets/custom/custom_circle_icon.dart';

import '../../../gen/assets.gen.dart';
import '../../themes/app_colors.dart';
import '../../themes/text_styles.dart';

/// Enum defining the shape type for the image in [CustomImageWithText].
enum ImageShapeType {
  /// Standard rectangular/square image
  normal,

  /// Circular image with optional padding and background color
  circle,
}

/// A widget that combines an image with adjacent text in a row layout.
/// Supports both normal and circular image shapes with customizable styling.
class CustomImageWithText extends StatelessWidget {
  /// The type of shape for the image (normal or circular)
  final ImageShapeType imageShapeType;

  /// Asset path for the image
  final String imagePath;

  /// Padding applied around the circular image (only used when [imageShapeType] is [ImageShapeType.circle])
  final EdgeInsetsGeometry circleImagePadding;

  /// Background color for circular image (only used when [imageShapeType] is [ImageShapeType.circle])
  final Color circleImageBackgroundColor;

  /// How the image should be inscribed into its container
  final BoxFit imageFit;

  /// Spacing between the image and text
  final double spacing;

  /// The text to display
  final String text;

  /// Style for the text
  final TextStyle textStyle;

  /// Callback when the widget is tapped
  final VoidCallback onTap;

  /// Creates an image with adjacent text widget
  const CustomImageWithText({
    super.key,
    required this.imageShapeType,
    required this.imagePath,
    this.circleImagePadding = const EdgeInsets.all(2),
    this.circleImageBackgroundColor = AppColors.primary,
    this.imageFit = BoxFit.contain,
    required this.spacing,
    required this.text,
    required this.textStyle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildImageWidget(),
        SizedBox(width: spacing),
        Text(text, style: textStyle),
      ],
    );
  }

  Widget _buildImageWidget() {
    return imageShapeType == ImageShapeType.circle
        ? CustomCircleIcon(
      iconPath: imagePath,
      padding: circleImagePadding,
      backgroundColor: circleImageBackgroundColor,
    )
        : Image.asset(
      imagePath,
      fit: imageFit,
    );
  }
}
