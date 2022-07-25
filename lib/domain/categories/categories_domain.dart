import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

abstract class CategoriesDomain<T>{
  final Dio dioHelper;

  const CategoriesDomain({
    required this.dioHelper,
  });

  T getAllCategories();
}

class CategoriesFromApiDomain extends CategoriesDomain<Future>{
  const CategoriesFromApiDomain({required Dio dioHelper,}) : super(dioHelper: dioHelper,);

  @override
  Future<List<Map<String, dynamic>>> getAllCategories() async{
    try {
      final Response<dynamic> response = await this.dioHelper.get(
        "https://api.storerestapi.com/categories",
      );
      final resultData = response.data['data'];
      //log(resultData.toString(), name: "getAllCategories/CategoriesFromApiDomain",);
      List<Map<String, dynamic>>? resultAsListOfMap = resultData?.map<Map<String, dynamic>>(
        (element,){
          return element as Map<String, dynamic>;
        },
      ).toList();
      throwIf((resultAsListOfMap == null), Exception("result is null",),);
      log("getting the data was successful", name: "getAllCategories/CategoriesFromApiDomain",);
      return resultAsListOfMap!;
    }
    catch(exception){
      log(
        "error happened while getting the data, ${exception.toString()}",
        name: "getAllCategories/CategoriesFromApiDomain",
      );
      return [];
    }
  }
}