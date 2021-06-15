import 'package:flutter/material.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String ImageUrl;

  UserProductItem(this.title, this.ImageUrl);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(title),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(ImageUrl),
        ),
        trailing: Container(
          width: 100,
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                color: Theme.of(context).primaryColor,
                icon: Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {},
                color: Theme.of(context).errorColor,
                icon: Icon(Icons.delete),
              )
            ],
          ),
        ));
  }
}
