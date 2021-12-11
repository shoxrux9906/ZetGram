import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zet_gram/src/bloc/explore_block.dart';
import 'package:zet_gram/src/model/explore_model.dart';
import 'package:zet_gram/src/theme/app_theme.dart';
import 'package:zet_gram/src/utils/styles.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with AutomaticKeepAliveClientMixin<ExploreScreen> {
  @override
  bool get wantKeepAlive => true;
  bool isSearch = false;
  bool isSearchAnim = false;
  bool isEdit = false;
  TextEditingController searchController = new TextEditingController();

  @override
  void initState() {
    exploreBlock.fetchAllExplore();
    super.initState();
  }

  _ExploreScreenState() {
    searchController.addListener(() {
      if (searchController.text.length > 0) {
        setState(() {
          isEdit = true;
        });
      } else {
        setState(() {
          isEdit = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      // backgroundColor: Colors.yellow,
      body: Column(
        children: [
          Container(
            color: AppTheme.white,
            height: 120,
            padding: EdgeInsets.only(
              left: 25,
              right: 25,
              bottom: isSearch ? 15 : 20,
            ),
            child: Column(
              children: [
                Expanded(child: Container()),
                isSearch
                    ? Row(
                        children: [
                          AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            width: isSearchAnim
                                ? 0
                                : MediaQuery.of(context).size.width - 78,
                          ),
                          Expanded(
                              child: TextFormField(
                            controller: searchController,
                            style: Styles.semiBoldLabel(AppTheme.dark),
                            decoration: InputDecoration(
                                hintText: "Search here",
                                hintStyle: Styles.regularLabel(AppTheme.grey),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppTheme.grey40,
                                    width: 0.5,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppTheme.grey40,
                                    width: 0.5,
                                  ),
                                ),
                                prefixIcon: GestureDetector(
                                  onTap: () {
                                    if (isEdit) {
                                      setState(() {
                                        searchController.text = "";
                                      });
                                    } else {
                                      setState(() {
                                        isSearchAnim = false;
                                      });
                                      Timer(Duration(milliseconds: 300), () {
                                        setState(() {
                                          setState(() {
                                            isSearch = false;
                                          });
                                        });
                                      });
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      right: 16,
                                      top: 16,
                                      bottom: 16,
                                    ),
                                    child: isEdit
                                        ? SvgPicture.asset("assets/icons/x.svg")
                                        : SvgPicture.asset(
                                            "assets/icons/search.svg",
                                          ),
                                  ),
                                )),
                          ))
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Explore",
                              style: Styles.boldH1(AppTheme.dark),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSearch = true;
                              });
                              Timer(Duration(milliseconds: 10), () {
                                setState(() {
                                  setState(() {
                                    isSearchAnim = true;
                                  });
                                });
                              });
                            },
                            child: SvgPicture.asset(
                              "assets/icons/search.svg",
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
                accentColor: Color(0xFF327FEB),
                canvasColor: Colors.transparent,
                textTheme: AppTheme.textTheme,
                platform: TargetPlatform.iOS,
              ),
              child: StreamBuilder(
                stream: exploreBlock.allExplore,
                builder: (context, AsyncSnapshot<List<ExploreModel>> snapshot) {
                  if (snapshot.hasData) {
                    return StaggeredGridView.countBuilder(
                      padding: EdgeInsets.only(
                        top: 25,
                        left: 25,
                        right: 25,
                        bottom: 40,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Image.asset(
                            snapshot.data![index].image,
                            fit: BoxFit.fitWidth,
                          ),
                        );
                      },
                      crossAxisCount: 4,
                      staggeredTileBuilder: (int index) =>
                          new StaggeredTile.fit(2),
                      mainAxisSpacing: 25.0,
                      crossAxisSpacing: 25.0,
                    );
                  }
                  return Shimmer.fromColors(
                    baseColor: AppTheme.shimmerBase,
                    highlightColor: AppTheme.shimmerHighlight,
                    child: StaggeredGridView.countBuilder(
                      padding: EdgeInsets.only(
                        top: 25,
                        left: 25,
                        right: 25,
                        bottom: 40,
                      ),
                      itemCount: 25,
                      crossAxisCount: 4,
                      itemBuilder: (context, index) {
                        Random random = new Random();
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppTheme.white,
                          ),
                          height: (random.nextInt(70) + 150).toDouble(),
                        );
                      },
                      staggeredTileBuilder: (int index) =>
                          new StaggeredTile.fit(2),
                      mainAxisSpacing: 25.0,
                      crossAxisSpacing: 25.0,
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
