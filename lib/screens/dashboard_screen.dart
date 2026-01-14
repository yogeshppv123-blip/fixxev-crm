import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../widgets/sidebar.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/stat_section.dart';
import '../widgets/charts_section.dart';
import '../widgets/restock_section.dart';
import '../widgets/product_table.dart';
import '../widgets/right_panel.dart';
import '../widgets/responsive.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    final bool isMobile = Responsive.isMobile(context);
    final bool isTablet = Responsive.isTablet(context);

    return Scaffold(
      drawer: !isDesktop
          ? const Drawer(child: Sidebar(activePage: 'Dashboard', isDrawer: true))
          : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isDesktop)
            const SizedBox(width: 250, child: Sidebar(activePage: 'Dashboard')),
          Expanded(
            child: Container(
              color: AppColors.mainBackground,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(isMobile ? 16 : 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const DashboardHeader(),
                          const SizedBox(height: 24),
                          const StatSection(),
                          const SizedBox(height: 24),
                          const ChartsSection(),
                          const SizedBox(height: 24),
                          if (isMobile || isTablet)
                            const Column(
                              children: [
                                RestockSection(),
                                SizedBox(height: 24),
                                ProductTable(),
                              ],
                            )
                          else
                            const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(flex: 2, child: RestockSection()),
                                SizedBox(width: 24),
                                Expanded(flex: 3, child: ProductTable()),
                              ],
                            ),
                          if (!isDesktop) ...[
                            const SizedBox(height: 24),
                            const RightPanel(isEmbedded: true),
                          ],
                        ],
                      ),
                    ),
                  ),
                  if (isDesktop)
                    const Expanded(
                      flex: 1,
                      child: RightPanel(),
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
