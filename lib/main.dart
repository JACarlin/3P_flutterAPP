import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/views/login_view.dart';
import 'package:my_ecommerce_app/views/order_list_view.dart';
import 'package:my_ecommerce_app/views/order_detail_view.dart';
import 'package:my_ecommerce_app/views/product_list_view.dart';
import 'package:my_ecommerce_app/views/create_order_view.dart';
import 'package:my_ecommerce_app/views/home_view.dart';
import 'package:my_ecommerce_app/views/register_view.dart';
import 'package:my_ecommerce_app/views/profile_view.dart';
import 'package:my_ecommerce_app/views/product_detatil_view.dart';
import 'package:my_ecommerce_app/views/admin_page_view.dart';
import 'package:my_ecommerce_app/views/edit_product_view.dart';
import 'package:my_ecommerce_app/views/add_product_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Tienda',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/home': (context) => HomeView(),
        '/': (context) => LoginView(),
        '/register': (context) => RegisterView(),
        '/orders': (context) => OrderListView(),
        '/orderDetail': (context) => OrderDetailView(),
        '/products': (context) => ProductListView(),
        '/createOrder': (context) => CreateOrderView(),
        '/profile': (context) => ProfileView(),
        '/productDetail': (context) => ProductDetailView(),
        '/admin': (context) => AdminPage(),
        '/editProduct': (context) => EditProductPage(),
        '/addProduct': (context) => AddProductPage(),
      },
    );
  }
}
