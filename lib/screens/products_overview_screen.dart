import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/product.dart';
import 'package:flutter_complete_guide/providers/products.dart';
import 'package:provider/provider.dart';

import '../widgets/products_grid.dart';

enum filterOptions { Favorites, All }

class ProductsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsItems = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
              onSelected: (filterOptions selectedValue) {
                if (selectedValue == filterOptions.Favorites) {
                  productsItems.showFavoritesOnly();
                } else {
                  productsItems.showAll();
                }
              },
              icon: Icon(
                Icons.more_vert,
              ),
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text('Only favorite'),
                      value: filterOptions.Favorites,
                    ),
                    PopupMenuItem(
                      child: Text('Show All'),
                      value: filterOptions.All,
                    )
                  ])
        ],
        title: Text('MyShop'),
      ),
      body: ProductsGrid(),
    );
  }
}
