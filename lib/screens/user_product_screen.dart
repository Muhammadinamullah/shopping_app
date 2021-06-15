import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/app_drawer.dart';
import 'package:flutter_complete_guide/widgets/user_product_item.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatelessWidget {
  static const routePath = '/user-product';
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (_, i) => Column(
            children: [
              UserProductItem(
                  productsData.items[i].title, productsData.items[i].imageUrl),
              Divider(
                thickness: 5,
              ),
            ],
          ),
          itemCount: productsData.items.length,
        ),
      ),
    );
  }
}
