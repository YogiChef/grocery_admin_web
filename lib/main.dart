import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grocery_admin/consts/theme_data.dart';
import 'package:grocery_admin/inner/add_product.dart';
import 'package:grocery_admin/inner/all_order.dart';
import 'package:grocery_admin/inner/all_products.dart';
import 'package:grocery_admin/controllers/menu_controller.dart';
import 'package:grocery_admin/pages/main_page.dart';
import 'package:grocery_admin/provider/dark_theme_provider.dart';
import 'package:provider/provider.dart';

// flutter run -d chrome --web-renderer html
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyBic97IoaA_JyXzPx2NS8DRD9GbHm_4k9U',
    appId: '1:802121114684:web:3027c615d02d8ea2fa8f39',
    messagingSenderId: '802121114684',
    projectId: 'grocyryapp',
    storageBucket: "grocyryapp.appspot.com",
  ));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemeP.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              home: Scaffold(
                  body: Center(
                child: Text('App is being initialized'),
              )),
            );
          } else if (snapshot.hasError) {
            return MaterialApp(
              home: Scaffold(
                  body: Center(
                child: Text('An error has been occured ${snapshot.error}'),
              )),
            );
          }
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => MenuController(),
              ),
              ChangeNotifierProvider(create: (_) => themeChangeProvider)
            ],
            child: Consumer<DarkThemeProvider>(
                builder: (context, themeProvider, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Grocery',
                theme: Styles.themeData(themeProvider.getDarkTheme, context),
                home: const MainPage(),
                routes: {
                  'main_page': (context) => const MainPage(),
                  'allproducts': (context) => const AllProductPage(),
                  'all_orders': (context) => const AllOrderPage(),
                  'add_product': (context) => const AddProduct(),
                },
              );
            }),
          );
        });
  }
}
