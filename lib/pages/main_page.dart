import 'package:flutter/material.dart';
import 'package:grocery_admin/controllers/menu_controller.dart';
import 'package:grocery_admin/pages/dashboard_page.dart';
import 'package:grocery_admin/widgets/responsive.dart';
import 'package:grocery_admin/widgets/side_menu.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuController>().getScaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Responsive.isDesktop(context))
            const Expanded(
              child: SideMenu(),
            ),
          const Expanded(flex: 5, child: DashboardPage())
        ],
      )),
    );
  }
}
