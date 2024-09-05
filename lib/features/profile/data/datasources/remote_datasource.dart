import 'dart:convert';

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

    Map<String, dynamic> dataBody= response.data as Map<String, dynamic>;
    List<dynamic> data = dataBody['data'];
    return ProfileModel.fromJsonList(data);
  }

  @override
  Future<ProfileModel> getUser(int id) async {
    final dio= Dio();
    final response = await dio.get('https://reqres.in/api/users/$id');

    Map<String, dynamic> dataBody = jsonDecode(response.data);
    Map<String, dynamic> data= dataBody['data'];
    return ProfileModel.fromJson(data);
  }
  
}

//Uri url= Uri.parse('https://reqres.in/api/users?page=$page');
//var response= await http.get(url);


//Map<String, dynamic> dataBody= jsonDecode(response.body);
//List<dynamic> data = dataBody['data'];
//return ProfileModel.fromJsonList(data);