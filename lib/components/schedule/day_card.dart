import 'package:currator_app/components/schedule/lesson_card.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class DayCard extends StatefulWidget {
  final int day;
  final int week;
  final String groupId;
  const DayCard({ super.key, required this.day, required this.week, required this.groupId }); 

  @override
  _DayCardState createState() => _DayCardState();
}

class _DayCardState extends State<DayCard> {
  List<ParseObject> lessons = [];
  TextEditingController daysController = TextEditingController();

  @override
  void initState() {
    super.initState();

    getLessons();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: renderDayCard()
    );
  }

  Future<void> getLessons() async {
    QueryBuilder query = QueryBuilder<ParseObject>(ParseObject('Lesson'))
      ..whereEqualTo('group', this.widget.groupId)
      ..whereEqualTo('week_day', this.widget.day)
      ..whereEqualTo('week', this.widget.week)
      ..orderByAscending('position');

    var response = await query.query();

    if(response.success && response.results != null) {
      setState(() {
        lessons = response.results as List<ParseObject>;
      });
    } else {
      throw('Error');
    }
  }

  String getDayName() {
    return ["Понедельник", "Вторник", "Среда", "Четверг","Пятница", "Суббота"][this.widget.day - 1];
  }

  Widget? renderDayCard() {
    if (lessons.isNotEmpty) {
      return Container(
        child: Column(
          children: [
            Column(
              children: [
                Text(getDayName()),
                for (var lesson in lessons) LessonCard(lesson: lesson)
              ],
            )
          ],
        ),
      );
    } else {
      return null;
    }
  }
}