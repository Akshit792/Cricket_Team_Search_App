import 'package:equatable/equatable.dart';
import 'package:test_application/data_layer/models/sports_data.dart';

enum SportsDataStatus { initialdata, datafetched }

class SportsStates extends Equatable {
  final SportsDataStatus status;
  final List<SportsData> sportsDataList;
  const SportsStates(
      {this.status = SportsDataStatus.initialdata,
      this.sportsDataList = const <SportsData>[]});
  SportsStates copyWith({
    SportsDataStatus? status,
    List<SportsData>? sportsDataList,
  }) {
    return SportsStates(
      status: status ?? this.status,
      sportsDataList: sportsDataList ?? this.sportsDataList,
    );
  }

  @override
  List<Object> get props => [];
}
