import 'package:flutter/material.dart';
import 'package:grocery_admin/widgets/grid_product.dart';
import 'package:grocery_admin/widgets/header.dart';
import 'package:provider/provider.dart';

import '../widgets/responsive.dart';
import '../widgets/side_menu.dart';
import '../controllers/menu_controller.dart';

class AllProductPage extends StatefulWidget {
  const AllProductPage({super.key});

  @override
  State<AllProductPage> createState() => _AllProductPageState();
}

class _AllProductPageState extends State<AllProductPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: context.read<MenuController>().getgridScaffoldKey,
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
                      press: () {
                        context.read<MenuController>().controlProductsMenu();
                      },
                      text: 'All Products',
                    ),
                    Responsive(
                      mobile: GridProduct(
                        isInMain: false,
                        crossAxisCount: size.width < 250
                            ? 1
                            : size.width < 650
                                ? 2
                                : 4,
                        childAspectRatio:
                            size.width < 650 && size.width > 350 ? 1.1 : 0.8,
                      ),
                      desktop: GridProduct(
                        isInMain: false,
                        childAspectRatio: size.width < 1400 ? 0.8 : 1.05,
                      ),
                    )
                  ],
                ),
              ))
        ],
      )),
    );
  }
}
