import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../utilities/get_it_service_locator.dart';

abstract class GetCategoriesDomain<T>{
  T getAllCategories();
}

class GetCategoriesFromApiDomain extends GetCategoriesDomain<Future>{
  @override
  Future<List<Map<String, dynamic>>> getAllCategories() async{
    try {
      final Response<List> response = await getItServiceLocator.get<Dio>().get(
        "https://api.storerestapi.com/categories",
      );
      final resultData = response.data;
      //log(response.data.toString(), name: "getOrdersFromApi",);
      List<Map<String, dynamic>>? resultAsListOfMap = resultData?.map<Map<String, dynamic>>(
        (element,){
          return element as Map<String, dynamic>;
        },
      ).toList();
      //log(resultAsListOfMap.toString(), name: "getOrdersFromApi",);
      throwIf((resultAsListOfMap == null), Exception("result is null",),);
      return resultAsListOfMap!;
    }
    catch(exception){
      log(
        "error happened while getting the data, ${exception.toString()}",
        name: "getCategoriesFromApi Class",
      );
      return [];
    }
  }
}