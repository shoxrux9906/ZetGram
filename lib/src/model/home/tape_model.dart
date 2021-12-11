import 'package:zet_gram/src/model/home/comment_model.dart';

class TapeModel {
  int id;
  String userImage;
  String userName;
  String message;
  String image;
  int count;
  bool isFavorite;
  List<CommentModel> comments;
  String time;

  TapeModel({
    required this.id,
    required this.userImage,
    required this.userName,
    required this.message,
    required this.image,
    required this.count,
    required this.isFavorite,
    required this.comments,
    required this.time,
  });
}
