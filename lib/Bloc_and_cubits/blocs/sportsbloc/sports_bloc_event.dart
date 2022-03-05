import 'package:equatable/equatable.dart';

abstract class SportsDataEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SportsDataFetched extends SportsDataEvent {}

class SearchImageBasedOnSportsName extends SportsDataEvent {}
