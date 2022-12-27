import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_admin/widgets/text_widget.dart';

class OrdersWidget extends StatefulWidget {
  const OrdersWidget(
      {super.key,
      required this.price,
      required this.totalPrice,
      required this.proId,
      required this.userId,
      required this.imageUrl,
      required this.userName,
      required this.qty,
      required this.orderDate});
  final double price, totalPrice;
  final String proId, userId, imageUrl, userName;
  final int qty;
  final Timestamp orderDate;

  @override
  State<OrdersWidget> createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends State<OrdersWidget> {
  late String orderDateStr;
  @override
  void initState() {
    var postDate = widget.orderDate.toDate();
    orderDateStr =
        '${postDate.hour}:${postDate.minute}:${postDate.second} / ${postDate.day}-${postDate.month}-${postDate.year}';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).cardColor.withOpacity(0.4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
                flex: size.width < 650 ? 3 : 1,
                child: Image.network(
                  widget.imageUrl,
                  fit: BoxFit.fill,
                )),
            const SizedBox(
              height: 12,
            ),
            Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextWidget(
                        text:
                            '${widget.qty} X For ฿ ${widget.price.toStringAsFixed(2)}',
                        color: Colors.black54,
                      ),
                      FittedBox(
                        child: Row(children: [
                          TextWidget(
                            text: 'By',
                            textSize: 16,
                            isTitle: true,
                            color: Colors.blue,
                          ),
                          TextWidget(
                            text: '  ${widget.userName}',
                            textSize: 14,
                            isTitle: true,
                            color: Colors.black,
                          )
                        ]),
                      ),
                      Text(orderDateStr)
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
