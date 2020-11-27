import 'package:Instahelp/src/views/wishlist/Wishlist.dart';
import 'package:den_lineicons/den_lineicons.dart';
import 'package:flutter/material.dart';
import 'package:Instahelp/modules/setting/colors.dart';
import 'package:Instahelp/modules/state/AppState.dart';
import 'package:Instahelp/src/views/all_city/Cities.dart';
import 'package:Instahelp/src/views/comingsoon/ComingSoon.dart';
import 'package:Instahelp/src/views/home/Home.dart';

class DashboardTabs extends StatefulWidget {
  @override 
  _DashboardTabsState createState() => _DashboardTabsState();
}

class _DashboardTabsState extends State<DashboardTabs> {

  int _currentTab;
  List<StatefulWidget> _screens;

  @override
  void initState() {
    super.initState();
    _currentTab = 0;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentTab,
        children: _buildScreens(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 1,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          openTab(index);
        },
        currentIndex: _currentTab,
        items: <BottomNavigationBarItem>[
          _buildTabIcon(0),
          _buildTabIcon(1),
          _buildTabIcon(2),
          _buildTabIcon(3)
        ],
      ),
    );
    // return CupertinoTabScaffold(
    //   tabBar: _buildTabbars(),
    //   tabBuilder: (BuildContext context, int index) {
    //       return CupertinoTabView(
    //         builder: (BuildContext context) {
    //           return _buildPageForTabIndex(context, index);
    //         },
    //       );
    //     },
    // );
  }

  // COMPONENTS

  BottomNavigationBarItem _buildTabIcon(index) {
    var icon;
    var text;
    switch (index) {
      case 0: icon = DenLineIcons.home; break;
      case 1: icon = DenLineIcons.city; break;
      case 2: icon = DenLineIcons.bookmark; break;
      case 3: icon = DenLineIcons.user; break;
      default: icon = DenLineIcons.home; break;
    }
     switch (index) {
      case 0: text = 'Home'; break;
      case 1: text = 'Cities'; break;
      case 2: text = 'Wishlist'; break;
      case 3: text = 'Profile'; break;
      default: text = 'Home'; break;
    }
    var _normalIcon = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children:<Widget>[ Icon(icon, size: 24, color: GoloColors.secondary2),
      Text(text,
     // textAlign: TextAlign.center,
      style: TextStyle(
        color:GoloColors.secondary2,
        fontSize:12
      ),)
      ]
    );
    var _activeIcon = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children:<Widget>[ Icon(icon, size: 24, color: GoloColors.primary),
      Text(text,
     // textAlign: TextAlign.center,
      style: TextStyle(
        color:GoloColors.primary,
        fontSize:12
      ),)
      ]
    );
    return BottomNavigationBarItem(
      title: Text(''),
      icon: _normalIcon,
      activeIcon: _activeIcon
    );
  }

  List<StatefulWidget> _buildScreens() {
    _screens = <StatefulWidget>[
                Home(
                  cities: AppState().cities,
                  homeOpenAllCities: () {
                    openTab(1);
                  }),
                Cities(cities: AppState().cities,),
                Wishlist(isLoggedIn: AppState().token != ''??false,
                homeOpenAllCities: () {
                    openTab(1);
                  }),
                //ComingSoonPage(),
                ComingSoonPage(),
    ];
    return _screens;
  }

  // ### ACTIONS
  void openTab(int index) {
    setState(() {
      _currentTab = index;
    });
  }
}
