import 'package:hive/hive.dart';

import '../../../../core/error/failure.dart';
import '../datasources/local_datasource.dart';
import '../datasources/remote_datasource.dart';
import '../models/profile_model.dart';
import '../../domain/entities/profile.dart';
import '../../domain/repositories/profile_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';

class ProfileRepositoryImplementation extends ProfileRepository {  
  final ProfileRemoteDataSource profileRemoteDataSource;
  final ProfileLocalDataSource profileLocalDataSource;
  final HiveInterface hive;

  ProfileRepositoryImplementation({
    required this.profileRemoteDataSource, 
    required this.profileLocalDataSource,
    required this.hive,
  });

  @override
  Future<Either<Failure, List<Profile>>> getAllUser(int page) async {
    try {
      final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult.contains(ConnectivityResult.none)) {
        List<ProfileModel> hasil= await profileLocalDataSource.getAllUser(page);

        return Right(hasil);
      } else {
        List<ProfileModel> hasil= await profileRemoteDataSource.getAllUser(page);
        var box= hive.box('profile_box');
        box.put('getAllUser', hasil);

        return Right(hasil);
      }
    }
    catch(e){
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, Profile>> getUser(int id) async {
    try {
      final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult.contains(ConnectivityResult.none)) {
        ProfileModel hasil= await profileLocalDataSource.getUser(id);

        return Right(hasil);
      } else {
        ProfileModel hasil= await profileRemoteDataSource.getUser(id);
        var box= hive.box('profile_box');
        box.put('getUser', hasil);

        return Right(hasil);
      }
    }
    catch(e){
      return Left(Failure());
    }
  }
}
