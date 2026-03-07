import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/cv_entity.dart';
import '../../domain/repositories/cv_repository.dart';

part 'cv_event.dart';
part 'cv_state.dart';

class CVBloc extends Bloc<CVEvent, CVState> {
  final CVRepository repository;

  CVBloc({required this.repository}) : super(CVInitial()) {
    on<GetCVDataEvent>((event, emit) async {
      emit(CVLoading());
      final result = await repository.getCVData();
      result.fold(
        (failure) => emit(const CVError(message: 'Failed to load CV data')),
        (cvData) => emit(CVLoaded(cvData: cvData)),
      );
    });
  }
}
