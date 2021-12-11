import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:zet_gram/src/model/chat_item_model.dart';
import 'package:zet_gram/src/model/chat_model.dart';

ChatBlock chatBlock = ChatBlock();

class ChatBlock {
  final _chatFetcher = PublishSubject<List<ChatModel>>();
  final _chatItemFetcher = PublishSubject<List<ChatItemModel>>();

  Observable<List<ChatModel>> get allChat => _chatFetcher.stream;

  Observable<List<ChatItemModel>> get allChatItem => _chatItemFetcher.stream;

  fetchAllChat() async {
    Timer(Duration(milliseconds: 1000), () {
      _chatFetcher.sink.add(chat);
    });
  }

  fetchDeleteItem(int index) async {
    chat.removeAt(index);
    _chatFetcher.sink.add(chat);
  }

  fetchUserMessage() async {
    Timer(Duration(milliseconds: 1000), () {
      _chatItemFetcher.sink.add(userMessage);
    });
  }

  fetchSentUserMessage(ChatItemModel chatItemModel) {
    userMessage.insert(0, chatItemModel);
    _chatItemFetcher.sink.add(userMessage);
  }

  _dispose() {
    _chatFetcher.close();
    _chatItemFetcher.close();
  }

  List<ChatItemModel> userMessage = [
    ChatItemModel(
      id: 0,
      message: "I'm at the office right now",
      time: "13.12",
      isMe: true,
    ),
    ChatItemModel(
      id: 1,
      message: "Thanks once again",
      time: "21.02",
      isMe: false,
    ),
    ChatItemModel(
      id: 2,
      message: "You are welcome",
      time: "05.35",
      isMe: true,
    ),
    ChatItemModel(
      id: 3,
      message: "Where are you at right now",
      time: "13.46",
      isMe: false,
    ),
    ChatItemModel(
      id: 4,
      message: "Hey! Thank your for the coupons!",
      time: "21.24",
      isMe: true,
    ),
  ];

  List<ChatModel> chat = [
    ChatModel(
      id: 0,
      name: "Alan Walker",
      image: "assets/images/alan_walker.png",
      lastMessage: "I'm at the office right now",
      unRead: 2,
    ),
    ChatModel(
      id: 1,
      name: "Anna Jamil",
      image: "assets/images/anna_jamil.png",
      lastMessage: "It's pretty cheap i think and so pretty",
      unRead: 1,
    ),
    ChatModel(
      id: 2,
      name: "Leo Messi",
      image: "assets/images/messi.png",
      lastMessage: "I'm okay, how about you",
      unRead: 3,
    ),
    ChatModel(
      id: 3,
      name: "Alan Walker",
      image: "assets/images/alan_walker.png",
      lastMessage: "Maybe I can help you tomorrow or after tomorrow",
      unRead: 0,
    ),
    ChatModel(
      id: 4,
      name: "Thor",
      image: "assets/images/thor.png",
      lastMessage: "Yes of course, I like that very much",
      unRead: 2,
    ),
    ChatModel(
      id: 4,
      name: "James Person",
      image: "assets/images/james_person.png",
      lastMessage: "Can your friends do it tonight",
      unRead: 2,
    ),
  ];
}
