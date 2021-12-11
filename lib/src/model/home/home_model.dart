import 'package:zet_gram/src/model/home/story_model.dart';
import 'package:zet_gram/src/model/home/tape_model.dart';

class HomeModel {
  List<StoryModel> story;
  List<TapeModel> tape;

  HomeModel({
    required this.story,
    required this.tape,
  });
}
