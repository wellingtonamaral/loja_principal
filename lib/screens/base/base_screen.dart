import 'package:flutter/material.dart';
import 'package:loja_principal/common/custom_drawer/custom_drawer.dart';
import 'package:loja_principal/models/page_manager.dart';
import 'package:loja_principal/models/user_manager.dart';
import 'package:loja_principal/screens/admin_orders/admin_orders_screen.dart';
import 'package:loja_principal/screens/admin_users/admin_users_screen.dart';
import 'package:loja_principal/screens/home/home_screen.dart';
import 'package:loja_principal/screens/orders/orders_screen.dart';
import 'package:loja_principal/screens/products/products_screen.dart';

import 'package:provider/provider.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: Consumer<UserManager>(
        builder: (_, userManager, __) {
          return PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              HomeScreen(),
              ProductsScreen(),
              OrdersScreen(),
              Scaffold(
                drawer: CustomDrawer(),
                appBar: AppBar(
                  title: const Text('Lojas'),
                ),
              ),
              if (userManager.adminEnabled) ...[
                AdminUsersScreen(),
                AdminOrdersScreen(),
                Scaffold(
                  drawer: CustomDrawer(),
                  appBar: AppBar(
                    title: const Text('Pedidos'),
                  ),
                ),
              ]
            ],
          );
        },
      ),
    );
  }
}
