import 'package:flutter/material.dart';

import '../widgets/products_grid.dart';

class ProductsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
              onSelected: (int selectedValue) {
                print(selectedValue);
              },
              icon: Icon(
                Icons.more_vert,
              ),
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text('Only favorite'),
                      value: 0,
                    ),
                    PopupMenuItem(
                      child: Text('Show All'),
                      value: 0,
                    )
                  ])
        ],
        title: Text('MyShop'),
      ),
      body: ProductsGrid(),
    );
  }
}
