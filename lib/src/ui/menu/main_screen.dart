import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:zet_gram/src/database/database_helper_images.dart';
import 'package:zet_gram/src/theme/app_theme.dart';
import 'package:zet_gram/src/ui/menu/chat/chat_screen.dart';
import 'package:zet_gram/src/ui/menu/profile/profile_screen.dart';

import 'explore/explore_screen.dart';
import 'home/home_screen.dart';

final countFormat = new NumberFormat();

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin{
  PageController? _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  void _selectedTab(int index) {
    setState(() {
      _pageController!.jumpToPage(index);
    });
  }

  DatabaseHelperImages databaseHelperImages = new DatabaseHelperImages();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppTheme.white,
      body: Theme(
        data: ThemeData(
            accentColor: Color(0xFF327FEB),
            canvasColor: Colors.transparent,
            platform: TargetPlatform.android),
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          pageSnapping: false,
          onPageChanged: (int page) {
            setState(() {
              currentIndex = page;
            });
          },
          controller: _pageController,
          children: [
            HomeScreen(),
            ExploreScreen(),
            ChatScreen(),
            ProfileScreen(),
          ],
        ),
      ),
      bottomNavigationBar: FabBottomAppBar(
        notchedShape: CircularNotchedRectangle(),
        height: 72,
        onTabSelected: _selectedTab,
        items: [
          FabBottomAppBarItem(
            selected: "assets/menu/home_selected.svg",
            unselected: "assets/menu/home_unselected.svg",
          ),
          FabBottomAppBarItem(
            selected: "assets/menu/send_selected.svg",
            unselected: "assets/menu/send_unselected.svg",
          ),
          FabBottomAppBarItem(
            selected: "assets/menu/mail_selected.svg",
            unselected: "assets/menu/mail_unselected.svg",
          ),
          FabBottomAppBarItem(
            selected: "assets/menu/user_selected.svg",
            unselected: "assets/menu/user_unselected.svg",
          )
        ],
        backgroundColor: AppTheme.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ImagePicker.platform.pickImage(source: ImageSource.gallery).then(
              (value) => {databaseHelperImages.saveProducts(value!.path)});
        },
        child: SvgPicture.asset(
          "assets/menu/plus.svg",
          width: 28,
          height: 28,
          color: AppTheme.white,
        ),
        elevation: 0,
      ),
    );
  }

}

class FabBottomAppBarItem {
  String selected;
  String unselected;

  FabBottomAppBarItem({
    required this.selected,
    required this.unselected,
  });
}

class FabBottomAppBar extends StatefulWidget {
  FabBottomAppBar({
    required this.items,
    this.height = 60.0,
    required this.backgroundColor,
    required this.notchedShape,
    required this.onTabSelected,
  }) {
    assert(this.items.length == 2 || this.items.length == 4);
  }

  final List<FabBottomAppBarItem> items;
  final double height;
  final Color backgroundColor;
  final NotchedShape notchedShape;
  final ValueChanged<int> onTabSelected;

  @override
  _FabBottomAppBarState createState() => _FabBottomAppBarState();
}

class _FabBottomAppBarState extends State<FabBottomAppBar> {
  int _selectedIndex = 0;

  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });

    return BottomAppBar(
      shape: widget.notchedShape,
      color: widget.backgroundColor,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
    );
  }

  Widget _buildTabItem({
    required FabBottomAppBarItem item,
    required int index,
    required ValueChanged<int> onPressed,
  }) {
    return Container(
      width: (MediaQuery.of(context).size.width - 56) / 4,
      height: widget.height,
      margin: EdgeInsets.only(right: index == 1 ? 56 : 0),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () => onPressed(index),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              index == _selectedIndex
                  ? SvgPicture.asset(item.selected)
                  : SvgPicture.asset(item.unselected),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                margin: EdgeInsets.only(
                  top: 8,
                ),
                width: index == _selectedIndex ? 6 : 0,
                height: index == _selectedIndex ? 6 : 0,
                decoration: BoxDecoration(
                  color: index == _selectedIndex
                      ? AppTheme.primary
                      : AppTheme.white,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
