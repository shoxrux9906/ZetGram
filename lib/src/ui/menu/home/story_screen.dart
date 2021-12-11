import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:zet_gram/src/model/home/story_model.dart';
import 'package:zet_gram/src/theme/app_theme.dart';
import 'package:zet_gram/src/utils/styles.dart';

class StoryScreen extends StatefulWidget {
  final int index;

  StoryScreen(this.index);

  @override
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  late PageController _pageController;
  int currentIndex = 0;
  double width = 0.0;
  Timer timer = new Timer(Duration(seconds: 0), (){});

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.index);
    currentIndex = widget.index;
    _newScreen();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    timer.cancel();
    super.dispose();
  }

  var _duration = Duration(milliseconds: 5000);

  void _newScreen() {
    if (timer == null) {
      timer = Timer(_duration, () {
        currentIndex++;
        if (currentIndex == story.length) {
          Navigator.pop(this.context);
        } else {
          _pageController.animateToPage(
            currentIndex,
            duration: Duration(milliseconds: 100),
            curve: Curves.easeInOut,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.screen,
      body: Theme(
        data: ThemeData(
          accentColor: Color(0xFF327FAB),
          canvasColor: Colors.transparent,
          textTheme: AppTheme.textTheme,
          platform: TargetPlatform.iOS,
        ),
        child: PageView(
          onPageChanged: (int page) {
            setState(() {
              currentIndex = page;
              _newScreen();
            });
          },
          controller: _pageController,
          children: story.map((storyModel) {
            return Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(storyModel.storyImage),
                fit: BoxFit.cover,
              )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 30, left: 25, right: 25),
                    child: LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width - 50,
                      animation: true,
                      lineHeight: 6.0,
                      animationDuration: 5000,
                      percent: 1.0,
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      progressColor: AppTheme.white,
                      backgroundColor: AppTheme.grey40,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 30,
                      left: 25,
                      right: 25,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(52),
                            child: Image.asset(
                              storyModel.image,
                              width: 52,
                              height: 52,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              storyModel.name,
                              style: Styles.boldLabel(AppTheme.white),
                            ),
                            Text(
                              "@${storyModel.name.toLowerCase().replaceAll(" ", "")}",
                              style: Styles.regularContent(AppTheme.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 75,
                      left: 25,
                      right: 25,
                    ),
                    child: Text(
                      storyModel.storyMessage == null
                          ? ""
                          : storyModel.storyMessage,
                      style: Styles.boldH2(
                        AppTheme.white,
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  Container(
                    padding: EdgeInsets.only(
                      top: 54,
                      left: 0,
                      right: 0,
                      bottom: 54,
                    ),
                    child: Container(
                      height: 53,
                      margin: EdgeInsets.only(
                        top: 54,
                        left: 25,
                        right: 25,
                      ),
                      decoration: BoxDecoration(
                          color: AppTheme.grey20,
                          borderRadius: BorderRadius.circular(26),
                          border: Border.all(
                            color: AppTheme.screen,
                            width: 1,
                          )),
                      child: Row(
                        children: [
                          SizedBox(width: 20,),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: "Reply Diane Richards story ...",
                                hintStyle:
                                    Styles.regularContent(AppTheme.white),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(width: 15,),
                          GestureDetector(
                            onTap: (){

                            },
                            child: SvgPicture.asset(
                              "assets/icons/send.svg",
                              color: AppTheme.white,
                            ),
                          ),
                          SizedBox(width: 20,),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  List<StoryModel> story = [
    StoryModel(
      isNew: true,
      image: "assets/images/messi.png",
      name: "Lionel Messi",
      storyImage: "assets/images/img1.png",
      storyMessage: "Yummy! Let’s eat with me!",
    ),
    StoryModel(
      isNew: true,
      image: "assets/images/anna_jamil.png",
      name: "Anna Jamil",
      storyImage: "assets/images/christmas.jpg",
      storyMessage: "Yummy!\nLet’s eat with me!",
    ),
    StoryModel(
      isNew: true,
      image: "assets/images/alan_walker.png",
      name: "Alan Walker",
      storyImage: "assets/images/img2.png",
      storyMessage: '',
    ),
    StoryModel(
      isNew: true,
      image: "assets/images/thor.png",
      name: "Thor",
      storyImage: "assets/images/img3.png",
      storyMessage: '',
    ),
    StoryModel(
      isNew: true,
      image: "assets/images/james_person.png",
      name: "James Person",
      storyImage: "assets/images/travel.jpg",
      storyMessage: '',
    ),
  ];
}
