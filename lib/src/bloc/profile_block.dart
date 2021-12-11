import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:zet_gram/src/model/explore_model.dart';
import 'package:zet_gram/src/utils/repository.dart';

ProfileBlock profileBlock = ProfileBlock();

class ProfileBlock {
  final _repository = Repository();

  final _profileFetcher = PublishSubject<List<String>>();

  final _friendProfileFetcher = PublishSubject<List<ExploreModel>>();

  Observable<List<String>> get allProfile => _profileFetcher.stream;

  Observable<List<ExploreModel>> get allProfileFriend =>
      _friendProfileFetcher.stream;

  fetchAllProfile() async {
    List<String> images = await _repository.databaseImages();
    _profileFetcher.sink.add(images);
  }

  fetchAllProfileFriend() async {
    Timer(
      Duration(milliseconds: 1000),
      () {
        _friendProfileFetcher.sink.add(explore);
      },
    );
  }

  dispose() {
    _profileFetcher.close();
    _friendProfileFetcher.close();
  }

  List<ExploreModel> explore = [
    ExploreModel(
      id: 4,
      image: "assets/explore/four.png",
    ),
    ExploreModel(
      id: 1,
      image: "assets/explore/one.png",
    ),
    ExploreModel(
      id: 2,
      image: "assets/explore/two.png",
    ),
    ExploreModel(
      id: 3,
      image: "assets/explore/three.png",
    ),
    ExploreModel(
      id: 5,
      image: "assets/explore/five.png",
    ),
    ExploreModel(
      id: 6,
      image: "assets/explore/six.png",
    ),
    ExploreModel(
      id: 7,
      image: "assets/explore/seven.png",
    ),
    ExploreModel(
      id: 8,
      image: "assets/explore/eight.png",
    ),
    ExploreModel(
      id: 9,
      image: "assets/explore/nine.png",
    ),
    ExploreModel(
      id: 10,
      image: "assets/explore/ten.png",
    ),
    ExploreModel(
      id: 11,
      image: "assets/explore/eleven.png",
    ),
    ExploreModel(
      id: 12,
      image: "assets/explore/twelve.png",
    ),
    ExploreModel(
      id: 13,
      image: "assets/explore/thirteen.png",
    ),
    ExploreModel(
      id: 14,
      image: "assets/explore/fourteen.png",
    ),
  ];
}
