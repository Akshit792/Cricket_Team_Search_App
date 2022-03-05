import 'package:bloc/bloc.dart';
import 'package:test_application/Bloc_and_cubits/blocs/leagues_bloc/country_sports_event.dart';
import 'package:test_application/Bloc_and_cubits/blocs/leagues_bloc/country_sports_state.dart';
import 'package:test_application/data_layer/models/country_sports_data.dart';
import '../../../data_layer/repository/sports_data_repository.dart';

class CountrySportsBloc
    extends Bloc<CountrySportsDataEvent, CountrySportsStates> {
  final sportsDataRepository = SportsDataRepository();
  CountrySportsBloc()
      : super(const CountrySportsStates(
            status: CountrySportsDataStatus.initialdata,
            countrySportsList: <CountrySportsData>[])) {
    on<CountrySportsDataEvent>(_eventHandler);
  }
  Future<void> _eventHandler(
      CountrySportsDataEvent event, Emitter<CountrySportsStates> emit) async {
    if (event is CountrySportsDataFetched) {
      if (state.status == CountrySportsDataStatus.initialdata) {
        var countrySportsDataList = await sportsDataRepository
            .convertCountrySportsJsonData(event.countryName);
        // emitting the updated state
        emit(state.copyyWith(
            status: CountrySportsDataStatus.datafetched,
            countrysportsDataList: countrySportsDataList));
      }
    } else if (event is SportsDataSearched) {
      List<CountrySportsData> searchedSportsDataList =
          await SportsDataRepository().convertSearchedCountrySportsJsonData(
              event.sportsName, event.countryName);

      emit(state.copyyWith(
          status: CountrySportsDataStatus.datafetched,
          countrysportsDataList: searchedSportsDataList));
    }
  }
}
