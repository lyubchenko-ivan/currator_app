import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class LessonCard extends StatelessWidget {
  final ParseObject lesson;

  const LessonCard({super.key, required this.lesson});

  static const LESSON_TIMES = ["8:00-9:35", "9:50-11:25", "11:55-13:30", "13:45-15:20", "15:50-17:25", "17:35-19:10", "19:50-20:50"];

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Text(getLessonTime()),
        title: Text(lesson.get<String>('name').toString()),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(lesson.get<String>('teacher_name').toString()),
            Text(lesson.get<String>('auditory_name').toString())
          ],
        ),
      ), 
    );
  }

  String getLessonTime() {
    return LESSON_TIMES[lesson.get<int>('position')! - 1];
  }
}