import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_admin/service/firebase_const.dart';
import 'package:grocery_admin/widgets/order_widget.dart';

class OrderList extends StatelessWidget {
  const OrderList({super.key, this.isInDashboard = true});
  final bool isInDashboard;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: fireStore.collection('orders').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data!.docs.isNotEmpty) {
              return Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(10)),
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: isInDashboard && snapshot.data!.docs.length > 5 ? 5 : snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          OrdersWidget(
                            price: snapshot.data!.docs[index]['price'],
                            totalPrice: snapshot.data!.docs[index]['total'],
                            proId: snapshot.data!.docs[index]['proId'],
                            userId: snapshot.data!.docs[index]['userId'],
                            qty: snapshot.data!.docs[index]['qty'],
                            orderDate: snapshot.data!.docs[index]['orderDate'],
                            imageUrl: snapshot.data!.docs[index]['imageUrl'],
                            userName: snapshot.data!.docs[index]['userName'],
                          ),
                          const Divider(
                            thickness: 2,
                          )
                        ],
                      );
                    }),
              );
            } else {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(18),
                  child: Text(
                    'Your store is empty',
                    style: TextStyle(color: Colors.teal),
                  ),
                ),
              );
            }
          }
          return const Center(
            child: Text(
              'Something went wrong',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          );
        });
  }
}
