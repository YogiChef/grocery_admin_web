import 'package:flutter/material.dart';

class MenuController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _gridscaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _addProductscaffoldKey =
      GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _editProductScaffoldKey =
      GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _ordercaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get getScaffoldKey => _scaffoldKey;
  GlobalKey<ScaffoldState> get getgridScaffoldKey => _gridscaffoldKey;
  GlobalKey<ScaffoldState> get getaddProsductsScaffoldKey =>
      _addProductscaffoldKey;
  GlobalKey<ScaffoldState> get getEditProductscaffoldKey =>
      _editProductScaffoldKey;
  GlobalKey<ScaffoldState> get getordercaffoldKey => _ordercaffoldKey;

  void controlDashboardMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
    notifyListeners();
  }

  void controlProductsMenu() {
    if (!_gridscaffoldKey.currentState!.isDrawerOpen) {
      _gridscaffoldKey.currentState!.openDrawer();
    }
    notifyListeners();
  }

  void controlAddProductsMenu() {
    if (!_addProductscaffoldKey.currentState!.isDrawerOpen) {
      _addProductscaffoldKey.currentState!.openDrawer();
    }
    notifyListeners();
  }

  void controlEditProductsMenu() {
    if (!_editProductScaffoldKey.currentState!.isDrawerOpen) {
      _editProductScaffoldKey.currentState!.openDrawer();
    }
    notifyListeners();
  }

  void controlAllOrder() {
    if (!_ordercaffoldKey.currentState!.isDrawerOpen) {
      _ordercaffoldKey.currentState!.openDrawer();
    }
    notifyListeners();
  }
}
