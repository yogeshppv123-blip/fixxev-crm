import 'package:flutter/material.dart';
import '../constants/colors.dart';

import '../widgets/responsive.dart';

class StatSection extends StatelessWidget {
  const StatSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = 4;
        if (constraints.maxWidth < 600) {
          crossAxisCount = 1;
        } else if (constraints.maxWidth < 1100) {
          crossAxisCount = 2;
        }

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: crossAxisCount == 1 ? 2.5 : 1.8,
          children: const [
            StatCard(
              title: 'Total Products',
              value: '4,892',
              percentage: '+0.51%',
              isPositive: true,
              backgroundColor: AppColors.primary,
              isFilled: true,
            ),
            StatCard(
              title: 'Available Stock',
              value: '2,137',
              percentage: '-4.24%',
              isPositive: false,
              backgroundColor: AppColors.secondary,
              isFilled: true,
            ),
            StatCard(
              title: 'Low Stock',
              value: '1,952',
              percentage: '+1.51%',
              isPositive: true,
              backgroundColor: AppColors.accent,
              isFilled: true,
            ),
            StatCard(
              title: 'Out of Stock',
              value: '803',
              percentage: '-1.95%',
              isPositive: false,
              backgroundColor: AppColors.error,
              isFilled: true,
            ),
          ],
        );
      },
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String percentage;
  final bool isPositive;
  final Color? backgroundColor;
  final bool isFilled;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.percentage,
    required this.isPositive,
    this.backgroundColor,
    this.isFilled = false,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? AppColors.cardBackground;
    final contentColor = isFilled ? Colors.white : AppColors.textBlack;
    final labelColor = isFilled ? Colors.white.withValues(alpha: 0.8) : AppColors.textGray;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: isFilled
            ? [
                BoxShadow(
                  color: bgColor.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ]
            : [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: labelColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(Icons.more_horiz, color: labelColor, size: 18),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: contentColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    percentage,
                    style: TextStyle(
                      color: isFilled
                          ? Colors.white
                          : (isPositive ? Colors.green : Colors.red),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'from last week',
                    style: TextStyle(
                      color: labelColor,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
