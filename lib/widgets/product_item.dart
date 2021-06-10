import 'package:flutter/material.dart';
import 'package:shopping_app/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {},
          child: Image.network(imageUrl, fit: BoxFit.cover),
        ),
        footer: GridTileBar(
          leading: IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(ProductDetailScreen.routePath, arguments: id);
              },
              color: Theme.of(context).accentColor),
          backgroundColor: Colors.black87,
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
