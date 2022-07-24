import 'dart:convert';

import '../orders_model.dart';

class OrdersCategory {
  String? orderCategoryTitle;
  double? ordersTotal;
  int? ordersCount;
  List<Order>? orders;

  OrdersCategory(this.orderCategoryTitle, this.orders, this.ordersTotal, this.ordersCount,);

  OrdersCategory.fromJson(Map<String, dynamic> json) {
    ordersCount = int.parse(json['ordersCount'].toString(),);
    ordersTotal = double.parse(json['ordersTotal'].toString(),);
    orderCategoryTitle = json['orderCategoryTitle'].toString();
    orders = jsonDecode(json['orders'].toString(),);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['ordersCount'] = this.ordersCount;
    data['ordersTotal'] = this.ordersTotal;
    data['orderCategoryTitle'] = this.orderCategoryTitle;
    data['orders'] = this.orders.toString();
    return data;
  }
}
