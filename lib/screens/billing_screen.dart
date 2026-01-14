import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../widgets/sidebar.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/responsive.dart';


class BillingScreen extends StatelessWidget {
  const BillingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    final bool isMobile = Responsive.isMobile(context);

    return Scaffold(
      drawer: !isDesktop
          ? const Drawer(child: Sidebar(activePage: 'Billing', isDrawer: true))
          : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isDesktop)
            const SizedBox(width: 250, child: Sidebar(activePage: 'Billing')),
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
                            'Billing & Invoices',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textBlack,
                                ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.download, color: Colors.white),
                              label: const Text('Export All', style: TextStyle(color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                          ),
                        ],
                      )
                    else
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Billing & Invoices',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textBlack,
                                ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.download, color: Colors.white),
                            label: const Text('Export All', style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 24),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        int crossAxisCount = 3;
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
                            _BillingStat(title: 'Total Revenue', value: '\$1,000,000', change: '+12%', isPositive: true),
                            _BillingStat(title: 'Outstanding', value: '\$45,200', change: '-4%', isPositive: false),
                            _BillingStat(title: 'Paid Invoices', value: '1,284', change: '+8%', isPositive: true),
                          ],
                        );
                      }
                    ),
                    const SizedBox(height: 32),
                    _buildInvoicesTable(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvoicesTable() {
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
          const Text('Recent Invoices', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 800, // Minimum width for the table
              child: Table(
                columnWidths: const {
                  0: FixedColumnWidth(100),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(1.5),
                  3: FlexColumnWidth(1.5),
                  4: FixedColumnWidth(100),
                },
                children: [
                  _buildTableHeader(),
                  ...invoiceData.map((data) => _buildInvoiceRow(data)),
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
        Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Text('Invoice #', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textGray))),
        Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Text('Client/Supplier', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textGray))),
        Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Text('Date', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textGray))),
        Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Text('Amount', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textGray))),
        Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Text('Action', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textGray))),
      ],
    );
  }

  TableRow _buildInvoiceRow(Map<String, dynamic> data) {
    return TableRow(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey[50]!))),
      children: [
        Padding(padding: const EdgeInsets.symmetric(vertical: 20), child: Text(data['id'], style: const TextStyle(fontWeight: FontWeight.bold))),
        Padding(padding: const EdgeInsets.symmetric(vertical: 20), child: Text(data['client'])),
        Padding(padding: const EdgeInsets.symmetric(vertical: 20), child: Text(data['date'])),
        Padding(padding: const EdgeInsets.symmetric(vertical: 20), child: Text(data['amount'])),
        Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: IconButton(onPressed: () {}, icon: const Icon(Icons.visibility_outlined, size: 20, color: AppColors.primary))),
      ],
    );
  }
}

class _BillingStat extends StatelessWidget {
  final String title;
  final String value;
  final String change;
  final bool isPositive;
  const _BillingStat({required this.title, required this.value, required this.change, required this.isPositive});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(color: AppColors.textGray, fontSize: 11)),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: (isPositive ? Colors.green : Colors.red).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(change, style: TextStyle(color: isPositive ? Colors.green : Colors.red, fontSize: 9, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

final List<Map<String, dynamic>> invoiceData = [
  {'id': 'INV-901', 'client': 'Global Textiles Inc.', 'date': 'Jan 10, 2026', 'amount': '\$4,500.00'},
  {'id': 'INV-902', 'client': 'Elite Leather & Co', 'date': 'Jan 08, 2026', 'amount': '\$1,200.00'},
  {'id': 'INV-903', 'client': 'Amazon AWS', 'date': 'Jan 05, 2026', 'amount': '\$85.00'},
  {'id': 'INV-904', 'client': 'Office Depot', 'date': 'Jan 02, 2026', 'amount': '\$320.00'},
];
