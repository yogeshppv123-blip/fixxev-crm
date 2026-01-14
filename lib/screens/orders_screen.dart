import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../widgets/sidebar.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/responsive.dart';


class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    final bool isMobile = Responsive.isMobile(context);

    return Scaffold(
      drawer: !isDesktop
          ? const Drawer(child: Sidebar(activePage: 'Orders', isDrawer: true))
          : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isDesktop)
            const SizedBox(width: 250, child: Sidebar(activePage: 'Orders')),
          Expanded(
            child: Container(
              color: AppColors.mainBackground,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(isMobile ? 16 : 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const DashboardHeader(),
                    const SizedBox(height: 32),
                    if (isMobile)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Recent Orders',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textBlack,
                                ),
                          ),
                          const SizedBox(height: 16),
                          _buildDateRangePicker(),
                        ],
                      )
                    else
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recent Orders',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textBlack,
                                ),
                          ),
                          _buildDateRangePicker(),
                        ],
                      ),
                    const SizedBox(height: 24),
                    const _OrderStatsRow(),
                    const SizedBox(height: 32),
                    _buildOrdersTable(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateRangePicker() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: const Row(
        children: [
          Icon(Icons.calendar_today, size: 16, color: AppColors.textGray),
          SizedBox(width: 8),
          Text('Jan 1, 2026 - Jan 13, 2026', style: TextStyle(fontSize: 13, color: AppColors.textBlack)),
          SizedBox(width: 8),
          Icon(Icons.keyboard_arrow_down, size: 16, color: AppColors.textGray),
        ],
      ),
    );
  }

  Widget _buildOrdersTable() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('All Orders', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 800, // Minimum width for the table
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(1.5),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(1.5),
                  3: FlexColumnWidth(1),
                  4: FlexColumnWidth(1.5),
                  5: FixedColumnWidth(80),
                },
                children: [
                  _buildTableHeader(),
                  ...orderData.map((order) => _buildOrderRow(order)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TableRow _buildTableHeader() {
    return const TableRow(
      children: [
        Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Text('Order ID', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textGray))),
        Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Text('Customer', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textGray))),
        Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Text('Date', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textGray))),
        Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Text('Amount', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textGray))),
        Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textGray))),
        Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Text('Action', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textGray))),
      ],
    );
  }

  TableRow _buildOrderRow(Map<String, dynamic> order) {
    return TableRow(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey[50]!))),
      children: [
        Padding(padding: const EdgeInsets.symmetric(vertical: 20), child: Text(order['id'], style: const TextStyle(fontWeight: FontWeight.bold))),
        Padding(padding: const EdgeInsets.symmetric(vertical: 20), child: Text(order['customer'])),
        Padding(padding: const EdgeInsets.symmetric(vertical: 20), child: Text(order['date'])),
        Padding(padding: const EdgeInsets.symmetric(vertical: 20), child: Text(order['amount'])),
        Padding(padding: const EdgeInsets.symmetric(vertical: 20), child: _StatusChip(status: order['status'])),
        Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: IconButton(onPressed: () {}, icon: const Icon(Icons.receipt_long, size: 20, color: AppColors.primary))),
      ],
    );
  }
}

class _OrderStatsRow extends StatelessWidget {
  const _OrderStatsRow();
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
          childAspectRatio: (crossAxisCount == 1) ? 3.5 : 2.5,
          children: const [
            _StatBox(label: 'Total Orders', value: '1,420', icon: Icons.shopping_basket, color: Colors.blue),
            _StatBox(label: 'Processing', value: '45', icon: Icons.sync, color: Colors.orange),
            _StatBox(label: 'Shipped', value: '1,280', icon: Icons.local_shipping, color: Colors.green),
            _StatBox(label: 'Cancelled', value: '12', icon: Icons.cancel, color: Colors.red),
          ],
        );
      }
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  const _StatBox({required this.label, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(label, style: const TextStyle(color: AppColors.textGray, fontSize: 11)),
                Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String status;
  const _StatusChip({required this.status});
  @override
  Widget build(BuildContext context) {
    Color color = Colors.grey;
    if (status == 'Delivered') color = Colors.green;
    else if (status == 'Processing') color = Colors.orange;
    else if (status == 'Pending') color = Colors.blue;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)),
      child: Text(status, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold)),
    );
  }
}

final List<Map<String, dynamic>> orderData = [
  {'id': '#ORD-8821', 'customer': 'John Doe', 'date': 'Jan 13, 2026', 'amount': '\$156.00', 'status': 'Processing'},
  {'id': '#ORD-8820', 'customer': 'Sarah Smith', 'date': 'Jan 12, 2026', 'amount': '\$1,240.00', 'status': 'Delivered'},
  {'id': '#ORD-8819', 'customer': 'Mike Ross', 'date': 'Jan 12, 2026', 'amount': '\$85.00', 'status': 'Delivered'},
  {'id': '#ORD-8818', 'customer': 'Emma Watson', 'date': 'Jan 11, 2026', 'amount': '\$420.00', 'status': 'Pending'},
  {'id': '#ORD-8817', 'customer': 'Harvey Specter', 'date': 'Jan 10, 2026', 'amount': '\$2,500.00', 'status': 'Delivered'},
];
