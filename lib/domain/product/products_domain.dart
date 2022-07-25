import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

abstract class ProductsDomain<T>{
  final Dio dioHelper;

  const ProductsDomain({
    required this.dioHelper,
  });

  T getAllProducts();
}

class ProductsFromApiDomain extends ProductsDomain<Future>{

  ProductsFromApiDomain({required Dio dioHelper,}) : super(dioHelper: dioHelper,);

  @override
  Future<List<Map<String, dynamic>>> getAllProducts() async{
    try {
      final Response<dynamic> response = await this.dioHelper.get(
        "https://api.storerestapi.com/products",
      );
      final resultData = response.data['data'];
      //log(response.data.toString(), name: "getAllProducts/ProductsFromApiDomain",);
      List<Map<String, dynamic>>? resultAsListOfMap = resultData?.map<Map<String, dynamic>>(
        (element,){
          return element as Map<String, dynamic>;
        },
      ).toList();
      //log(resultAsListOfMap.toString(), name: "getOrdersFromApi",);
      throwIf((resultAsListOfMap == null), Exception("result is null",),);
      log("getting the data was successful", name: "getAllProducts/ProductsFromApiDomain",);
      return resultAsListOfMap!;
    }
    catch(exception){
      log(
        "error happened while getting the data, ${exception.toString()}",
        name: "getProductsFromApi Class",
      );
      return [];
    }
  }
}