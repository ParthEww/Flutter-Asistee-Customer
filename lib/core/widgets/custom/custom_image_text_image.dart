import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_structure/core/widgets/custom/custom_circle_icon.dart';

import '../../../gen/assets.gen.dart';
import '../../themes/app_colors.dart';
import '../../themes/text_styles.dart';
import 'custom_image_with_text.dart';

/// A button widget that displays two images with text in between,
/// supporting different shape types for each image.
class CustomImageTextImageButton extends StatelessWidget {
  /// Shape type for the leading image
  final ImageShapeType leadingImageShape;

  /// Asset path for the leading image
  final String leadingImagePath;

  /// Padding for the leading circular image
  final EdgeInsetsGeometry leadingImagePadding;

  /// Background color for the leading circular image
  final Color leadingImageBackgroundColor;

  /// How the leading image should fit in its space
  final BoxFit leadingImageFit;

  /// Spacing between the leading image and text
  final double leadingSpacing;

  /// The text to display between images
  final String text;

  /// Style for the text
  final TextStyle textStyle;

  /// Shape type for the trailing image
  final ImageShapeType trailingImageShape;

  /// Asset path for the trailing image
  final String trailingImagePath;

  /// Padding for the trailing circular image
  final EdgeInsetsGeometry trailingImagePadding;

  /// Background color for the trailing circular image
  final Color trailingImageBackgroundColor;

  /// How the trailing image should fit in its space
  final BoxFit trailingImageFit;

  /// Creates a button with two images and centered text
  const CustomImageTextImageButton({
    super.key,
    required this.leadingImageShape,
    required this.leadingImagePath,
    this.leadingImagePadding = const EdgeInsets.all(2),
    this.leadingImageBackgroundColor = AppColors.primary,
    this.leadingImageFit = BoxFit.contain,
    required this.leadingSpacing,
    required this.text,
    required this.textStyle,
    required this.trailingImageShape,
    required this.trailingImagePath,
    this.trailingImagePadding = const EdgeInsets.all(2),
    this.trailingImageBackgroundColor = AppColors.primary,
    this.trailingImageFit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildImageWidget(
          shape: leadingImageShape,
          path: leadingImagePath,
          padding: leadingImagePadding,
          backgroundColor: leadingImageBackgroundColor,
          fit: leadingImageFit,
        ),
        SizedBox(width: leadingSpacing),
        Expanded(
          child: Text(
            text,
            style: textStyle,
            textAlign: TextAlign.center,
          ),
        ),
        _buildImageWidget(
          shape: trailingImageShape,
          path: trailingImagePath,
          padding: trailingImagePadding,
          backgroundColor: trailingImageBackgroundColor,
          fit: trailingImageFit,
        ),
      ],
    );
  }

  Widget _buildImageWidget({
    required ImageShapeType shape,
    required String path,
    required EdgeInsetsGeometry padding,
    required Color backgroundColor,
    required BoxFit fit,
  }) {
    return shape == ImageShapeType.circle
        ? CustomCircleIcon(
      iconPath: path,
      padding: padding,
      backgroundColor: backgroundColor,
    )
        : SvgPicture.asset(
      path,
      fit: fit,
    );
  }
}
