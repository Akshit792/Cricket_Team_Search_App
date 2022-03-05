import 'package:equatable/equatable.dart';

class SportsImageState extends Equatable {
  final String imageUrl;
  const SportsImageState({required this.imageUrl});
  @override
  List<Object?> get props => [imageUrl];
}
