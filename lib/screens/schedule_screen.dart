import 'package:currator_app/components/schedule/day_card.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class ScheduleScreen extends StatefulWidget {
  final ParseObject group;
  ScheduleScreen({required this.group});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Расписание"),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: "Верхняя неделя"),
            Tab(text: "Нижняя неделя",)
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
            for (int week = 1; week <= 2; week++) Container(
                                                    child: ListView(
                                                      scrollDirection: Axis.vertical,
                                                      children: [
                                                        for (int day = 1; day <= 6; day++) DayCard(week: week, day: day, groupId: widget.group.objectId!,) 
                                                      ],
                                                    ),
                                                  ),
        ],
      ),
    );
  }

  void getLessons() async {
    for (int week = 0; week < 2; week++) {

    }
  }
}