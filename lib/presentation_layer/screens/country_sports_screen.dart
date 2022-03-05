import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_application/Bloc_and_cubits/blocs/leagues_bloc/country_sports_bloc.dart';
import 'package:test_application/Bloc_and_cubits/blocs/leagues_bloc/country_sports_event.dart';
import 'package:test_application/Bloc_and_cubits/blocs/leagues_bloc/country_sports_state.dart';
import 'package:test_application/Bloc_and_cubits/blocs/sportsbloc/sports_data_bloc.dart';
import 'package:test_application/data_layer/models/sports_data.dart';
import 'package:test_application/presentation_layer/widgets/sports_list_widget.dart';

class CountrySportsScreen extends StatefulWidget {
  final List<SportsData> Sportslist;
  final String countryName;
  const CountrySportsScreen(this.Sportslist, this.countryName, {Key? key})
      : super(key: key);

  @override
  State<CountrySportsScreen> createState() => _CountrySportsScreenState();
}

class _CountrySportsScreenState extends State<CountrySportsScreen> {
  final TextEditingController sportsTextEditingController =
      TextEditingController();
  @override
  void initState() {
    BlocProvider.of<CountrySportsBloc>(context)
        .add(CountrySportsDataFetched(countryName: widget.countryName));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<CountrySportsBloc, CountrySportsStates>(
          builder: (context, state) {
            switch (state.status) {
              case CountrySportsDataStatus.initialdata:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case CountrySportsDataStatus.datafetched:
                if (state.countrySportsList.isEmpty) {
                  print(state.countrySportsList.length);
                  return SportsListWidget(true, widget.Sportslist,
                      state.countrySportsList, widget.countryName);
                } else {
                  return SportsListWidget(false, widget.Sportslist,
                      state.countrySportsList, widget.countryName);
                }

              default:
                return const Center(
                  child: CircularProgressIndicator(),
                );
            }
          },
        ),
      ),
    );
  }
}
