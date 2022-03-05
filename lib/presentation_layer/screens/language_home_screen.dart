import 'package:flutter/material.dart';
import 'package:test_application/data_layer/repository/sports_data_repository.dart';
import 'package:test_application/presentation_layer/screens/country_sports_screen.dart';
import '../../data_layer/models/sports_data.dart';

class HomeScreen extends StatefulWidget {
  final List<SportsData> sportsList;

  const HomeScreen(this.sportsList, {Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final List languageList = [
      'India',
      'UnitedStates',
      'China',
      'Australia',
      'Argentina'
    ];
    return Scaffold(
      backgroundColor: Colors.red[900],
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.3,
            width: double.infinity,
            child: const Center(
                child: Text(
              'The SportsDb',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            )),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: languageList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.fromLTRB(screenWidth * 0.02, 0,
                    screenWidth * 0.02, screenHeight * 0.03),
                height: screenHeight * 0.08,
                width: screenWidth * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red[400],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: screenWidth * 0.001,
                    ),
                    SizedBox(
                        width: 100,
                        child: Text(
                          languageList[index],
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )),
                    const SizedBox(
                      width: 50,
                    ),
                    IconButton(
                      onPressed: () {
                        SportsDataRepository()
                            .convertCountrySportsJsonData(languageList[index]);
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return CountrySportsScreen(
                              widget.sportsList, languageList[index]);
                        }));
                      },
                      icon: const Icon(Icons.arrow_forward),
                    ),
                    SizedBox(
                      width: screenWidth * 0.001,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
