import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zet_gram/src/bloc/chat_block.dart';
import 'package:zet_gram/src/model/chat_item_model.dart';
import 'package:zet_gram/src/theme/app_theme.dart';
import 'package:zet_gram/src/utils/styles.dart';

class ChatItemScreen extends StatefulWidget {
  final String image;
  final String name;

  ChatItemScreen({
    required this.image,
    required this.name,
  });

  @override
  _ChatItemScreenState createState() => _ChatItemScreenState();
}

class _ChatItemScreenState extends State<ChatItemScreen> {
  TextEditingController chatController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  bool isSend = false;

  _ChatItemScreenState() {
    chatController.addListener(() {
      if (chatController.text.length > 0) {
        setState(() {
          isSend = true;
        });
      } else {
        setState(() {
          isSend = false;
        });
      }
    });
  }

  @override
  void initState() {
    chatBlock.fetchUserMessage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.screen,
      body: Column(
        children: [
          Container(
            height: 125,
            color: AppTheme.white,
            padding: EdgeInsets.only(
              left: 25,
              right: 25,
              bottom: 20,
            ),
            child: Column(
              children: [
                Expanded(child: Container()),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset("assets/icons/arrow_left.svg"),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 16,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(52),
                        child: Image.asset(
                          widget.image,
                          width: 52,
                          height: 52,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.name,
                            style: Styles.boldLabel(AppTheme.dark),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "@${widget.name.toLowerCase().replaceAll(" ", "")}",
                            style: Styles.semiBoldContent(AppTheme.dark80),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: chatBlock.allChatItem,
              builder: (BuildContext context,
                  AsyncSnapshot<List<ChatItemModel>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    padding: EdgeInsets.only(
                      left: 25,
                      right: 25,
                    ),
                    itemCount: snapshot.data!.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      return Align(
                        alignment: snapshot.data![index].isMe
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: snapshot.data![index].isMe
                              ? EdgeInsets.only(
                                  top: 35,
                                  left: 25,
                                )
                              : EdgeInsets.only(
                                  top: 30,
                                  right: 25,
                                ),
                          padding: EdgeInsets.only(
                            top: 7,
                            left: 15,
                            right: 15,
                            bottom: 7,
                          ),
                          decoration: BoxDecoration(
                            color: snapshot.data![index].isMe
                                ? AppTheme.primary
                                : AppTheme.white,
                            borderRadius: snapshot.data![index].isMe
                                ? BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  )
                                : BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                          ),
                          child: Column(
                            crossAxisAlignment: snapshot.data![index].isMe
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data![index].message,
                                textAlign: snapshot.data![index].isMe
                                    ? TextAlign.right
                                    : TextAlign.left,
                                style: Styles.semiBoldContent(
                                  snapshot.data![index].isMe
                                      ? AppTheme.white
                                      : AppTheme.dark,
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                snapshot.data![index].time,
                                textAlign: snapshot.data![index].isMe
                                    ? TextAlign.right
                                    : TextAlign.right,
                                style: Styles.regularContent(
                                    snapshot.data![index].isMe
                                        ? AppTheme.white
                                        : AppTheme.dark),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                return Shimmer.fromColors(
                  baseColor: AppTheme.shimmerBase,
                  highlightColor: AppTheme.shimmerHighlight,
                  child: ListView.builder(
                    padding: EdgeInsets.only(
                      left: 25,
                      right: 25,
                    ),
                    itemCount: 25,
                    reverse: true,
                    itemBuilder: (context, index) {
                      Random random = new Random();
                      int randomNumber = random.nextInt(25) + 50;
                      return Align(
                        alignment: randomNumber % 2 == 0
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          height: randomNumber.toDouble(),
                          margin: randomNumber % 2 == 0
                              ? EdgeInsets.only(
                                  top: 30,
                                  left: 35,
                                )
                              : EdgeInsets.only(
                                  top: 30,
                                  right: 35,
                                ),
                          padding: EdgeInsets.only(
                            top: 7,
                            left: 15,
                            right: 15,
                            bottom: 7,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.white,
                            borderRadius: randomNumber % 2 == 0
                                ? BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  )
                                : BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Container(
            height: 120,
            color: AppTheme.white,
            padding: EdgeInsets.only(
              top: 20,
              left: 25,
              right: 25,
              bottom: 48,
            ),
            child: Container(
              padding: EdgeInsets.only(
                top: 15,
                bottom: 15,
                left: 20,
                right: 20,
              ),
              decoration: BoxDecoration(
                color: AppTheme.grey20,
                borderRadius: BorderRadius.circular(26),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/icons/smile.svg"),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: chatController,
                      textAlignVertical: TextAlignVertical.center,
                      style: Styles.semiBoldContent(AppTheme.dark),
                      decoration: InputDecoration.collapsed(
                        hintText: "Type your messages ...",
                        hintStyle: Styles.regularContent(AppTheme.dark60),
                        border: InputBorder.none,
                      ),
                      focusNode: focusNode,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      var now = new DateTime.now();
                      if (isSend) {
                        chatBlock.fetchSentUserMessage(
                          ChatItemModel(
                            id: 0,
                            message: chatController.text,
                            time: _toTwoDigitString(now.hour) +
                                ":" +
                                _toTwoDigitString(now.minute),
                            isMe: true,
                          ),
                        );
                        setState(() {
                          chatController.text = "";
                        });
                      }
                    },
                    child: !isSend
                        ? SvgPicture.asset("assets/icons/not_send.svg")
                        : SvgPicture.asset("assets/icons/send.svg"),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _toTwoDigitString(int value) {
    return value.toString().padLeft(2, "0");
  }
}
