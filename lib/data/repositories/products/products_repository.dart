import 'package:flutter_app/data/models/orders_model.dart';
import 'package:flutter_app/domain/orders/get_orders_domain.dart';

class OrdersRepository {
  const OrdersRepository();

  Future<List<Order>> getOrders(GetOrdersDomain getOrdersDomain,) async{
    final results = await getOrdersDomain.getAllCategories();
    final resultsAsModels = (results as List).map(
      (element,){
        return Order.fromJson(element,);
      }
    ).toList();
    //log('current orders: ${resultsAsModels.length}', name: "get orders from orders repository");
    return resultsAsModels;
  }
}