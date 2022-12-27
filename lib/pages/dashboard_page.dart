import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_admin/controllers/menu_controller.dart';
import 'package:grocery_admin/widgets/button_widget.dart';
import 'package:grocery_admin/widgets/grid_product.dart';
import 'package:grocery_admin/widgets/header.dart';
import 'package:grocery_admin/widgets/order_list.dart';
import 'package:grocery_admin/widgets/products_widget.dart';
import 'package:grocery_admin/widgets/responsive.dart';
import 'package:grocery_admin/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../service/firebase_const.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        controller: ScrollController(),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Header(
              press: () {
                context.read<MenuController>().controlDashboardMenu();
              },
              text: 'Dashboard',
              showTextField: false,
            ),
            const SizedBox(
              height: 20,
            ),
            TextWidget(
              text: 'Latest Products',
              textSize: 20,
              isTitle: true,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  ButtonIcon(icon: Icons.store, text: 'View All', press: () {}),
                  const Spacer(),
                  ButtonIcon(
                      icon: Icons.add,
                      text: 'Add Product',
                      press: () {
                        Navigator.pushReplacementNamed(context, 'add_product');
                      }),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    // flex: 5,
                    child: Column(
                  children: [
                    Responsive(
                      mobile: GridProduct(
                        crossAxisCount: size.width < 250
                            ? 1
                            : size.width < 650
                                ? 2
                                : 4,
                        childAspectRatio:
                            size.width < 650 && size.width > 350 ? 1.1 : 0.8,
                      ),
                      desktop: GridProduct(
                        childAspectRatio: size.width < 1400 ? 0.8 : 1.05,
                      ),
                    ),
                   
                    const OrderList(),
                  ],
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
