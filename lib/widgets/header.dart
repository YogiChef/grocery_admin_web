import 'package:flutter/material.dart';
import 'package:grocery_admin/widgets/responsive.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme_provider.dart';

class Header extends StatelessWidget {
  const Header(
      {super.key,
      required this.press,
      required this.text,
      this.showTextField = false});
  final Function() press;
  final String text;
  final bool showTextField;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(onPressed: press, icon: const Icon(Icons.menu)),
        if (Responsive.isDesktop(context))
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              text,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
        if (Responsive.isDesktop(context))
          Spacer(
            flex: Responsive.isDesktop(context) ? 2 : 1,
          ),
        showTextField
            ? Container()
            : Expanded(
                child: Padding(
                padding: const EdgeInsets.only(top: 10, right: 20),
                child: TextField(
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 20),
                      hintText: 'Search',
                      fillColor: Theme.of(context).cardColor,
                      filled: true,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      suffixIcon: InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          // margin: const EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(5)),
                          child: const Icon(
                            Icons.search,
                            size: 24,
                            color: Colors.white,
                          ),
                        ),
                      )),
                ),
              ))
      ],
    );
  }
}
