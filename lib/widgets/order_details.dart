import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/orders.dart';
import 'package:intl/intl.dart';

class OrdersDetails extends StatelessWidget {
  final OrderItem order;

  OrdersDetails(this.order);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${order.amount}'),
            subtitle:
                Text(DateFormat('dd MM yyyy hh:mm').format(order.dataTime)),
            trailing: Icon(Icons.expand_more),
            onLongPress: () {},
          )
        ],
      ),
    );
  }
}
