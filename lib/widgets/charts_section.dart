import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../constants/colors.dart';

import '../widgets/responsive.dart';

class ChartsSection extends StatelessWidget {
  const ChartsSection({super.key});

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return const Column(
        children: [
          ProfitByCategoryChart(),
          SizedBox(height: 24),
          OrderSummaryChart(),
        ],
      );
    }
    
    return const Row(
      children: [
        Expanded(flex: 2, child: ProfitByCategoryChart()),
        SizedBox(width: 24),
        Expanded(flex: 3, child: OrderSummaryChart()),
      ],
    );
  }
}

class ProfitByCategoryChart extends StatelessWidget {
  const ProfitByCategoryChart({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isNarrow = constraints.maxWidth < 500;
        final bool isMobile = Responsive.isMobile(context);

        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      'Profit by Category',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.textBlack,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  DropdownButton<String>(
                    value: 'This Year',
                    underline: const SizedBox(),
                    style: const TextStyle(color: AppColors.textGray, fontSize: 12),
                    icon: const Icon(Icons.keyboard_arrow_down, size: 16),
                    items: ['This Year', 'This Month'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (_) {},
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (isNarrow || isMobile)
                Column(
                  children: [
                    _buildPieChart(),
                    const SizedBox(height: 32),
                    _buildLegend(context),
                  ],
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPieChart(),
                    const SizedBox(width: 24),
                    Expanded(child: _buildLegend(context)),
                  ],
                ),
            ],
          ),
        );
      }
    );
  }

  Widget _buildPieChart() {
    return Center(
      child: SizedBox(
        height: 180,
        width: 180,
        child: PieChart(
          PieChartData(
            sectionsSpace: 0,
            centerSpaceRadius: 60,
            sections: [
              PieChartSectionData(
                  color: AppColors.secondary, value: 40, radius: 25, showTitle: false),
              PieChartSectionData(
                  color: AppColors.primary, value: 25, radius: 25, showTitle: false),
              PieChartSectionData(
                  color: Colors.grey[400], value: 20, radius: 25, showTitle: false),
              PieChartSectionData(
                  color: Colors.grey[200], value: 15, radius: 25, showTitle: false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLegend(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Total Annual Profit', style: TextStyle(color: AppColors.textGray, fontSize: 12)),
        Text('\$1,000,000',
            style: TextStyle(
                color: AppColors.textBlack,
                fontSize: 22,
                fontWeight: FontWeight.bold)),
        SizedBox(height: 16),
        _CategoryLegend(color: AppColors.secondary, title: "Women's Clothing", percentage: "40%", value: "\$400,000"),
        _CategoryLegend(color: AppColors.primary, title: "Accessories", percentage: "25%", value: "\$250,000"),
        _CategoryLegend(color: Colors.grey, title: "Men's Clothing", percentage: "20%", value: "\$200,000"),
      ],
    );
  }
}

class OrderSummaryChart extends StatelessWidget {
  const OrderSummaryChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order Summary',
                    style: TextStyle(
                      color: AppColors.textBlack,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text('\$8,870', style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(width: 4),
                      Text('Total Profit', style: TextStyle(color: AppColors.textGray, fontSize: 12)),
                    ],
                  ),
                ],
              ),
              DropdownButton<String>(
                value: 'This Week',
                underline: const SizedBox(),
                style: const TextStyle(color: AppColors.textGray, fontSize: 12),
                icon: const Icon(Icons.keyboard_arrow_down, size: 16),
                items: ['This Week', 'Last Week'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (_) {},
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 180,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
                        if (value >= 0 && value < 7) {
                          return Text(days[value.toInt()], style: const TextStyle(color: Colors.grey, fontSize: 10));
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 3),
                      FlSpot(1, 1),
                      FlSpot(2, 4),
                      FlSpot(3, 2),
                      FlSpot(4, 5),
                      FlSpot(5, 3),
                      FlSpot(6, 4),
                    ],
                    isCurved: true,
                    color: AppColors.secondary,
                    barWidth: 3,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: AppColors.secondary.withValues(alpha: 0.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryLegend extends StatelessWidget {
  final Color color;
  final String title;
  final String percentage;
  final String value;

  const _CategoryLegend({
    required this.color,
    required this.title,
    required this.percentage,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 11, color: AppColors.textGray),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            percentage,
            style: const TextStyle(fontSize: 11, color: AppColors.textGray, fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 12),
          Text(
            value,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textBlack),
          ),
        ],
      ),
    );
  }
}
