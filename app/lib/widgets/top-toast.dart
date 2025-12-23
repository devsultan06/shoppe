import 'package:flutter/material.dart';

enum ToastType { success, error }

class TopToast {
  static void show(
    BuildContext context, {
    required String message,
    ToastType type = ToastType.success,
    Duration duration = const Duration(seconds: 3),
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;
    bool isRemoved = false;

    void removeToast() {
      if (!isRemoved) {
        isRemoved = true;
        overlayEntry.remove();
      }
    }

    overlayEntry = OverlayEntry(
      builder: (_) {
        return _TopToastWidget(
          message: message,
          type: type,
          onDismissed: removeToast,
        );
      },
    );

    overlay.insert(overlayEntry);
    Future.delayed(duration, removeToast);
  }
}

class _TopToastWidget extends StatefulWidget {
  final String message;
  final ToastType type;
  final VoidCallback onDismissed;

  const _TopToastWidget({
    required this.message,
    required this.type,
    required this.onDismissed,
  });

  @override
  State<_TopToastWidget> createState() => _TopToastWidgetState();
}

class _TopToastWidgetState extends State<_TopToastWidget> {
  Offset _offset = const Offset(0, -1);
  double _opacity = 0;

  @override
  void initState() {
    super.initState();

    // Trigger animation after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _offset = const Offset(0, 0);
        _opacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isError = widget.type == ToastType.error;

    return Positioned(
      top: MediaQuery.of(context).padding.top + 12,
      left: 16,
      right: 16,
      child: Material(
        color: Colors.transparent,
        child: AnimatedSlide(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          offset: _offset,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: _opacity,
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isError ? Colors.red : Colors.green,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    isError ? Icons.error_outline : Icons.check_circle_outline,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.message,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onDismissed,
                    child: const Icon(
                      Icons.close,
                      color: Colors.white70,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
