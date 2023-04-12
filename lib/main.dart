import 'package:ecommerce_admin/pages/add_product_page.dart';
import 'package:ecommerce_admin/pages/category_page.dart';
import 'package:ecommerce_admin/pages/dashboard_page.dart';
import 'package:ecommerce_admin/pages/launcher_page.dart';
import 'package:ecommerce_admin/pages/login_page.dart';
import 'package:ecommerce_admin/pages/order_page.dart';
import 'package:ecommerce_admin/pages/product_details_page.dart';
import 'package:ecommerce_admin/pages/product_repurchase_page.dart';
import 'package:ecommerce_admin/pages/report_page.dart';
import 'package:ecommerce_admin/pages/settings_page.dart';
import 'package:ecommerce_admin/pages/user_list_page.dart';
import 'package:ecommerce_admin/pages/view_product_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: LauncherPage.routeName,
      routes: {
        LauncherPage.routeName: (_) => const LauncherPage(),
        LoginPage.routeName: (_) => const LoginPage(),
        DashboardPage.routeName: (_) => const DashboardPage(),
        AddProductPage.routeName: (_) => const AddProductPage(),
        ViewProductPage.routeName: (_) => const ViewProductPage(),
        ProductDetailsPage.routeName: (_) => const ProductDetailsPage(),
        CategoryPage.routeName: (_) => const CategoryPage(),
        OrderPage.routeName: (_) => const OrderPage(),
        ReportPage.routeName: (_) => const ReportPage(),
        SettingsPage.routeName: (_) => const SettingsPage(),
        ProductRepurchasePage.routeName: (_) => const ProductRepurchasePage(),
        UserListPage.routeName: (_) => const UserListPage(),
      },
    );
  }
}