import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_application/Bloc_and_cubits/blocs/leagues_bloc/country_sports_bloc.dart';
import 'package:test_application/Bloc_and_cubits/blocs/sportsbloc/sport_bloc_state.dart';
import 'package:test_application/Bloc_and_cubits/blocs/sportsbloc/sports_bloc_event.dart';
import 'package:test_application/Bloc_and_cubits/blocs/sportsbloc/sports_data_bloc.dart';
import 'package:test_application/Bloc_and_cubits/cubits/sports_image_cubit.dart/sports_Image_cubit.dart';
import 'package:test_application/data_layer/repository/sports_data_repository.dart';
import 'package:test_application/presentation_layer/screens/language_home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SportsBloc>(
          create: (BuildContext context) => SportsBloc(),
        ),
        BlocProvider<CountrySportsBloc>(
          create: (BuildContext context) => CountrySportsBloc(),
        ),
        BlocProvider<SportsImageCubit>(
          create: (BuildContext context) => SportsImageCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final sportsDataRepository = SportsDataRepository();

  String value = 'Hello my friend computer';
  @override
  void initState() {
    BlocProvider.of<SportsBloc>(context).add(SportsDataFetched());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SportsBloc, SportsStates>(
        builder: (context, state) {
          switch (state.status) {
            case SportsDataStatus.initialdata:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case SportsDataStatus.datafetched:
              return BlocProvider.value(
                value: BlocProvider.of<SportsBloc>(context),
                child: HomeScreen(state.sportsDataList),
              );
            default:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }
}
