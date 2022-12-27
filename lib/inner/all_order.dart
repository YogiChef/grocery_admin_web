
import 'package:flutter/material.dart';
import 'package:grocery_admin/widgets/header.dart';
import 'package:grocery_admin/widgets/order_list.dart';
import 'package:provider/provider.dart';

import '../widgets/responsive.dart';
import '../widgets/side_menu.dart';
import '../controllers/menu_controller.dart';

class AllOrderPage extends StatefulWidget {
  const AllOrderPage({super.key});

  @override
  State<AllOrderPage> createState() => _AllOrderPageState();
}

class _AllOrderPageState extends State<AllOrderPage> {
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: context.read<MenuController>().getordercaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Responsive.isDesktop(context))
            const Expanded(
              child: SideMenu(),
            ),
          Expanded(
              flex: 5,
              child: SingleChildScrollView(
                controller: ScrollController(),
                child: Column(
                  children: [
                    Header(
                      showTextField: false,
                      press: () {
                        context.read<MenuController>().controlAllOrder();
                      },
                      text: 'All Order',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: OrderList(
                        isInDashboard: false,
                      ),
                    ),
                  ],
                ),
              ))
        ],
      )),
    );
  }
}
