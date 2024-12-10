import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
import 'package:my_ecommerce_app/controllers/user_controller.dart';
import 'package:my_ecommerce_app/controllers/product_controller.dart';
import 'package:my_ecommerce_app/controllers/order_controller.dart';
import 'package:my_ecommerce_app/services/api_service.dart';

// UserSession singleton to store global user data
class UserSession {
  static final UserSession _instance = UserSession._internal();

  String? userId;
  List<dynamic> userData = [];  // List to store user-related data

  factory UserSession() {
    return _instance;
  }

  UserSession._internal();
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Proveedor de ApiService
        Provider<ApiService>(
          create: (_) => ApiService(),
        ),
        // Proveedor de UserController que depende de ApiService
        ChangeNotifierProvider<UserController>(
          create: (context) => UserController(
            context.read<ApiService>(), // Proveer ApiService al UserController
          ),
        ),
        // Proveedor de ProductController
        ChangeNotifierProvider<ProductController>(
          create: (context) => ProductController(
            context.read<ApiService>(),
          ),
        ),
        // Proveedor de OrderController
        ChangeNotifierProvider<OrderController>(
          create: (context) => OrderController(
            context.read<ApiService>(),
          ),
        ),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
