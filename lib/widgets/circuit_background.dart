import 'package:flutter/material.dart';
import 'dart:math';

class CircuitBackground extends StatefulWidget {
  const CircuitBackground({super.key});

  @override
  State<CircuitBackground> createState() => _CircuitBackgroundState();
}

class _CircuitBackgroundState extends State<CircuitBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: CircuitPainter(animation: _controller),
    );
  }
}

class CircuitPainter extends CustomPainter {
  final Animation<double> animation;

  CircuitPainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width == 0 || size.height == 0) return;

    final random = Random(42); // Fixed seed for stability
    final paint = Paint()
      ..color = const Color(0xFF00FFFF).withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final nodePaint = Paint()
      ..color = const Color(0xFF00FFFF).withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final pulsePaint = Paint()
      ..color = const Color(0xFF00FFFF).withOpacity(0.1 + (0.2 * animation.value))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    const gridSize = 60.0;
    final cols = (size.width / gridSize).ceil();
    final rows = (size.height / gridSize).ceil();

    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        // Deterministic generation
        if (random.nextDouble() > 0.6) {
          final x = i * gridSize + gridSize / 2;
          final y = j * gridSize + gridSize / 2;
          
          // Draw Node
          canvas.drawCircle(Offset(x, y), 2.5, nodePaint);

          // Draw Connections
          if (random.nextBool()) {
            // Horizontal connection
            final nextX = (i + 1) * gridSize + gridSize / 2;
            if (i < cols - 1) {
              canvas.drawLine(Offset(x, y), Offset(nextX, y), paint);
              // Occasional pulsing line
              if (random.nextDouble() > 0.9) {
                 canvas.drawLine(Offset(x, y), Offset(nextX, y), pulsePaint);
              }
            }
          } else {
            // Vertical connection
            final nextY = (j + 1) * gridSize + gridSize / 2;
            if (j < rows - 1) {
              canvas.drawLine(Offset(x, y), Offset(x, nextY), paint);
               if (random.nextDouble() > 0.9) {
                 canvas.drawLine(Offset(x, y), Offset(x, nextY), pulsePaint);
              }
            }
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CircuitPainter oldDelegate) {
    return true; // Repaint for animation
  }
}
