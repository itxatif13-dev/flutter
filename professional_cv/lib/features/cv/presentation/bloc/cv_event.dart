part of 'cv_bloc.dart';

abstract class CVEvent extends Equatable {
  const CVEvent();

  @override
  List<Object> get props => [];
}

class GetCVDataEvent extends CVEvent {}
