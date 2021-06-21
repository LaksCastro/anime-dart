import 'package:flutter/material.dart';

class AppBottomBar extends StatefulWidget {
  const AppBottomBar({Key key}) : super(key: key);

  @override
  _AppBottomBarState createState() => _AppBottomBarState();
}

class _AppBottomBarState extends State<AppBottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.explore_outlined,
            color: Theme.of(context).textTheme.bodyText1.color,
          ),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          label: 'Search',
          icon: Icon(
            Icons.favorite,
            color: Theme.of(context).textTheme.bodyText1.color,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Library',
          icon: Icon(
            Icons.folder_open,
            color: Theme.of(context).textTheme.bodyText1.color,
          ),
        ),
      ],
      backgroundColor: Theme.of(context).appBarTheme.color,
    );
  }
}
