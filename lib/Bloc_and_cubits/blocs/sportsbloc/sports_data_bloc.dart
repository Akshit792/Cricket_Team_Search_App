import 'package:bloc/bloc.dart';
import 'package:test_application/Bloc_and_cubits/blocs/sportsbloc/sport_bloc_state.dart';
import 'package:test_application/Bloc_and_cubits/blocs/sportsbloc/sports_bloc_event.dart';
import 'package:test_application/data_layer/models/sports_data.dart';
import '../../../data_layer/repository/sports_data_repository.dart';

class SportsBloc extends Bloc<SportsDataEvent, SportsStates> {
  final sportsDataRepository = SportsDataRepository();
  SportsBloc() : super(const SportsStates()) {
    on<SportsDataEvent>(_eventHandler);
  }
  // function that changes change state after fetching data
  Future<void> _eventHandler(event, emit) async {
    if (event is SportsDataFetched) {
      if (state.status == SportsDataStatus.initialdata) {
        var sportsDataList = await sportsDataRepository.convertSportsJsonData();
        // emitting the updated state
        emit(state.copyWith(
          status: SportsDataStatus.datafetched,
          sportsDataList: sportsDataList,
        ));
      }
    }
  }

  String SearchSportsImageBasedOnCountry(
      String sportName, List<SportsData> sportsList) {
    List<SportsData> list;
    list =
        sportsList.where((element) => element.sportName == sportName).toList();
    String imageUrl = sportsList[0].sportImageUrl;
    return imageUrl;
  }
}
