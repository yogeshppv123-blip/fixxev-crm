import 'package:flutter/material.dart';
import '../constants/colors.dart';

class RightPanel extends StatelessWidget {
  final bool isEmbedded;
  const RightPanel({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.mainBackground,
        border: isEmbedded ? null : const Border(left: BorderSide(color: Color(0xFFE0E0E0))),
      ),
      child: ListView(
        shrinkWrap: isEmbedded,
        physics: isEmbedded ? const NeverScrollableScrollPhysics() : null,
        padding: const EdgeInsets.all(24),
        children: [
          const Text('Traffic Source', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 20),
          _buildTrafficItem('Amazon', '27%', Colors.amber, [2, 5, 3, 7, 4]),
          _buildTrafficItem('Ebay', '23%', Colors.blue, [7, 6, 4, 3, 2]),
          _buildTrafficItem('Aliexpress', '18%', Colors.orange, [4, 4, 5, 4, 4]),
          _buildTrafficItem('Etsy', '10%', Colors.deepOrange, [2, 3, 5, 4, 6]),
          _buildTrafficItem('Walmart', '8%', Colors.blueAccent, [8, 7, 5, 4, 2]),
          const SizedBox(height: 40),
          const Text('Recent Activity', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 8),
          const Text('Today', style: TextStyle(color: AppColors.textGray, fontSize: 12)),
          const SizedBox(height: 16),
          _buildActivityItem('Mario', 'processed a return for a T-Shirt, adjusting the inventory.', '3:45 PM'),
          _buildActivityItem('Emily Chen', 'updated High-Waist Denim Jeans quantity for sales/returns.', '2:30 PM'),
          _buildActivityItem('John Kramer', 'added Men\'s Summer Jacket to inventory for upcoming...', '11:15 AM'),
        ],
      ),
    );
  }

  Widget _buildTrafficItem(String name, String percentage, Color color, List<double> sparkData) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                const SizedBox(height: 4),
                Text(percentage, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                Text('Last week: 25%', style: TextStyle(color: AppColors.textGray.withValues(alpha: 0.6), fontSize: 10)),
              ],
            ),
          ),
          SizedBox(
            width: 80,
            height: 40,
            child: CustomPaint(
              painter: SparklinePainter(sparkData, color),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(String user, String description, String time) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(radius: 16, backgroundColor: Colors.grey[200], child: const Icon(Icons.person, size: 16)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(color: AppColors.textBlack, fontSize: 12),
                    children: [
                      TextSpan(text: '$user ', style: const TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: description, style: const TextStyle(color: AppColors.textGray)),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(time, style: const TextStyle(color: AppColors.textGray, fontSize: 10)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SparklinePainter extends CustomPainter {
  final List<double> data;
  final Color color;

  SparklinePainter(this.data, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final double dx = size.width / (data.length - 1);
    final double maxVal = data.reduce((a, b) => a > b ? a : b);
    
    for (int i = 0; i < data.length; i++) {
      final x = i * dx;
      final y = size.height - (data[i] / maxVal * size.height);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
