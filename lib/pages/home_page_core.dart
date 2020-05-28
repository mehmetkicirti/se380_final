import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:se380final/common/custom_utils.dart';
import 'package:se380final/pages/categories.dart';
import 'package:se380final/pages/homepage.dart';
import 'package:se380final/pages/profile.dart';
import 'package:se380final/viewModels/movieViewModel.dart';
import 'package:se380final/viewModels/userViewModel.dart';

class HomepageCore extends StatefulWidget {
  @override
  _HomepageCoreState createState() => _HomepageCoreState();
}

class _HomepageCoreState extends State<HomepageCore> {
  PageController _pageBottomController;
  GlobalKey _bottomNavigationKey = GlobalKey();
  int _selectedIndex = 0;
  List<TabData> tabs = [
    TabData(iconData: Icons.home,title: "Homepage"),
    TabData(iconData: Icons.category,title: "Categories"),
    TabData(iconData: Icons.perm_identity,title: "Profile"),
  ];

  @override
  void initState() {
    _pageBottomController = PageController(initialPage: _selectedIndex);
    super.initState();
  }
  @override
  void dispose() {
    _pageBottomController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final _movieModel = Provider.of<MovieViewModel>(context,listen: false);
    return WillPopScope(
      onWillPop: () => CustomUtils.onWillPop(context),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          resizeToAvoidBottomPadding: false,
          body: SizedBox.expand(
            child: PageView(
              controller:  _pageBottomController,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                Homepage(),
                Categories(),
                Profile()
              ],
            ),
          ),
          bottomNavigationBar: _buildBottomNavigationBar(),
        ),
    );
  }
  _getLikes(List<String> likesId) async{
    final _movieModel = Provider.of<MovieViewModel>(context,listen: false);
    await _movieModel.getLikedMovies(likesId);
  }

  _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(0,8),
            spreadRadius: 12,
            blurRadius: 12
          )
        ]
      ),
      child: FancyBottomNavigation(
        tabs:tabs,
        onTabChangedListener: (index) async{
          final _userModel = Provider.of<UserViewModel>(context,listen: false);
          if(index == 2){
            await _getLikes(_userModel.likes);
          }
          setState(() {
           Future.delayed(Duration(milliseconds: 150),(){
             _pageBottomController.animateToPage(index, duration:Duration(milliseconds: 500), curve:Curves.easeIn);
           });
            //print("OnTabListener : $index");
            _selectedIndex = index;
          });
        },
        activeIconColor: Colors.white,
        circleColor: Colors.indigoAccent,
        barBackgroundColor: Colors.white70,
        initialSelection: _selectedIndex,
        inactiveIconColor: Colors.redAccent,
        textColor: Colors.deepPurple,
        key: _bottomNavigationKey,
      ),
    );
  }
}


/*
Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKeys[_currentTab].currentState.maybePop(),
      child: MyCustomBottomNavigation(
        sayfaOlusturucu: allPages(),
        navigatorKeys: navigatorKeys,
        currentTab: _currentTab,
        onSelectedTab: (selectedTab) {
          if (selectedTab == _currentTab) {
            navigatorKeys[selectedTab]
                .currentState
                .popUntil((route) => route.isFirst);
          } else {
            setState(() {
              _currentTab = selectedTab;
            });
          }
        },
      ),
    );
  }
 */
