import 'package:flutter/material.dart';
import 'package:pushit/global/appbar.dart';
import 'package:pushit/chat/overview.dart';
import 'package:pushit/global/drawer.dart';
import 'package:pushit/mitglieder.dart';
import 'package:pushit/treffen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[ChatOverview(), Treffen(), Mitglieder()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Center(
          child: Image.asset(
        "assets/pushit_logo.png",
      )),
      Scaffold(
          drawer: MyDrawer(),
          backgroundColor: Colors.transparent,
          appBar: MyAppBar(),
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavBar(currentIndex: _selectedIndex, onTap: _onItemTapped))
    ]);
  }
}

class BottomNavBar extends StatelessWidget implements PreferredSizeWidget {
  const BottomNavBar({Key? key, this.currentIndex = 0, this.onTap}) : super(key: key);
  final int currentIndex;
  final void Function(int)? onTap;
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_pin),
          label: 'Treffen',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: 'Mitglieder',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Theme.of(context).colorScheme.secondary,
      unselectedItemColor: Theme.of(context).colorScheme.onSecondary,
      onTap: onTap,
      backgroundColor: Theme.of(context).colorScheme.primary,
      showUnselectedLabels: false,
    );
  }
}
