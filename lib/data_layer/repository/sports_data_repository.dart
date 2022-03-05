import 'package:test_application/data_layer/data_provider/sports_data_fetch.dart';
import 'package:test_application/data_layer/models/country_sports_data.dart';
import 'package:test_application/data_layer/models/sports_data.dart';

class SportsDataRepository {
  final sportsDataProvider = SportsDataProvider();

  // converts the jsonSportsData into our modeldata format
  Future<List<SportsData>> convertSportsJsonData() async {
    List<SportsData> sportsDatalist = [];
    Map<dynamic, dynamic> jsonSportsMap =
        await sportsDataProvider.fetchSportsdata();
    int sportsdatalength = jsonSportsMap['sports'].length;
    for (int i = 0; i < sportsdatalength; i++) {
      sportsDatalist.add(SportsData(
          sportName: jsonSportsMap['sports'][i]['strSport'],
          sportImageUrl: jsonSportsMap['sports'][i]['strSportThumb']));
    }
    return sportsDatalist;
  }

  Future<List<CountrySportsData>> convertCountrySportsJsonData(
      String countryName) async {
    List<CountrySportsData> countrySportsDatalist = [];
    Map<dynamic, dynamic> jsonSportsMap =
        await sportsDataProvider.fetchSportsdataBasedOnCountry(countryName);
    int sportsdatalength = jsonSportsMap['countrys'].length;
    for (int i = 0; i < sportsdatalength; i++) {
      countrySportsDatalist.add(CountrySportsData(
        strSports: jsonSportsMap['countrys'][i]['strSport'],
        strLeague: jsonSportsMap['countrys'][i]['strLeague'],
        desciption: jsonSportsMap['countrys'][i]['strDescriptionEN'],
      ));
    }
    return countrySportsDatalist;
  }

  Future<List<CountrySportsData>> convertSearchedCountrySportsJsonData(
      String sportsName, String countryName) async {
    List<CountrySportsData> searchedCountrySportsDatalist = [];
    Map<dynamic, dynamic> jsonSportsMap = await sportsDataProvider
        .fetchSerachedSportsdata(sportsName, countryName);
    if (jsonSportsMap['countrys'] == null) {
      return [];
    } else {
      int sportsdatalength = jsonSportsMap['countrys'].length;
      for (int i = 0; i < sportsdatalength; i++) {
        searchedCountrySportsDatalist.add(CountrySportsData(
          strSports: jsonSportsMap['countrys'][i]['strSport'],
          strLeague: jsonSportsMap['countrys'][i]['strLeague'],
          desciption: jsonSportsMap['countrys'][i]['strDescriptionEN'],
        ));
      }
      return searchedCountrySportsDatalist;
    }
  }
}
