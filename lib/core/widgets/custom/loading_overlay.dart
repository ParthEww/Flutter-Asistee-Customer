
import 'package:flutter/material.dart';

class LoadingOverlay {
  static OverlayEntry? _overlayEntry;

  static void _show(BuildContext context) {
    if (_overlayEntry != null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned.fill(
        child: Container(
          color: Colors.black54,
          child: const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  static void _hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  static LoadingOverlay of(BuildContext context) {
    return LoadingOverlay();
  }

  void show(BuildContext context) {
    LoadingOverlay._show(context);
  }

  void hide() {
    LoadingOverlay._hide();
  }
}