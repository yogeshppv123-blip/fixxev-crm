import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../widgets/sidebar.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/responsive.dart';


class DeliveryScreen extends StatelessWidget {
  const DeliveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    final bool isMobile = Responsive.isMobile(context);

    return Scaffold(
      drawer: !isDesktop
          ? const Drawer(child: Sidebar(activePage: 'Delivery', isDrawer: true))
          : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isDesktop)
            const SizedBox(width: 250, child: Sidebar(activePage: 'Delivery')),
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
                            'Delivery Tracking',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textBlack,
                                ),
                          ),
                          const SizedBox(height: 16),
                          _buildTrackingAction(context),
                        ],
                      )
                    else
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Delivery Tracking',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textBlack,
                                ),
                          ),
                          _buildTrackingAction(context),
                        ],
                      ),
                    const SizedBox(height: 24),
                    const _DeliveryStatsRow(),
                    const SizedBox(height: 32),
                    _buildActiveDeliveries(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackingAction(BuildContext context) {
    return Container(
      width: Responsive.isMobile(context) ? double.infinity : 300,
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          const Icon(Icons.qr_code_scanner, size: 20, color: AppColors.textGray),
          const SizedBox(width: 12),
          const Expanded(child: TextField(decoration: InputDecoration(hintText: 'Track ID...', border: InputBorder.none, hintStyle: TextStyle(fontSize: 14)))),
          Container(
            margin: const EdgeInsets.all(4),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              child: const Text('Track', style: TextStyle(color: Colors.white, fontSize: 13)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveDeliveries() {
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
          const Text('Active Shipments', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 20),
          ...deliveryData.map((data) => _DeliveryItem(data: data)),
        ],
      ),
    );
  }
}

class _DeliveryItem extends StatelessWidget {
  final Map<String, dynamic> data;
  const _DeliveryItem({required this.data});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.mainBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: isMobile 
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), shape: BoxShape.circle),
                      child: const Icon(Icons.local_shipping, color: AppColors.primary, size: 18),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data['id'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          Text(data['destination'], style: const TextStyle(color: AppColors.textGray, fontSize: 11)),
                        ],
                      ),
                    ),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.map_outlined, color: AppColors.textGray, size: 20)),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(data['status'], style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 11)),
                    Text('${data['progress']}%', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: data['progress'] / 100,
                    backgroundColor: Colors.grey[200],
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.secondary),
                    minHeight: 6,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Estimated Arrival', style: TextStyle(color: AppColors.textGray, fontSize: 11)),
                    Text(data['eta'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  ],
                ),
              ],
            )
          : Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), shape: BoxShape.circle),
                  child: const Icon(Icons.local_shipping, color: AppColors.primary, size: 20),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data['id'], style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(data['destination'], style: const TextStyle(color: AppColors.textGray, fontSize: 12)),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(data['status'], style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                          Text('${data['progress']}%', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: data['progress'] / 100,
                          backgroundColor: Colors.grey[200],
                          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.secondary),
                          minHeight: 6,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Estimated Arrival', style: TextStyle(color: AppColors.textGray, fontSize: 11)),
                    Text(data['eta'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  ],
                ),
                const SizedBox(width: 16),
                IconButton(onPressed: () {}, icon: const Icon(Icons.map_outlined, color: AppColors.textGray)),
              ],
            ),
    );
  }
}

class _DeliveryStatsRow extends StatelessWidget {
  const _DeliveryStatsRow();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = 3;
        if (constraints.maxWidth < 600) {
          crossAxisCount = 1;
        }

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: (crossAxisCount == 1) ? 2.5 : 2,
          children: const [
            _DeliveryStatBox(label: 'On Route', value: '24', icon: Icons.trending_up, color: Colors.blue),
            _DeliveryStatBox(label: 'Delayed', value: '2', icon: Icons.warning_amber, color: Colors.red),
            _DeliveryStatBox(label: 'Completed', value: '1,150', icon: Icons.check_circle, color: Colors.green),
          ],
        );
      }
    );
  }
}

class _DeliveryStatBox extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  const _DeliveryStatBox({required this.label, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          Text(label, style: const TextStyle(color: AppColors.textGray, fontSize: 12)),
        ],
      ),
    );
  }
}

final List<Map<String, dynamic>> deliveryData = [
  {'id': 'SHP-1012', 'destination': 'San Francisco, CA', 'status': 'In Transit', 'progress': 65, 'eta': 'Today, 4:00 PM'},
  {'id': 'SHP-1015', 'destination': 'London, UK', 'status': 'Overseas Shipping', 'progress': 30, 'eta': 'Jan 16, 2026'},
  {'id': 'SHP-1020', 'destination': 'Tokyo, JP', 'status': 'Processing', 'progress': 10, 'eta': 'Jan 19, 2026'},
];
