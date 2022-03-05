import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_application/Bloc_and_cubits/blocs/leagues_bloc/country_sports_bloc.dart';
import 'package:test_application/Bloc_and_cubits/blocs/leagues_bloc/country_sports_event.dart';
import 'package:test_application/Bloc_and_cubits/blocs/sportsbloc/sports_data_bloc.dart';
import 'package:test_application/data_layer/models/sports_data.dart';

import '../../data_layer/models/country_sports_data.dart';

class SportsListWidget extends StatefulWidget {
  final bool isEmpty;
  final List<SportsData> sportsList;
  final List<CountrySportsData> countrySportsList;
  final String countryName;
  const SportsListWidget(
      this.isEmpty, this.sportsList, this.countrySportsList, this.countryName,
      {Key? key})
      : super(key: key);

  @override
  State<SportsListWidget> createState() => _SportsListWidgetState();
}

class _SportsListWidgetState extends State<SportsListWidget> {
  final TextEditingController searchcontroller = TextEditingController();
  @override
  void initState() {
    searchcontroller.addListener(() {
      BlocProvider.of<CountrySportsBloc>(context).add(SportsDataSearched(
          sportsName: searchcontroller.text, countryName: widget.countryName));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  )),
              Flexible(
                child: Form(
                    child: Container(
                  margin: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  height: 50,
                  width: double.infinity,
                  child: TextFormField(
                    controller: searchcontroller,
                    decoration: InputDecoration(
                        fillColor: Colors.grey[300],
                        filled: true,
                        hintText: 'Search',
                        hintStyle: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black))),
                  ),
                )),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          if (widget.isEmpty)
            const Center(
              child: CircularProgressIndicator(),
            ),
          if (!widget.isEmpty)
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.countrySportsList.length,
              itemBuilder: (BuildContext context, int index) {
                String url = BlocProvider.of<SportsBloc>(context)
                    .SearchSportsImageBasedOnCountry(
                        widget.countrySportsList[index].strSports,
                        widget.sportsList);
                return Container(
                  margin: const EdgeInsets.fromLTRB(50, 0, 50, 20),
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
                        child: Text(
                          widget.countrySportsList[index].strLeague,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(url))),
                );
              },
            ),
        ],
      ),
    );
  }
}
