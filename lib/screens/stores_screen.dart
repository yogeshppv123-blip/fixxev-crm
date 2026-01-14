import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../widgets/sidebar.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/responsive.dart';


class StoresScreen extends StatelessWidget {
  const StoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    final bool isMobile = Responsive.isMobile(context);

    return Scaffold(
      drawer: !isDesktop
          ? const Drawer(child: Sidebar(activePage: 'Stores', isDrawer: true))
          : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isDesktop)
            const SizedBox(width: 250, child: Sidebar(activePage: 'Stores')),
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
                            'Our Stores',
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
                              icon: const Icon(Icons.add, color: Colors.white),
                              label: const Text('Add New Store', style: TextStyle(color: Colors.white)),
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
                            'Our Stores',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textBlack,
                                ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.add, color: Colors.white),
                            label: const Text('Add New Store', style: TextStyle(color: Colors.white)),
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
                        double childAspectRatio = 1.9; // Shorter cards on desktop
                        
                        if (constraints.maxWidth < 650) {
                          crossAxisCount = 1;
                          childAspectRatio = 2.0; // Very compact on mobile
                        } else if (constraints.maxWidth < 1200) {
                          crossAxisCount = 2;
                          childAspectRatio = 1.7;
                        }

                        return GridView.count(
                          crossAxisCount: crossAxisCount,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          childAspectRatio: childAspectRatio,
                          children: const [
                            StoreCard(
                              name: 'Downtown Boutique',
                              location: 'New York, Manhattan',
                              type: 'Flagship Store',
                              inventory: '1,240 Items',
                              value: '\$450,000',
                              status: 'Active',
                              imageColor: Colors.blueAccent,
                            ),
                            StoreCard(
                              name: 'Westside Outlet',
                              location: 'Los Angeles, CA',
                              type: 'Outlet',
                              inventory: '850 Items',
                              value: '\$210,000',
                              status: 'Maintenance',
                              imageColor: Colors.orangeAccent,
                            ),
                            StoreCard(
                              name: 'Express Hub',
                              location: 'Chicago, IL',
                              type: 'Online Fulfillment',
                              inventory: '3,100 Items',
                              value: '\$890,000',
                              status: 'Active',
                              imageColor: Colors.greenAccent,
                            ),
                            StoreCard(
                              name: 'Airport Kiosk',
                              location: 'London Heathrow',
                              type: 'Kiosk',
                              inventory: '120 Items',
                              value: '\$35,000',
                              status: 'Active',
                              imageColor: Colors.purpleAccent,
                            ),
                            StoreCard(
                              name: 'City Center Mall',
                              location: 'Dubai, UAE',
                              type: 'Retail Store',
                              inventory: '2,400 Items',
                              value: '\$1,200,000',
                              status: 'Active',
                              imageColor: Colors.indigoAccent,
                            ),
                          ],
                        );
                      }
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

class StoreCard extends StatelessWidget {
  final String name;
  final String location;
  final String type;
  final String inventory;
  final String value;
  final String status;
  final Color imageColor;

  const StoreCard({
    super.key,
    required this.name,
    required this.location,
    required this.type,
    required this.inventory,
    required this.value,
    required this.status,
    required this.imageColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: imageColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.storefront, color: imageColor, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textBlack),
                    ),
                    Text(type, style: const TextStyle(color: AppColors.textGray, fontSize: 12)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: status == 'Active' ? Colors.green.withValues(alpha: 0.1) : Colors.orange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: status == 'Active' ? Colors.green : Colors.orange,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 14, color: AppColors.textGray),
              const SizedBox(width: 4),
              Expanded(child: Text(location, style: const TextStyle(color: AppColors.textGray, fontSize: 12), overflow: TextOverflow.ellipsis)),
            ],
          ),
          const Spacer(),
          const Divider(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Inventory', style: TextStyle(color: AppColors.textGray, fontSize: 10)),
                  Text(inventory, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('Valuation', style: TextStyle(color: AppColors.textGray, fontSize: 10)),
                  Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.primary)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
