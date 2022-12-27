import 'package:flutter/material.dart';
import 'package:grocery_admin/widgets/responsive.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    required this.lable,
    this.press,
    this.horizontal = 0,
    this.fontSize = 18,
    this.width,
    this.color = Colors.green,
  }) : super(key: key);
  final String lable;
  final Function()? press;
  final double horizontal;
  final double fontSize;
  final double? width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: width,
      padding: EdgeInsets.symmetric(horizontal: horizontal),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
      child: MaterialButton(
        onPressed: press,
        child: Text(
          lable,
          style: TextStyle(fontSize: fontSize, color: Colors.white),
        ),
      ),
    );
  }
}

class GoogleButton extends StatelessWidget {
  const GoogleButton({
    Key? key,
    required this.lable,
    this.press,
    this.horizontal = 0,
    this.fontSize = 18,
    this.width,
    this.color = Colors.green,
    this.txtColor = Colors.white,
  }) : super(key: key);
  final String lable;
  final Function()? press;
  final double horizontal;
  final double fontSize;
  final double? width;
  final Color color;
  final Color txtColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: width,
      padding: EdgeInsets.symmetric(horizontal: horizontal),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
      child: MaterialButton(
        onPressed: press,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('images/google.png'),
            const SizedBox(
              width: 20,
            ),
            Text(
              lable,
              style: TextStyle(fontSize: fontSize, color: txtColor),
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonIcon extends StatelessWidget {
  const ButtonIcon(
      {super.key,
      required this.icon,
      required this.text,
      required this.press,
      this.backgroundColor = Colors.teal});
  final IconData icon;
  final String text;
  final VoidCallback press;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 16 / (Responsive.isDesktop(context) ? 1 : 2),
          )),
      onPressed: press,
      icon: Icon(
        icon,
        size: 20,
      ),
      label: Text(text),
    );
  }
}
