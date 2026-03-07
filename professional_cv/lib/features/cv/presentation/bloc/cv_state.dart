part of 'cv_bloc.dart';

abstract class CVState extends Equatable {
  const CVState();

  @override
  List<Object> get props => [];
}

class CVInitial extends CVState {}

class CVLoading extends CVState {}

class CVLoaded extends CVState {
  final CVEntity cvData;

  const CVLoaded({required this.cvData});

  @override
  List<Object> get props => [cvData];
}

class CVError extends CVState {
  final String message;

  const CVError({required this.message});

  @override
  List<Object> get props => [message];
}
