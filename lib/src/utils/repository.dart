import 'package:zet_gram/src/database/database_helper_comment.dart';
import 'package:zet_gram/src/database/database_helper_images.dart';
import 'package:zet_gram/src/model/home/comment_model.dart';

class Repository {
  DatabaseHelperComment databaseHelperComment = new DatabaseHelperComment();
  DatabaseHelperImages databaseHelperImages = new DatabaseHelperImages();

  Future<List<CommentModel>> databaseItemTape(int id) =>
      databaseHelperComment.getProductsTapeId(id);

  Future<int> databaseItemSave(CommentModel card) =>
      databaseHelperComment.saveProducts(card);

  Future<List<String>> databaseImages() => databaseHelperImages.getProducts();
}
