import 'package:flutter/material.dart';
import '../constants/colors.dart';

class RestockSection extends StatelessWidget {
  const RestockSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
                  const Text('Stock Level', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  _buildSmallDropdown('Fashion'),
                ],
              ),
              const SizedBox(height: 16),
              const Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total Stock', style: TextStyle(color: AppColors.textGray, fontSize: 12)),
                      Text('225/370', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  ),
                  Spacer(),
                  _StatusChip(label: 'Sufficient', color: Colors.black),
                ],
              ),
              const SizedBox(height: 20),
              _buildProgressItem('Silk Blend Summer Dress', 75, 110),
              _buildProgressItem('High-Waist Denim Jeans', 50, 80),
              _buildProgressItem('Women\'s Wool Cardigan', 40, 80),
              _buildProgressItem('Kids\' Graphic Sweatshirt', 60, 100),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Container(
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
                  const Text('Upcoming Restock', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  TextButton(onPressed: () {}, child: const Text('View All (38)', style: TextStyle(fontSize: 12, color: AppColors.textGray))),
                ],
              ),
              const SizedBox(height: 16),
              _buildRestockItem('Waterproof Ankle Boots', '50 Pcs', 'April 25, 2029'),
              _buildRestockItem('Vegan Leather Tote Bag', '40 Pcs', 'April 30, 2029'),
              _buildRestockItem('Men\'s Running Sneakers', '30 Pcs', 'May 5, 2029'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSmallDropdown(String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Text(value, style: const TextStyle(fontSize: 10, color: AppColors.textGray)),
          const Icon(Icons.keyboard_arrow_down, size: 14, color: AppColors.textGray),
        ],
      ),
    );
  }

  Widget _buildProgressItem(String title, double current, double total) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 12, color: AppColors.textGray),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Text('${current.toInt()} of ${total.toInt()} remaining', style: const TextStyle(fontSize: 10, color: AppColors.textGray)),
            ],
          ),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: current / total,
            backgroundColor: Colors.grey[100],
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.secondary),
            minHeight: 6,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  Widget _buildRestockItem(String title, String qty, String date) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.inventory_2_outlined, size: 20, color: AppColors.textGray),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13), overflow: TextOverflow.ellipsis),
                if (date.isNotEmpty)
                  Text(date, style: const TextStyle(color: AppColors.textGray, fontSize: 10)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(qty, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }
}
