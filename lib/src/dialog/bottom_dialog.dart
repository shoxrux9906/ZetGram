import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rxbus/rxbus.dart';
import 'package:zet_gram/src/bloc/chat_block.dart';
import 'package:zet_gram/src/bloc/home_bloc.dart';
import 'package:zet_gram/src/database/database_helper_comment.dart';
import 'package:zet_gram/src/model/bus/loding_model.dart';
import 'package:zet_gram/src/model/home/comment_model.dart';
import 'package:zet_gram/src/theme/app_theme.dart';
import 'package:zet_gram/src/utils/styles.dart';
import 'package:zet_gram/src/utils/utils.dart';

class BottomDialog {
  static void sendComplain(
      BuildContext context, String title, String content, String btnText) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext contex, setState) {
              return Container(
                height: 487,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: AppTheme.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: 114,
                      height: 5,
                      decoration: BoxDecoration(
                        color: AppTheme.grey20,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      width: 78,
                      height: 78,
                      child: SvgPicture.asset("assets/icons/failed.svg"),
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    Text(
                      "$title",
                      style: Styles.boldH2(AppTheme.dark),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, left: 25, right: 25),
                      child: Text(
                        "$content",
                        style: Styles.regularLabel(
                          AppTheme.dark80,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            RxBus.post(LoadingModel(loading: false),
                                tag: "EVENT_LOADING_LOGIN");
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 56,
                            margin: EdgeInsets.only(
                              top: 58,
                              left: 25,
                              right: 25,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.primary,
                              borderRadius: BorderRadius.circular(28),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 6),
                                    spreadRadius: 0,
                                    blurRadius: 75,
                                    color: Color.fromRGBO(100, 87, 87, 0.05)),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                "$btnText",
                                style: Styles.boldButton(AppTheme.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        });
  }

  static void deleteChat(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return Container(
              height: 487,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
                color: AppTheme.white,
              ),
              child: Column(
                children: [
                  Container(
                    height: 5,
                    width: 114,
                    margin: EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: AppTheme.grey20,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    height: 78,
                    width: 78,
                    child: SvgPicture.asset("assets/icons/alert.svg"),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 45),
                    child: Text(
                      "Delete Chat?",
                      style: Styles.boldH2(
                        AppTheme.dark,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 20,
                      left: 25,
                      right: 25,
                    ),
                    child: Text(
                      "All the messages will be deleted permanently and can’t be restored, are you sure?",
                      style: Styles.regularLabel(
                        AppTheme.dark80,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          chatBlock.fetchDeleteItem(index);
                          Navigator.pop(context);
                          BottomDialog.deleteSuccess(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width - 50,
                          height: 57,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            color: AppTheme.primary,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 6),
                                blurRadius: 75,
                                spreadRadius: 0,
                                color: Color.fromRGBO(100, 87, 87, 0.05),
                              )
                            ],
                          ),
                          child: Center(
                            child: Text(
                              "Delete",
                              style: Styles.boldButton(AppTheme.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  static void deleteSuccess(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return Container(
              height: 487,
              decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 114,
                    height: 5,
                    margin: EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                      color: AppTheme.grey20,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 50,
                    ),
                    height: 78,
                    width: 78,
                    child: SvgPicture.asset(
                      "assets/icons/success.svg",
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 45,
                    ),
                    child: Text(
                      "Delete Success",
                      style: Styles.boldH2(AppTheme.dark),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 20,
                      left: 25,
                      right: 25,
                    ),
                    child: Text(
                      "All the messages have successfully deleted, start a new chat now!",
                      textAlign: TextAlign.center,
                      style: Styles.regularLabel(AppTheme.dark80),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width - 50,
                          height: 56,
                          decoration: BoxDecoration(
                            color: AppTheme.primary,
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(100, 87, 87, 0.05),
                                offset: Offset(0, 6),
                                spreadRadius: 0,
                                blurRadius: 75,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              "Done",
                              style: Styles.boldButton(AppTheme.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  static void sendComment(BuildContext context, int tapeId) {
    TextEditingController chatController = new TextEditingController();
    final FocusNode focusNode = FocusNode();
    bool isSend = false;

    DatabaseHelperComment database = new DatabaseHelperComment();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
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

            return Padding(
              padding: EdgeInsets.only(
                bottom: 4,
              ),
              child: Container(
                height: 538,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  color: AppTheme.white,
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      width: 114,
                      height: 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: AppTheme.grey20,
                      ),
                    ),
                    Expanded(
                      child: FutureBuilder<List<CommentModel>>(
                        future: database.getProductsTapeId(tapeId),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView(
                              padding: EdgeInsets.only(
                                top: 30,
                                left: 25,
                                right: 25,
                              ),
                              children: [
                                Text(
                                  "Comments",
                                  style: Styles.boldH3(AppTheme.dark),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.only(
                                        top: 29,
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 38,
                                            height: 38,
                                            margin: EdgeInsets.only(
                                              right: 15,
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(38),
                                              child: Image.asset(
                                                "assets/images/thor.png",
                                                width: 38,
                                                height: 38,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text.rich(
                                              TextSpan(
                                                children: <InlineSpan>[
                                                  TextSpan(
                                                    text:
                                                        "${snapshot.data![index].userName} ",
                                                    style: Styles.boldContent(
                                                        AppTheme.dark),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        "${snapshot.data![index].comment}",
                                                    style:
                                                        Styles.regularContent(
                                                      AppTheme.dark,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          }
                          return Container(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                    Container(
                      height: 52,
                      margin: EdgeInsets.only(
                        top: 44,
                        left: 25,
                        right: 25,
                        bottom: 54,
                      ),
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        color: AppTheme.grey20,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/icons/smile.svg"),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: TextFormField(
                              style: Styles.semiBoldContent(AppTheme.dark),
                              controller: chatController,
                              decoration: InputDecoration(
                                hintText: "Write your comments",
                                hintStyle:
                                    Styles.regularContent(AppTheme.dark60),
                                border: InputBorder.none,
                              ),
                              focusNode: focusNode,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              var now = new DateTime.now();
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);
                              if (isSend) {
                                Utils.getUserName().then(
                                  (value) => {
                                    database.saveProducts(CommentModel(
                                      id: null,
                                      userName: value,
                                      comment: chatController.text,
                                      dateTime: now,
                                      tapeId: tapeId,
                                    )),
                                    homeBloc.fetchUpdatedComment(),
                                    BottomDialog.sendCommentSuccess(context),
                                    setState(() {
                                      chatController.text = "";
                                    }),
                                    if (!currentFocus.hasPrimaryFocus)
                                      {
                                        currentFocus.unfocus(),
                                      },
                                  },
                                );
                              }
                            },
                            child: !isSend
                                ? SvgPicture.asset("assets/icons/not_send.svg")
                                : SvgPicture.asset("assets/icons/send.svg"),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  static void sendCommentSuccess(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return Container(
              height: 487,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                color: AppTheme.white,
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 15,
                    ),
                    height: 5,
                    width: 114,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        3,
                      ),
                      color: AppTheme.grey20,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 50,
                    ),
                    height: 78,
                    width: 78,
                    child: SvgPicture.asset(
                      "assets/icons/success.svg",
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 45,
                    ),
                    child: Text(
                      "Comment Added",
                      style: Styles.boldH2(AppTheme.dark),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 20,
                      left: 25,
                      right: 25,
                    ),
                    child: Text(
                      "Your comment was successfully published to this post.",
                      textAlign: TextAlign.center,
                      style: Styles.regularLabel(AppTheme.dark80),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                        },
                        child: Container(
                          height: 56,
                          width: double.infinity,
                          margin: EdgeInsets.only(
                            left: 25,
                            right: 25,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.primary,
                            borderRadius: BorderRadius.circular(28.5),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 6),
                                blurRadius: 75,
                                spreadRadius: 0,
                                color: Color.fromRGBO(100, 87, 87, 0.05),
                              )
                            ],
                          ),
                          child: Center(
                            child: Text(
                              "Done",
                              style: Styles.boldButton(AppTheme.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
