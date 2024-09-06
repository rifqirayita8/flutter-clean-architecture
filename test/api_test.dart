import 'package:clean_architecture/features/profile/data/datasources/remote_datasource.dart';

void main() async {
  final ProfileRemoteDataSourceImplementation profileRemoteDataSourceImplementation = ProfileRemoteDataSourceImplementation();

  try {
    var response= await profileRemoteDataSourceImplementation.getUser(1);

    print(response.toJson());
  } catch(e) {
    print(e);
  }
}