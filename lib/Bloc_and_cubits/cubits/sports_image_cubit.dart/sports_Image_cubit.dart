import 'package:bloc/bloc.dart';
import 'package:test_application/Bloc_and_cubits/cubits/sports_image_cubit.dart/sports_image_state.dart';

import '../../../data_layer/models/sports_data.dart';

class SportsImageCubit extends Cubit<SportsImageState> {
  SportsImageCubit() : super(const SportsImageState(imageUrl: ''));

  void searchSportsImageBasedOnCountry(
      String sportName, List<SportsData> sportsList) {
    List<SportsData> list;
    list =
        sportsList.where((element) => element.sportName == sportName).toList();
    String imageUrl = list[0].sportImageUrl;
    print(imageUrl);
    emit(SportsImageState(imageUrl: imageUrl));
  }
}
