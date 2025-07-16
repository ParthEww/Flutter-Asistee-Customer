import 'package:flutter/material.dart';

class AppStyledCurrencyText extends StatelessWidget {
  final String text;
  final TextStyle defaultStyle;
  final TextStyle currencyStyle;

  const AppStyledCurrencyText({
    super.key,
    required this.text,
    required this.defaultStyle,
    required this.currencyStyle,
  });

  @override
  Widget build(BuildContext context) {
    // Regex to match currency patterns like "BHD 10.00", "USD 5.50"
    final RegExp currencyRegex = RegExp(r'([A-Z]{3}\s\d+\.\d{2})');
    final matches = currencyRegex.allMatches(text);
    final List<TextSpan> spans = [];
    int lastEnd = 0;

    for (final match in matches) {
      // Add text before the matched currency
      spans.add(TextSpan(
        text: text.substring(lastEnd, match.start),
        style: defaultStyle,
      ));

      // Add styled currency text
      spans.add(TextSpan(
        text: match.group(0),
        style: currencyStyle,
      ));

      lastEnd = match.end;
    }

    // Add remaining text after last match
    spans.add(TextSpan(
      text: text.substring(lastEnd),
      style: defaultStyle,
    ));

    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        style: defaultStyle,
        children: spans,
      ),
    );
  }
}
