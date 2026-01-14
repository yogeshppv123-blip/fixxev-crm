import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../screens/dashboard_screen.dart';
import '../screens/stores_screen.dart';
import '../screens/products_screen.dart';
import '../screens/category_screen.dart';
import '../screens/suppliers_screen.dart';
import '../screens/billing_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/delivery_screen.dart';
import '../screens/report_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/help_screen.dart';

class Sidebar extends StatelessWidget {
  final String activePage;
  final bool isDrawer;
  const Sidebar({super.key, this.activePage = 'Dashboard', this.isDrawer = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.sidebarBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 8),
            child: Image.asset(
              'assets/images/logo.png',
              height: 85,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: [
                _buildSectionHeader('DISCOVER'),
                _buildMenuItem(context, Icons.dashboard, 'Dashboard'),
                _buildMenuItem(context, Icons.store, 'Stores'),
                const SizedBox(height: 20),
                _buildSectionHeader('INVENTORY'),
                _buildMenuItem(context, Icons.inventory_2_outlined, 'Products'),
                _buildMenuItem(context, Icons.category_outlined, 'Category'),
                _buildMenuItem(context, Icons.people_outline, 'Suppliers'),
                _buildMenuItem(context, Icons.receipt_long_outlined, 'Billing'),
                _buildMenuItem(context, Icons.shopping_cart_outlined, 'Orders'),
                _buildMenuItem(context, Icons.local_shipping_outlined, 'Delivery'),
                _buildMenuItem(context, Icons.assessment_outlined, 'Report'),
                const SizedBox(height: 20),
                _buildSectionHeader('SETTINGS'),
                _buildMenuItem(context, Icons.settings_outlined, 'Settings'),
                _buildMenuItem(context, Icons.help_outline, 'Help'),
              ],
            ),
          ),
          _buildMenuItem(context, Icons.logout, 'Logout', isLogout: true),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.inactiveIcon,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title,
      {bool isLogout = false}) {
    final bool isActive = activePage == title;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isActive ? AppColors.primary : AppColors.inactiveIcon,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isActive ? AppColors.primary : AppColors.inactiveIcon,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        dense: true,
        onTap: () {
          if (isActive || isLogout) return;
          
          final Map<String, String> routeMap = {
            'Dashboard': '/dashboard',
            'Stores': '/stores',
            'Products': '/products',
            'Category': '/category',
            'Suppliers': '/suppliers',
            'Billing': '/billing',
            'Orders': '/orders',
            'Delivery': '/delivery',
            'Report': '/report',
            'Settings': '/settings',
            'Help': '/help',
          };

          final routeName = routeMap[title];
          if (routeName != null) {
            Navigator.of(context).pushReplacementNamed(routeName);
          }
        },
      ),
    );
  }
}
