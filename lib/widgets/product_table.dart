import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../widgets/responsive.dart';


class ProductTable extends StatelessWidget {
  const ProductTable({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool useVerticalLayout = isMobile || constraints.maxWidth < 600;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (useVerticalLayout)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Product', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 16),
                    _buildSearchField(double.infinity),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildFilterButton('Sort by:', 'Best Seller'),
                        _buildFilterButton('All Categories', null),
                      ],
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    const Text('Product', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const Spacer(),
                    _buildSearchField(180),
                    const SizedBox(width: 8),
                    _buildFilterButton('Sort by:', 'Best Seller'),
                    const SizedBox(width: 8),
                    _buildFilterButton('All Categories', null),
                  ],
                ),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: 800, // Minimum width for the table to prevent squishing
                  child: Table(
                    columnWidths: const {
                      0: FixedColumnWidth(40),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(2),
                      3: FlexColumnWidth(3),
                      4: FlexColumnWidth(1.5),
                      5: FlexColumnWidth(1.5),
                      6: FlexColumnWidth(1.5),
                      7: FixedColumnWidth(60),
                    },
                    children: [
                      _buildTableHeader(),
                      _buildProductRow('1', 'Silk Blend Summer Dress', '\$120.00', '75', 'In Stock'),
                      _buildProductRow('2', 'High-Waist Denim Jeans', '\$85.00', '50', 'Limited'),
                      _buildProductRow('3', 'Women\'s Wool Cardigan', '\$150.00', '40', 'In Stock'),
                      _buildProductRow('4', 'Kids\' Graphic Sweatshirt', '\$45.00', '60', 'In Stock'),
                      _buildProductRow('5', 'Waterproof Ankle Boots', '\$210.00', '25', 'Low Stock'),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSearchField(double width) {
    return SizedBox(
      width: width,
      height: 36,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search product, etc',
          prefixIcon: const Icon(Icons.search, size: 16),
          filled: true,
          fillColor: AppColors.mainBackground,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }

  Widget _buildFilterButton(String label, String? value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text('$label ${value ?? ''}', style: const TextStyle(fontSize: 12, color: AppColors.textGray)),
          const Icon(Icons.keyboard_arrow_down, size: 16, color: AppColors.textGray),
        ],
      ),
    );
  }

  TableRow _buildTableHeader() {
    return TableRow(
      children: [
        '#', 'Image', 'Product ID', 'Product Name', 'Price', 'Qty', 'Status', 'Action'
      ].map((text) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.textGray)),
      )).toList(),
    );
  }

  TableRow _buildProductRow(String index, String name, String price, String qty, String status) {
    return TableRow(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey[100]!))),
      children: [
        _buildCell(Text(index)),
        _buildCell(Container(width: 30, height: 30, decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(4)))),
        _buildCell(Text('PRD-00$index')),
        _buildCell(Text(name, style: const TextStyle(fontWeight: FontWeight.bold))),
        _buildCell(Text(price)),
        _buildCell(Text(qty)),
        _buildCell(_buildStatusChip(status)),
        _buildCell(const Icon(Icons.more_horiz, size: 18, color: AppColors.textGray)),
      ],
    );
  }

  Widget _buildCell(Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: child,
    );
  }

  Widget _buildStatusChip(String status) {
    return Text(status, style: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w600,
      color: status == 'In Stock' ? AppColors.secondary : (status == 'Limited' ? Colors.orange : Colors.red),
    ));
  }
}
