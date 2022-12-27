// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grocery_admin/inner/edit_product.dart';
import 'package:grocery_admin/widgets/text_widget.dart';

import '../service/dialog.dart';
import '../service/firebase_const.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({super.key, required this.id});
  final String id;
  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  String title = '';
  String productCat = '';
  String? imageUrl;
  String price = '0.0';
  double salePrice = 0.0;
  bool isOnsale = false;
  bool isPiece = false;

  @override
  initState() {
    getProductData();
    super.initState();
  }

  Future<void> getProductData() async {
    try {
      final DocumentSnapshot productDoc =
          await fireStore.collection('products').doc(widget.id).get();

      if (productDoc == null) {
        return;
      } else {
        setState(() {
          title = productDoc.get('title');
          productCat = productDoc.get('productCategoryName');
          imageUrl = productDoc.get('imageUrl');
          price = productDoc.get('price');
          salePrice = productDoc.get('salePrice');
          isOnsale = productDoc.get('isOnSale');
          isPiece = productDoc.get('isPiece');
        });
      }
    } catch (errer) {
      errorDialog('$errer', context);
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(8),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).cardColor.withOpacity(0.6),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditProduct(
                          id: widget.id,
                          title: title,
                          price: price,
                          salePrice: salePrice,
                          productCat: productCat,
                          imageUrl: imageUrl!,
                          isOnSale: isOnsale,
                          isPiece: isPiece,
                        )));
          },
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                        flex: 1,
                        child: Image.network(
                          imageUrl == null
                              ? 'https://theproducemoms.com/wp-content/uploads/2017/07/apricot.jpg'
                              : imageUrl!,
                          fit: BoxFit.fill,
                          height:
                              kIsWeb ? size.width * 0.08 : size.width * 0.24,
                          width: kIsWeb ? size.width * 0.12 : size.width,
                        )),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: Row(
                    children: [
                      Visibility(
                        visible: isOnsale,
                        child: Text(
                          '฿ $price',
                          style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.red,
                              fontSize: kIsWeb ? 18 : 14),
                        ),
                      ),
                      isOnsale
                          ? const SizedBox(
                              width: 5,
                            )
                          : const SizedBox(),
                      TextWidget(
                        text: isOnsale
                            ? '฿ ${salePrice.toStringAsFixed(2)}'
                            : '฿ $price',
                        textSize: kIsWeb
                            ? size.width < 650
                                ? 12
                                : 20
                            : 14,
                      ),
                      const Spacer(),
                      TextWidget(
                        text: isPiece ? 'Piece' : '1Kg',
                        color: Colors.blue,
                        textSize: kIsWeb ? 20 : 14,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TextWidget(
                    text: title,
                    color: Colors.black,
                    textSize: kIsWeb ? 20 : 14,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
