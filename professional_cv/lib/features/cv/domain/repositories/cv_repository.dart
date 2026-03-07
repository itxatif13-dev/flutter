import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/cv_entity.dart';

abstract class CVRepository {
  Future<Either<Failure, CVEntity>> getCVData();
}
