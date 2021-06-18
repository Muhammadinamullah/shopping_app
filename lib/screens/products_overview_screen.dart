import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/products.dart';
import '../providers/cart.dart';
import '../screens/cart_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/badge.dart';
import 'package:provider/provider.dart';

import '../widgets/products_grid.dart';

enum filterOptions { Favorites, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isloading = false;

  @override
  void initState() {
    print("product overview screen");

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isloading = true;
      });
      _isloading = true;
      Provider.of<Products>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isloading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    // final productsItems = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
              onSelected: (filterOptions selectedValue) {
                setState(() {
                  if (selectedValue == filterOptions.Favorites) {
                    _showOnlyFavorites = true;
                    // productsItems.showFavoritesOnly();
                  } else {
                    _showOnlyFavorites = false;
                    // productsItems.showAll();
                  }
                });
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
                  ]),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routePath);
              },
            ),
          ),
        ],
        title: Text('MyShop'),
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => refreshProducts(context),
        child: _isloading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ProductsGrid(_showOnlyFavorites),
      ),
    );
  }
}
