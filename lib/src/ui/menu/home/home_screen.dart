import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zet_gram/src/bloc/home_bloc.dart';
import 'package:zet_gram/src/dialog/bottom_dialog.dart';
import 'package:zet_gram/src/model/home/home_model.dart';
import 'package:zet_gram/src/theme/app_theme.dart';
import 'package:zet_gram/src/ui/menu/home/story_screen.dart';
import 'package:zet_gram/src/utils/styles.dart';
import 'notification_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    homeBloc.fetchAllHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: AppTheme.screen,
      body: Column(
        children: [
          Container(
            color: AppTheme.white,
            height: 96,
            padding: EdgeInsets.only(
              left: 25,
              right: 25,
              bottom: 20,
            ),
            child: Column(
              children: [
                Expanded(
                  child: Container(),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Home",
                        style: Styles.boldH1(AppTheme.dark),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return NotificationScreen();
                            },
                          ),
                        );
                      },
                      child: SvgPicture.asset(
                        "assets/icons/notification.svg",
                        width: 28,
                        height: 28,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Theme(
              data: ThemeData(
                accentColor: Color(0xFFEB3266),
                // accentColor: Color(0xFF327FEB),
                canvasColor: Colors.transparent,
                textTheme: AppTheme.textTheme,
                platform: TargetPlatform.iOS,
              ),
              child: Container(
                margin: EdgeInsets.only(bottom: 50),
                // color: Colors.red,
                child: StreamBuilder(
                  stream: homeBloc.allHome,
                  builder: (context, AsyncSnapshot<HomeModel> snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        child: ListView(
                          padding: EdgeInsets.only(bottom: 24),
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 25),
                              color: AppTheme.screen,
                              height: 94,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.story.length - 1,
                                itemBuilder: (context, index) {
                                  return index == 0
                                      ? GestureDetector(
                                          child: Container(
                                            width: 57,
                                            margin: EdgeInsets.only(
                                              left: 25,
                                              right: 16,
                                            ),
                                            child: Column(
                                              children: [
                                                DottedBorder(
                                                  child: ClipRRect(
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      width: 57,
                                                      height: 57,
                                                      color: AppTheme.screen,
                                                      child: SvgPicture.asset(
                                                        "assets/icons/plus.svg",
                                                      ),
                                                    ),
                                                  ),
                                                  borderType: BorderType.RRect,
                                                  radius: Radius.circular(9),
                                                  strokeWidth: 3,
                                                  dashPattern: [15, 5],
                                                  color: AppTheme.primary,
                                                ),
                                                SizedBox(
                                                  height: 6,
                                                ),
                                                Text(
                                                  "Add Story",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: Styles.regularBody(
                                                      AppTheme.dark),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    StoryScreen(index - 1),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                              left: 8,
                                              right: 8,
                                            ),
                                            width: 73,
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: 63,
                                                  height: 63,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            9),
                                                    border: Border.all(
                                                      color: AppTheme.primary,
                                                      width: 3,
                                                    ),
                                                  ),
                                                  child: ClipRRect(
                                                    child: Image.asset(
                                                      snapshot
                                                          .data!
                                                          .story[index - 1]
                                                          .image,
                                                      width: 63,
                                                      height: 63,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  snapshot.data!
                                                      .story[index - 1].name,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: Styles.regularBody(
                                                    AppTheme.dark,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                },
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(bottom: 24),
                              itemCount: snapshot.data!.tape.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onDoubleTap: () {
                                    homeBloc.fetchUpdatedFavorite(
                                      index,
                                      !snapshot.data!.tape[index].isFavorite,
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      top: 30,
                                      left: 25,
                                      right: 25,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppTheme.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 17, left: 15, right: 20),
                                          child: Row(
                                            children: [
                                              GestureDetector(
                                                // onTap: () {
                                                //   Navigator.push(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //         builder: (context) =>
                                                //             FriendProfileScreen(
                                                //                 snapshot.data!
                                                //                         .tape[
                                                //                     index])),
                                                //   );
                                                // },
                                                child: Container(
                                                  width: 42,
                                                  height: 42,
                                                  margin: EdgeInsets.only(
                                                    right: 19,
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            42),
                                                    child: Image.asset(
                                                      snapshot.data!.tape[index]
                                                          .userImage,
                                                      width: 42,
                                                      height: 42,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: GestureDetector(
                                                  child: Text(
                                                    snapshot.data!.tape[index]
                                                        .userName,
                                                    style: Styles.boldDisplay(
                                                        AppTheme.dark),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                child: Container(
                                                  child: SvgPicture.asset(
                                                    'assets/icons/more_vertical.svg',
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                            top: 17,
                                            left: 20,
                                            right: 20,
                                          ),
                                          height: 1,
                                          color: AppTheme.grey20,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                            top: 20,
                                            left: 15,
                                            right: 15,
                                          ),
                                          child: Text(
                                            snapshot.data!.tape[index].message,
                                            style: Styles.regularContent(
                                              AppTheme.dark80,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              80,
                                          margin: EdgeInsets.only(
                                            top: 20,
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.asset(
                                              snapshot.data!.tape[index].image,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  80,
                                              height: 170,
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                            top: 20,
                                            left: 15,
                                            right: 15,
                                            bottom: 20,
                                          ),
                                          child: Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  homeBloc.fetchUpdatedFavorite(
                                                    index,
                                                    !snapshot.data!.tape[index]
                                                        .isFavorite,
                                                  );
                                                },
                                                child: snapshot.data!
                                                        .tape[index].isFavorite
                                                    ? SvgPicture.asset(
                                                        "assets/icons/inactive.svg",
                                                      )
                                                    : SvgPicture.asset(
                                                        "assets/icons/active.svg",
                                                      ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "${snapshot.data!.tape[index].count}",
                                                style: Styles.semiBoldContent(
                                                  AppTheme.dark80,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 24,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  BottomDialog.sendComment(
                                                      context,
                                                      snapshot.data!.tape[index]
                                                          .id);
                                                },
                                                child: SvgPicture.asset(
                                                    "assets/icons/message_circle.svg"),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "${snapshot.data!.tape[index].comments.length}",
                                                style: Styles.semiBoldContent(
                                                  AppTheme.dark80,
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(),
                                              ),
                                              Text(
                                                snapshot.data!.tape[index].time,
                                                style: Styles.regularBody(
                                                    AppTheme.grey),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      throw Exception("Something went wrong");
                    }
                    return Shimmer.fromColors(
                      baseColor: AppTheme.shimmerBase,
                      highlightColor: AppTheme.shimmerHighlight,
                      child: ListView(
                        padding: EdgeInsets.only(
                          bottom: 24,
                        ),
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              top: 25,
                            ),
                            child: ListView.builder(
                              itemCount: 20,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                        right: 25,
                                        bottom: 10,
                                      ),
                                      width: 57,
                                      height: 57,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(9),
                                        color: AppTheme.white,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        right: 25,
                                      ),
                                      width: 57,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(9),
                                        color: AppTheme.white,
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                          ListView.builder(
                            itemCount: 20,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(
                              bottom: 24,
                            ),
                            itemBuilder: (context, index) {
                              return Container(
                                height: index % 2 == 0 ? 220 : 275,
                                margin: EdgeInsets.only(
                                  top: 30,
                                  left: 25,
                                  right: 25,
                                ),
                                decoration: BoxDecoration(
                                  color: AppTheme.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
