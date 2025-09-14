import 'package:flutter/material.dart';
import 'legend_item.dart';        // for _buildLegendItem
import 'dart:math' as math; // for _PieChartPainter

Widget reportsCard() => Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Karma Distribution",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: CustomPaint(
                    painter: const _PieChartPainter(),
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildLegendItem(
                      const Color(0xFF90CAF9),
                      "General\nEnablement",
                    ),
                    const SizedBox(height: 8),
                    buildLegendItem(
                      const Color(0xFF42A5F5),
                      "Collaboration",
                    ),
                    const SizedBox(height: 8),
                    buildLegendItem(
                      const Color(0xFF1E88E5),
                      "Profile Building",
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
class _PieChartPainter extends CustomPainter {
  const _PieChartPainter();

  @override
  void paint(Canvas canvas, Size size) {
    double radius = 1;
    radius = math.min(size.width / 2, size.height / 2);
    Offset center = Offset(size.width / 2, size.height / 2);

    // Hardcoded angles for the segments (94.6%, Collaboration, Profile Building)
    const double generalEnablementAngle = 0.946 * 2 * math.pi;
    const double collaborationAngle = 0.03 * 2 * math.pi;
    const double profileBuildingAngle = 0.024 * 2 * math.pi;

    // Draw slices
    _drawSlice(
      canvas,
      center,
      radius,
      0,
      generalEnablementAngle,
      const Color(0xFF90CAF9),
    );
    _drawSlice(
      canvas,
      center,
      radius,
      generalEnablementAngle,
      collaborationAngle,
      const Color(0xFF42A5F5),
    );
    _drawSlice(
      canvas,
      center,
      radius,
      generalEnablementAngle + collaborationAngle,
      profileBuildingAngle,
      const Color(0xFF1E88E5),
    );

    // Draw the percentage text for the largest segment
    const double textRadius = 0.7 * 1;
    Offset textCenter = Offset(
      center.dx +
          textRadius * math.cos(generalEnablementAngle / 2 - math.pi / 2),
      center.dy +
          textRadius * math.sin(generalEnablementAngle / 2 - math.pi / 2),
    );

    final textPainter = TextPainter(
      text: const TextSpan(
        text: '94.6%',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      textCenter - Offset(textPainter.width / 2, textPainter.height / 2),
    );
  }

  void _drawSlice(
    Canvas canvas,
    Offset center,
    double radius,
    double startAngle,
    double sweepAngle,
    Color color,
  ) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      true,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
