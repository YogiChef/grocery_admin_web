import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_admin/service/firebase_const.dart';
import 'package:grocery_admin/widgets/products_widget.dart';

class GridProduct extends StatelessWidget {
  const GridProduct(
      {super.key,
      this.crossAxisCount = 4,
      this.childAspectRatio = 1,
      this.isInMain = true});
  final int crossAxisCount;
  final double childAspectRatio;
  final bool isInMain;

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    return StreamBuilder<QuerySnapshot>(
        stream: fireStore.collection('products').snapshots(),
        builder: (context, stapshot) {
          if (stapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (stapshot.connectionState == ConnectionState.active) {
            if (stapshot.data!.docs.isNotEmpty) {
              return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: isInMain && stapshot.data!.docs.length > 4
                      ? 4
                      : stapshot.data!.docs.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      childAspectRatio: childAspectRatio,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4),
                  itemBuilder: (context, index) {
                    return ProductWidget(
                      id: stapshot.data!.docs[index]['id'],
                    );
                  });
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
