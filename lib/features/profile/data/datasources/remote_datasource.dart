import 'package:clean_architecture/core/error/exception.dart';

import '../models/profile_model.dart';
import 'package:dio/dio.dart';

abstract class ProfileRemoteDataSource {
  Future<List<ProfileModel>> getAllUser(int page);
  Future<ProfileModel> getUser(int id);
}

class ProfileRemoteDataSourceImplementation extends ProfileRemoteDataSource {
  @override
  Future<List<ProfileModel>> getAllUser(int page) async {
    final dio = Dio();
    final response= await dio.get('https://reqres.in/api/users?page=$page');

    if (response.statusCode == 200) {
      Map<String, dynamic> dataBody= response.data as Map<String, dynamic>;
      List<dynamic> data = dataBody['data'];
      return ProfileModel.fromJsonList(data);
    } else if (response.statusCode == 404) {
      throw const EmptyException(message: '404 not found');
    } else {
      throw const GeneralException(message: 'Cannot get data');
    }
  }

  @override
  Future<ProfileModel> getUser(int id) async {
    final dio= Dio();
    final response = await dio.get('https://reqres.in/api/users/$id');

    if (response.statusCode == 200) {
      Map<String, dynamic> dataBody = response.data as Map<String, dynamic>;
      Map<String, dynamic> data= dataBody['data'];
      return ProfileModel.fromJson(data);
    } else if (response.statusCode == 404) {
      throw const EmptyException(message: '404 not found');
    } else {
      throw const GeneralException(message: 'Cannot get data');
    }
  }
  
}