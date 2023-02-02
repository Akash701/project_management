import 'package:flutter/material.dart';
import 'package:project_manager/Screens/tabs/CreatePage/Create.dart';
import 'package:project_manager/Screens/tabs/HomePage/HomePage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  // void initState() {
  //   super.initState();
  //   _tabController = TabController(length: 2, vsync: this);
  // }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Home Screen')),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Home Page'),
                    Icon(Icons.home),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Create'),
                    Icon(Icons.add),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            HomePage(),
            Create(),
          ],
        ),
      ),
    );
  }
}
