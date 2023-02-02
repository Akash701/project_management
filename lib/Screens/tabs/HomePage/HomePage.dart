import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'TaskDetails.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _items = [];
  Future<void> homeJsonData() async {
    final String response = await rootBundle.loadString('assets/projects.json');
    final data = await jsonDecode(response);
    setState(() {
      _items = data["items"];
    });
  }

  @override
  initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      homeJsonData();
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _items.isNotEmpty
              ? Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.to(TaskDetails(index));
                          },
                          child: Card(
                            color: Colors.deepOrangeAccent,
                            // key: ValueKey(_items[index]["id"]),
                            margin: EdgeInsets.all(15),
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Text(_items[index]['id']),
                              ),
                              title: Text(_items[index]['name']),
                              subtitle: Text(_items[index]["description"]),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          color: Colors.green,
                          thickness: 2,
                          indent: 50,
                          endIndent: 50,
                        );
                      },
                      itemCount: _items.length),
                )
              : Text('There is no Projects to load')
        ],
      ),
    );
  }
}
