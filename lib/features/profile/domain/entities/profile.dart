import 'package:equatable/equatable.dart';

class Profile extends Equatable{
  final int id;
  final String email;
  final String fullName;
  final String imgAvatar;

  const Profile({
    required this.id,
    required this.email,
    required this.fullName,
    required this.imgAvatar,
  });
  
  @override
  List<Object?> get props => [
    id,
    email,
    fullName,
    imgAvatar,
  ];
}