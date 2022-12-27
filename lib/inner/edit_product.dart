// ignore_for_file: no_leading_underscores_for_local_identifiers, sort_child_properties_last, use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_admin/service/dialog.dart';
import 'package:grocery_admin/service/firebase_const.dart';
import 'package:grocery_admin/service/loading_manager.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/button_widget.dart';
import '../widgets/text_widget.dart';

// flutter run -d chrome --web-renderer html
List<String> menuItem = [
  'Vegetables',
  'Fruits',
  'Grains',
  'Nuts',
  'Herbs',
  'Spices',
];

class EditProduct extends StatefulWidget {
  const EditProduct(
      {super.key,
      required this.id,
      required this.title,
      required this.price,
      required this.productCat,
      required this.imageUrl,
      required this.isPiece,
      required this.isOnSale,
      required this.salePrice});

  final String id, title, price, productCat, imageUrl;
  final bool isPiece, isOnSale;
  final double salePrice;

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titletextCtr, _priceContr;

  bool isPiece = false;
  late String _catValue;
  String? _salepercent;
  late String percToShow;
  late double _salePrice;
  late bool _isOnSale;

  File? _pickedImage;
  Uint8List webImage = Uint8List(8);
  late String imgUrl;
  late int val;
  late bool _isPiece;
  bool _isLoading = false;

  @override
  void initState() {
    _titletextCtr = TextEditingController(text: widget.title);
    _priceContr = TextEditingController(text: widget.price);
    _salePrice = widget.salePrice;
    _catValue = widget.productCat;
    _isOnSale = widget.isOnSale;
    _isPiece = widget.isPiece;
    val = _isPiece ? 2 : 1;
    imgUrl = widget.imageUrl;
    percToShow =
        '${(100 - (_salePrice * 100) / double.parse('1.88')).round().toStringAsFixed(1)} %';
    super.initState();
  }

  @override
  void dispose() {
    _titletextCtr.dispose();
    _priceContr.dispose();
    super.dispose();
  }

  void _updateForm() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();

      try {
        setState(() {
          _isLoading = true;
        });
        if (_pickedImage != null) {
          final metadata =
              firebase_storage.SettableMetadata(contentType: 'imge/jpg');
          firebase_storage.Reference ref = firebase_storage
              .FirebaseStorage.instance
              .ref()
              .child('productImg')
              .child('${widget.id}.jpg');
          kIsWeb
              ? await ref.putData(webImage, metadata)
              : await ref.putFile(File(_pickedImage!.path));
          imgUrl = await ref.getDownloadURL();
        }
        await fireStore.collection('products').doc(widget.id).update({
          'id': widget.id,
          'title': _titletextCtr.text,
          'price': _priceContr.text,
          'salePrice': _salePrice,
          'imageUrl':
              _pickedImage == null ? widget.imageUrl : imgUrl.toString(),
          'productCategoryName': _catValue,
          'isOnSale': _isOnSale,
          'isPiece': _isPiece,
        });

        Fluttertoast.showToast(
          msg: "Product has been updated",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
        );

        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      } on FirebaseException catch (error) {
        errorDialog('${error.message}', context);
        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        errorDialog('$error', context);
        setState(() {
          _isLoading = false;
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _clearForm() {
    isPiece = false;
    _priceContr.clear();
    _titletextCtr.clear();

    setState(() {
      _pickedImage = null;

      webImage = Uint8List(8);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _scaffoldColor = Theme.of(context).scaffoldBackgroundColor;
    Size size = MediaQuery.of(context).size;

    var inputDecoration = InputDecoration(
      filled: true,
      fillColor: _scaffoldColor,
      border: InputBorder.none,
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
    );

    return Scaffold(
      // key: context.read<MenuController>().getEditProductscaffoldKey,
      // drawer: const SideMenu(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // if (Responsive.isDesktop(context)) const Expanded(child: SideMenu()),
          Expanded(
            flex: 5,
            child: LoadingManager(
              isLoading: _isLoading,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Header(
                    //     press: () {
                    //       // context
                    //       //     .read<MenuController>()
                    //       //     .controlEditProductsMenu();
                    //     },
                    //     text: 'Edit product',
                    //     showTextField: false,
                    //   ),
                    // ),
                    const SizedBox(
                      height: 25,
                    ),
                    Center(
                      child: Container(
                        width: size.width > 650 ? 650 : size.width,
                        color: Theme.of(context).cardColor,
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.all(16),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              TextWidget(
                                text: 'Product title*',
                                color: Colors.grey,
                                isTitle: true,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: _titletextCtr,
                                key: const ValueKey('Title'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a Title';
                                  }
                                  return null;
                                },
                                decoration: inputDecoration,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: FittedBox(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          TextWidget(
                                            text: 'Price in \$*',
                                            color: Colors.grey,
                                            isTitle: true,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            width: 100,
                                            child: TextFormField(
                                              controller: _priceContr,
                                              key: const ValueKey('Price \$'),
                                              keyboardType: TextInputType.number,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Price is missed';
                                                }
                                                return null;
                                              },
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter.allow(
                                                    RegExp(r'[0-9.]')),
                                              ],
                                              decoration: inputDecoration,
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          TextWidget(
                                            text: 'Porduct category*',
                                            color: Colors.grey,
                                            isTitle: true,
                                          ),
                                          const SizedBox(height: 10),
                                          // Drop down menu code here
                                          _categoryDropDown(),

                                          const SizedBox(
                                            height: 20,
                                          ),
                                          TextWidget(
                                            text: 'Measure unit*',
                                            color: Colors.grey,
                                            isTitle: true,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          // Radio button code here
                                          Row(
                                            children: [
                                              TextWidget(
                                                text: 'KG',
                                                color: Colors.grey,
                                              ),
                                              Radio(
                                                value: 1,
                                                groupValue: val,
                                                onChanged: (valuee) {
                                                  setState(() {
                                                    val = 1;
                                                    isPiece = false;
                                                  });
                                                },
                                                activeColor: Colors.green,
                                              ),
                                              TextWidget(
                                                text: 'Piece',
                                                color: Colors.grey,
                                              ),
                                              Radio(
                                                value: 2,
                                                groupValue: val,
                                                onChanged: (valuee) {
                                                  setState(() {
                                                    val = 2;
                                                    isPiece = true;
                                                  });
                                                },
                                                activeColor: Colors.green,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Checkbox(
                                                  value: _isOnSale,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _isOnSale = value!;
                                                    });
                                                  }),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              TextWidget(
                                                text: 'Sale',
                                                textSize: 20,
                                                isTitle: true,
                                              )
                                            ],
                                          ),
                                          AnimatedSwitcher(
                                            duration: const Duration(seconds: 1),
                                            child: !_isOnSale
                                                ? Container()
                                                : Row(
                                                    children: [
                                                      TextWidget(
                                                        text:
                                                            '฿ ${_salePrice.toStringAsFixed(2)}',
                                                        isTitle: true,
                                                        textSize: 20,
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      salePercentageDropdowWidget(
                                                          Colors.black)
                                                    ],
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Image to be picked code is here
                                  Expanded(
                                    flex: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          height: size.width > 650
                                              ? 350
                                              : size.width * 0.45,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: _pickedImage == null
                                                ? Image.network(imgUrl)
                                                : kIsWeb
                                                    ? Image.memory(webImage,
                                                        fit: BoxFit.cover)
                                                    : Image.file(_pickedImage!,
                                                        fit: BoxFit.cover),
                                          )),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          FittedBox(
                                            child: TextButton(
                                              onPressed: () {
                                                _pickImage();
                                              },
                                              child: TextWidget(
                                                text: 'Update image',
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ButtonIcon(
                                      press: () async {
                                        warningDialog(
                                            'Delele', 'Pres okay to confirm',
                                            () async {
                                          await fireStore
                                              .collection('products')
                                              .doc(widget.id)
                                              .delete();
                                          await Fluttertoast.showToast(
                                            msg: "Product has been deleted",
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                          );
                                          setState(() {
                                            while (Navigator.canPop(context)) {
                                              Navigator.pop(context);
                                            }
                                          });
                                        }, context, 'images/error.json');
                                      },
                                      text: 'Delele',
                                      icon: IconlyBold.danger,
                                      backgroundColor: Colors.red.shade300,
                                    ),
                                    ButtonIcon(
                                      press: () {
                                        _updateForm();
                                      },
                                      text: 'Update',
                                      icon: IconlyBold.setting,
                                      backgroundColor: Colors.blue,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          _pickedImage = selected;
        });
      } else {
        log('No image has been picked');
      }
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          webImage = f;
          _pickedImage = File('a');
        });
      } else {
        log('No image has been picked');
      }
    } else {
      log('Something went wrong');
    }
  }

  Widget _categoryDropDown() {
    final color = Theme.of(context).cardColor;
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          value: _catValue,
          onChanged: (value) {
            setState(() {
              _catValue = value!;
            });
            print(_catValue);
          },
          hint: const Text('Select a category'),
          items: menuItem.map(categoryItem).toList(),
        )),
      ),
    );
  }

  DropdownMenuItem<String> categoryItem(String item) {
    return DropdownMenuItem(
      value: item,
      child: TextWidget(
        text: item,
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
        value: item,
        child: TextWidget(
          text: item,
        ));
  }

  DropdownButtonHideUnderline salePercentageDropdowWidget(Color color) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        style: TextStyle(color: color),
        items: const [
          DropdownMenuItem<String>(
            child: Text('10%'),
            value: '10',
          ),
          DropdownMenuItem<String>(
            child: Text('15%'),
            value: '15',
          ),
          DropdownMenuItem<String>(
            child: Text('25%'),
            value: '25',
          ),
          DropdownMenuItem<String>(
            child: Text('50%'),
            value: '50',
          ),
          DropdownMenuItem<String>(
            child: Text('75%'),
            value: '75',
          ),
          DropdownMenuItem<String>(
            child: Text('0%'),
            value: '0',
          ),
        ],
        onChanged: (value) {
          if (value == '0') {
            return;
          } else {
            setState(() {
              _salepercent = value;
              _salePrice = double.parse(widget.price) -
                  (double.parse(value!) * double.parse(widget.price) / 100);
            });
          }
        },
        hint: Text(_salepercent ?? percToShow),
        value: _salepercent,
      ),
    );
  }
}
