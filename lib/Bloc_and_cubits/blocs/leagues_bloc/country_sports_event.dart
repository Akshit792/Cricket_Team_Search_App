import 'package:equatable/equatable.dart';

abstract class CountrySportsDataEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CountrySportsDataFetched extends CountrySportsDataEvent {
  final String countryName;
  CountrySportsDataFetched({required this.countryName});
  @override
  List<Object> get props => [countryName];
}

class SportsDataSearched extends CountrySportsDataEvent {
  final String sportsName;
  final String countryName;
  SportsDataSearched({required this.sportsName, required this.countryName});
  @override
  List<Object> get props => [sportsName, countryName];
}
