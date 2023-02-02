import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import '../../../widgets/title_text.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TaskDetails extends StatefulWidget {
  int index = 0;
  TaskDetails(this.index);
  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  List _details = [];
  Future<void> homeJsonData() async {
    final String response = await rootBundle.loadString('assets/details.json');
    final data = await jsonDecode(response);
    setState(() {
      _details = data["details"];
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
      appBar: AppBar(
        title: Text("Project Details"),
      ),
      body: Column(
        children: [
          _details.isNotEmpty
              ? Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: 1,
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        color: Colors.green,
                        thickness: 2,
                        indent: 50,
                        endIndent: 50,
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Container(
                          height: 100,
                          child: ListTile(
                            leading: Expanded(
                              child: CircularPercentIndicator(
                                radius: 25.0,
                                lineWidth: 5.0,
                                percent:
                                    _details[widget.index]['progress'] / 100,
                                center: Text(
                                    "${_details[widget.index]['progress']}%"),
                                progressColor: Colors.green,
                              ),
                            ),
                            title: TitleText(
                              text: _details[widget.index]['name'],
                              fontSize: 18,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                    "Created Date : ${_details[widget.index]['start']}"),
                                Text(
                                    "End Date : ${_details[widget.index]['end']}"),
                                Text(
                                    "Project Assigned to : ${_details[widget.index]['person']}"),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : ElevatedButton(
                  onPressed: () {
                    homeJsonData();
                  },
                  child: Center(
                    child: Text("Get data"),
                  ),
                ),
        ],
      ),
    );
  }
}
