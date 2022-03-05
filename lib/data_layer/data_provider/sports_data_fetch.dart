import 'dart:convert';
import 'package:http/http.dart' as http;

// Provides SportsData from sportsApi
class SportsDataProvider {
  Future<Map<dynamic, dynamic>> fetchSportsdata() async {
    var response = await http.get(
        Uri.parse('https://www.thesportsdb.com/api/v1/json/2/all_sports.php'));
    Map<dynamic, dynamic> sportsMap = jsonDecode(response.body);
    // print(sports);
    return sportsMap;
  }

  Future<Map<dynamic, dynamic>> fetchSportsdataBasedOnCountry(
      String countryname) async {
    var response = await http.get(Uri.parse(
        'https://www.thesportsdb.com/api/v1/json/2/search_all_leagues.php?c=$countryname'));
    Map<dynamic, dynamic> countrySportsMap = jsonDecode(response.body);
    // print(sports);
    return countrySportsMap;
  }

  Future<Map<dynamic, dynamic>> fetchSerachedSportsdata(
      String sportName, String countryname) async {
    var response = await http.get(Uri.parse(
        'https://www.thesportsdb.com//api/v1/json/2/search_all_leagues.php?s=$sportName&c=$countryname'));
    Map<dynamic, dynamic> leagueCountrySportsMap = jsonDecode(response.body);
    print('this is the third api call from the user ${leagueCountrySportsMap}');
    // print(sports);
    return leagueCountrySportsMap;
  }
}
