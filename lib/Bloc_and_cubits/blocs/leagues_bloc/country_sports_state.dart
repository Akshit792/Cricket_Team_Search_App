import 'package:equatable/equatable.dart';
import 'package:test_application/data_layer/models/country_sports_data.dart';

enum CountrySportsDataStatus { initialdata, datafetched }

class CountrySportsStates extends Equatable {
  final CountrySportsDataStatus status;
  final List<CountrySportsData> countrySportsList;
  const CountrySportsStates(
      {required this.status, required this.countrySportsList});

  @override
  List<Object?> get props => [status, countrySportsList];
  CountrySportsStates copyyWith({
    required CountrySportsDataStatus status,
    required List<CountrySportsData> countrysportsDataList,
  }) {
    return CountrySportsStates(
      status: status,
      countrySportsList: countrysportsDataList,
    );
  }
}
