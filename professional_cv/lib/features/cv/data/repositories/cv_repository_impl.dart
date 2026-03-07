import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/cv_entity.dart';
import '../../domain/repositories/cv_repository.dart';
import '../datasources/cv_local_data_source.dart';

class CVRepositoryImpl implements CVRepository {
  final CVLocalDataSource localDataSource;

  CVRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, CVEntity>> getCVData() async {
    try {
      final localData = await localDataSource.getCVData();
      return Right(localData);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
