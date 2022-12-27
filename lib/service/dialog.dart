import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../widgets/text_widget.dart';

Future<void> warningDialog(
  String title,
  String subtitle,
  Function()? press,
  BuildContext context,
  String? img,
) async {
  await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Lottie.asset(
                img!,
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(title),
            ],
          ),
          content: Text(
            subtitle,
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              child: const Text('Cancle'),
            ),
            TextButton(
              onPressed: press,
              child: TextWidget(
                text: 'Ok',
                color: Colors.red,
                isTitle: true,
                textSize: 20,
              ),
            )
          ],
        );
      });
}

Future<void> errorDialog(
  String subtitle,
  BuildContext context,
) async {
  await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Lottie.asset(
                'images/error.json',
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text('Error occured')
            ],
          ),
          content: Text(
            subtitle,
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              child: const Text(
                'Ok',
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
            ),
          ],
        );
      });
}
