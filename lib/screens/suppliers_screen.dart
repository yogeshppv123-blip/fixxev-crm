import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../widgets/sidebar.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/responsive.dart';


class SuppliersScreen extends StatelessWidget {
  const SuppliersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    final bool isMobile = Responsive.isMobile(context);

    return Scaffold(
      drawer: !isDesktop
          ? const Drawer(child: Sidebar(activePage: 'Suppliers', isDrawer: true))
          : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isDesktop)
            const SizedBox(width: 250, child: Sidebar(activePage: 'Suppliers')),
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
                            'Suppliers',
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
                              icon: const Icon(Icons.person_add_alt_1, color: Colors.white),
                              label: const Text('Add Supplier', style: TextStyle(color: Colors.white)),
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
                            'Suppliers',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textBlack,
                                ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.person_add_alt_1, color: Colors.white),
                            label: const Text('Add Supplier', style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 24),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: supplierData.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        return SupplierListItem(data: supplierData[index]);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SupplierListItem extends StatelessWidget {
  final Map<String, dynamic> data;
  const SupplierListItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: isMobile 
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                      child: Text(data['name'][0], style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          Text(data['contact'], style: const TextStyle(color: AppColors.textGray, fontSize: 12)),
                        ],
                      ),
                    ),
                    _StatusBadge(status: data['status']),
                  ],
                ),
                const Divider(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Category', style: TextStyle(color: AppColors.textGray, fontSize: 11)),
                          Text(data['category'], style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Supplied Items', style: TextStyle(color: AppColors.textGray, fontSize: 11)),
                          Text('${data['items']} SKU', style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
                        ],
                      ),
                    ),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.email_outlined, color: AppColors.primary, size: 20)),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz, color: AppColors.textGray, size: 20)),
                  ],
                ),
              ],
            )
          : Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                  child: Text(data['name'][0], style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(data['contact'], style: const TextStyle(color: AppColors.textGray, fontSize: 13)),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Category', style: TextStyle(color: AppColors.textGray, fontSize: 11)),
                      Text(data['category'], style: const TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Supplied Items', style: TextStyle(color: AppColors.textGray, fontSize: 11)),
                      Text('${data['items']} SKU', style: const TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                _StatusBadge(status: data['status']),
                const SizedBox(width: 16),
                IconButton(onPressed: () {}, icon: const Icon(Icons.email_outlined, color: AppColors.primary)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz, color: AppColors.textGray)),
              ],
            ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: status == 'Verified' ? Colors.green.withValues(alpha: 0.1) : Colors.amber.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: status == 'Verified' ? Colors.green : Colors.orange,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

final List<Map<String, dynamic>> supplierData = [
  {'name': 'Global Textiles Inc.', 'contact': 'contact@globaltextiles.com', 'category': 'Fabrics', 'items': 120, 'status': 'Verified'},
  {'name': 'Elite Leather & Co', 'contact': 'sales@eliteleather.co', 'category': 'Accessories', 'items': 45, 'status': 'Verified'},
  {'name': 'Prime Electronics', 'contact': 'support@prime-elec.com', 'category': 'Gadgets', 'items': 80, 'status': 'Pending'},
  {'name': 'Nature Wear', 'contact': 'hello@naturewear.org', 'category': 'Sustainable Clothing', 'items': 30, 'status': 'Verified'},
  {'name': 'Fast Logistics NYC', 'contact': 'ops@fastlog.io', 'category': 'Shipping', 'items': 0, 'status': 'Verified'},
];
