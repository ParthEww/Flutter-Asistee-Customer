import 'package:flutter/material.dart';
import 'package:flutter_yay_rider_driver/core/themes/app_colors.dart';
import 'package:flutter_yay_rider_driver/core/themes/text_styles.dart';

// A custom time wheel picker widget that displays numbers in a scrollable wheel
class CustomTimeWheelPicker extends StatefulWidget {
  final WheelPickerType wheelPickerType;

  const CustomTimeWheelPicker({super.key, required this.wheelPickerType});

  @override
  _CustomTimeWheelPickerState createState() => _CustomTimeWheelPickerState();
}

class _CustomTimeWheelPickerState extends State<CustomTimeWheelPicker> {
  // Base list of numbers to display (1-12)
  late final List<dynamic> baseItems;

  // Extended list that repeats baseItems to simulate infinite scrolling
  late final List<dynamic> extendedItems;

  // Controller for the wheel scroll view
  late FixedExtentScrollController _controller;

  // Observable selected item index
  /*var selectedItem = 0.obs;*/

  // Factor to determine how many times to repeat the base items
  static const int repeatFactor = 1000;

  @override
  void initState() {
    super.initState();
    if (widget.wheelPickerType == WheelPickerType.HOUR) {
      baseItems = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
    } else if (widget.wheelPickerType == WheelPickerType.MINUTE) {
      baseItems = [0, 15, 30, 45];
    } else {
      baseItems = ["AM", "PM"];
    }
    if (widget.wheelPickerType == WheelPickerType.HOUR) {
      // Create an extended list by repeating the base items multiple times
      // This creates the illusion of infinite scrolling
      extendedItems = List.generate(
        baseItems.length * repeatFactor,
        (index) => baseItems[index % baseItems.length],
      );

      // Initialize scroll controller to start in the middle of the extended list
      // This allows equal scrolling in both directions
      _controller = FixedExtentScrollController(
        initialItem: extendedItems.length ~/ 2,
      );
      /*selectedItem.value = _controller.initialItem;*/
    } else {
      // Initialize scroll controller to start in the middle of the extended list
      // This allows equal scrolling in both directions
      _controller = FixedExtentScrollController(
        initialItem: baseItems.length ~/ 2,
      );
      /*selectedItem.value = _controller.initialItem;*/
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230, // Fixed height for the wheel picker
      child: ListWheelScrollView.useDelegate(
        controller: _controller,
        itemExtent: 50,
        // Height of each item in the wheel
        diameterRatio: 1.5,
        // Controls the curvature of the wheel
        perspective: 0.003,
        // 3D perspective effect
        physics: FixedExtentScrollPhysics(),
        // Physics for discrete item selection
        onSelectedItemChanged: (index) {
          // Update the selected item when wheel is scrolled
          /*selectedItem.value = index;*/
        },
        childDelegate: ListWheelChildBuilderDelegate(
          builder: (context, index) {
            // Return null for invalid indices
            late int itemLength;
            if (widget.wheelPickerType == WheelPickerType.HOUR) {
              itemLength = extendedItems.length;
            } else {
              itemLength = baseItems.length;
            }
            if (index < 0 || index >= itemLength) return null;

            // Build each item in the wheel
            return Center(
              child: /*Obx(() {
                return*/ Text(
                  _getDisplayText(widget.wheelPickerType == WheelPickerType.HOUR
                      ? extendedItems[index]
                      : baseItems[index]),
                  // Apply different styling for selected vs unselected items
                  style: /*selectedItem.value == index
                      ? TextStyles.text16SemiBold // Selected item style
                      :*/ TextStyles.text14Regular
                          .copyWith(color: Colors.grey), // Unselected style
                /*);
              }*/),
            );
          },
        ),
      ),
    );
  }

  String _getDisplayText(dynamic item) {
    if (widget.wheelPickerType == WheelPickerType.HOUR) {
      return "${item.toString()} : 00";
    } else if (widget.wheelPickerType == WheelPickerType.MINUTE) {
      return "00 : ${item.toString()}";
    } else {
      return item.toString();
    }
  }
}

enum WheelPickerType { HOUR, MINUTE, AM_PM }
