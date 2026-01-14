import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_strategy/url_strategy.dart';
import 'constants/colors.dart';
import 'screens/dashboard_screen.dart';
import 'screens/stores_screen.dart';
import 'screens/products_screen.dart';
import 'screens/category_screen.dart';
import 'screens/suppliers_screen.dart';
import 'screens/billing_screen.dart';
import 'screens/orders_screen.dart';
import 'screens/delivery_screen.dart';
import 'screens/report_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/help_screen.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ventorie Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.mainBackground,
        textTheme: GoogleFonts.outfitTextTheme(
          Theme.of(context).textTheme,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const DashboardScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/stores': (context) => const StoresScreen(),
        '/products': (context) => const ProductsScreen(),
        '/category': (context) => const CategoryScreen(),
        '/suppliers': (context) => const SuppliersScreen(),
        '/billing': (context) => const BillingScreen(),
        '/orders': (context) => const OrdersScreen(),
        '/delivery': (context) => const DeliveryScreen(),
        '/report': (context) => const ReportScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/help': (context) => const HelpScreen(),
      },
    );
  }
}
