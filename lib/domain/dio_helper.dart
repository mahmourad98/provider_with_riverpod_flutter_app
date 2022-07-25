import 'package:dio/dio.dart';

class DioHelper{
  static Dio init(){
    final Dio dio = Dio(
      BaseOptions(
        receiveDataWhenStatusError: false,
        setRequestContentTypeWhenNoPayload: false,
      )
    );
    return dio;
  }
}