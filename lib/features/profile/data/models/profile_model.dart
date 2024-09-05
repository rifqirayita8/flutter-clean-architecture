import '../../domain/entities/profile.dart';

class ProfileModel extends Profile {
  final String firstName;
  final String lastName;
  final String avatar;
  
  const ProfileModel({
    required super.id, 
    required super.email, 
    required this.firstName,
    required this.lastName,
    required this.avatar,
  }) : super(
    fullName: "$firstName $lastName",
    imgAvatar: avatar,
  );

  //Map->object
  factory ProfileModel.fromJson(Map<String, dynamic> data) {
    return ProfileModel(
      id: data['id'], 
      email: data['email'], 
      firstName: data['first_name'], 
      lastName: data['last_name'], 
      avatar: data['avatar']
    );
  }

  //object->Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'avatar': avatar,
    };
  }

  //List<Map<String, dynamic>>->List<ProfileModel>
  static List<ProfileModel> fromJsonList(List data) {
    if (data.isEmpty) return [];

    //Opsi 1: list
    // List<ProfileModel> allData=[];
    // for (var i= 0; i<data.length; i++) {
    //   Map<String, dynamic> singleDataProfile= data[i];
    //   allData.add(ProfileModel.fromJson(singleDataProfile));
    // }
    // return allData;

    //Opsi 2: map
    return data.map((singleDataProfile) => ProfileModel.fromJson(singleDataProfile)).toList();

  }
}