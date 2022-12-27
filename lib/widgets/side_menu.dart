// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_admin/pages/main_page.dart';
import 'package:grocery_admin/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme_provider.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    final themeState = Provider.of<DarkThemeProvider>(context);
    // bool isDark = themeState.getDarkTheme;
    final Color color = themeState.getDarkTheme ? Colors.white70 : Colors.black;
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset('images/veg.png'),
          ),
          DrawerList(
              title: 'Main',
              press: () {
                const MainPage();
                Navigator.pushNamed(context, 'main_page');
              },
              icon: Icons.home_filled),
          DrawerList(
              title: 'View all Product',
              press: () {
                Navigator.pushReplacementNamed(context, 'allproducts');
              },
              icon: Icons.store),
          DrawerList(
              title: 'View all Order',
              press: () {
                Navigator.pushReplacementNamed(context, 'all_orders');
              },
              icon: IconlyBold.bag2),
          SwitchListTile(
              title: TextWidget(
                text: themeState.getDarkTheme ? 'Dark mode' : 'Light mode',
                color: color,
                isTitle: true,
                textSize: 20,
              ),
              secondary: Icon(themeState.getDarkTheme
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined),
              onChanged: (value) {
                themeState.setDarkTheme = value;
              },
              value: themeState.getDarkTheme),
        ],
      ),
    );
  }
}

class DrawerList extends StatelessWidget {
  const DrawerList(
      {super.key,
      required this.title,
      required this.press,
      required this.icon});
  final String title;
  final VoidCallback press;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).cardColor;
    final color = theme == true ? Colors.white : Colors.black;
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: Icon(
        icon,
        size: 18,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: color,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
