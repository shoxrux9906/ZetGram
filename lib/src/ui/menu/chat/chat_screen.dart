import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zet_gram/src/bloc/chat_block.dart';
import 'package:zet_gram/src/dialog/bottom_dialog.dart';
import 'package:zet_gram/src/model/chat_model.dart';
import 'package:zet_gram/src/theme/app_theme.dart';
import 'package:zet_gram/src/ui/menu/chat/chat_item_screen.dart';
import 'package:zet_gram/src/utils/styles.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    chatBlock.fetchAllChat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.screen,
      body: Column(
        children: [
          Container(
            height: 94,
            color: AppTheme.white,
            padding: EdgeInsets.only(
              top: 30,
              left: 25,
              right: 25,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Chats",
                    style: Styles.boldH1(AppTheme.dark),
                  ),
                ),
                SvgPicture.asset("assets/icons/more_vertical.svg"),
              ],
            ),
          ),
          Expanded(
            child: Theme(
              data: ThemeData(
                accentColor: Color(0xFF327FEB),
                canvasColor: Colors.transparent,
                textTheme: AppTheme.textTheme,
                platform: TargetPlatform.iOS,
              ),
              child: StreamBuilder(
                stream: chatBlock.allChat,
                builder: (BuildContext context,
                    AsyncSnapshot<List<ChatModel>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      padding: EdgeInsets.only(
                        top: 30,
                        bottom: 30,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Slidable(
                          key: Key(snapshot.data![index].id.toString()),
                          direction: Axis.horizontal,
                          actionExtentRatio: 1 / 5,
                          dismissal: SlidableDismissal(
                            onDismissed: (actionType) {},
                            child: SlidableDrawerDismissal(),
                          ),
                          actionPane: SlidableBehindActionPane(),
                          actions: [
                            Container(
                              margin: EdgeInsets.only(bottom: 40),
                              color: AppTheme.screen,
                              child: IconSlideAction(
                                iconWidget:
                                    SvgPicture.asset("assets/icons/trash.svg"),
                                onTap: () => {
                                  BottomDialog.deleteChat(context, index),
                                },
                                color: AppTheme.screen,
                              ),
                            ),
                          ],
                          secondaryActions: [
                            Container(
                              margin: EdgeInsets.only(bottom: 40),
                              color: AppTheme.screen,
                              child: IconSlideAction(
                                iconWidget:
                                    SvgPicture.asset("assets/icons/trash.svg"),
                                onTap: () => {
                                  BottomDialog.deleteChat(context, index),
                                },
                                color: AppTheme.screen,
                              ),
                            ),
                          ],
                          child: GestureDetector(
                            onTap: () {
                              BottomDialog.deleteChat(context, index);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ChatItemScreen(
                                      image: snapshot.data![index].image,
                                      name: snapshot.data![index].name,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                bottom: 40,
                              ),
                              padding: EdgeInsets.only(
                                left: 25,
                                right: 39,
                              ),
                              color: AppTheme.screen,
                              child: Row(
                                children: [
                                  Container(
                                    width: 52,
                                    height: 52,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(52),
                                      child: Hero(
                                        tag: snapshot.data![index],
                                        child: Image.asset(
                                          snapshot.data![index].image,
                                          width: 52,
                                          height: 52,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          snapshot.data![index].name,
                                          style: Styles.boldLabel(
                                            AppTheme.dark,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          snapshot.data![index].lastMessage,
                                          style: Styles.semiBoldContent(
                                            AppTheme.dark80,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  snapshot.data![index].unRead > 0
                                      ? Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            color: AppTheme.primary,
                                            borderRadius:
                                                BorderRadius.circular(24),
                                          ),
                                          child: Center(
                                            child: Text(
                                              snapshot.data![index].unRead
                                                  .toString(),
                                              style: Styles.boldContent(
                                                  AppTheme.white),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
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
                        top: 30,
                        bottom: 30,
                      ),
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 40),
                          padding: EdgeInsets.only(
                            left: 25,
                            right: 39,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 52,
                                height: 52,
                                decoration: BoxDecoration(
                                  color: AppTheme.white,
                                  borderRadius: BorderRadius.circular(52),
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 21,
                                      decoration: BoxDecoration(
                                        color: AppTheme.white,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                    SizedBox(height: 11,),
                                    Container(
                                      height: 16,
                                      decoration: BoxDecoration(
                                        color: AppTheme.white,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
