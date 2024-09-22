import 'package:currator_app/components/student/top_portion.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart'; 
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class StudentScreen extends StatelessWidget {  
  final ParseObject student;
  final ParseObject group;

  const StudentScreen({super.key, required this.student, required this.group});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(flex: 2, child: TopPortion()),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "${student.get<String>('last_name')} ${student.get<String>('first_name')} ${student.get<String>('parent_name')}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: FilledButton(
                        onPressed: () { _launchTelegram(); },
                        child: Text("Отправить сообщение"),
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 148, 40, 236)),
                          padding: WidgetStatePropertyAll(EdgeInsets.all(15.0)) 
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Text(
                            student.get<dynamic>('average_score').toString(),
                            style: TextStyle(
                              color: scoreColor(),
                              fontSize: 28,
                              fontWeight: FontWeight.bold 
                            ),
                          ),
                          Text(
                            "Средний балл",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0
                            )
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment(-1, 0),
                      margin: EdgeInsets.only(top: 25),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Дата рождения:   ", style: TextStyle(fontWeight: FontWeight.w600),),
                              Text(getDateOfBirth(student.get<DateTime>('date_of_birth')!))
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Text("Email:   ", style: TextStyle(fontWeight: FontWeight.w600)),
                              Text(student.get<String>('email').toString())
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Text("Номер телефона:   ", style: TextStyle(fontWeight: FontWeight.w600)),
                              Text(student.get<String>('phone_number').toString())
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Text("Группа:   ", style: TextStyle(fontWeight: FontWeight.w600)),
                              Text(group.get<String>('name').toString())
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ), 
    );
  }

  Future<void> _launchTelegram() async {
    if (!await launchUrl(Uri.parse(student.get<String>('telegram_id').toString()))) {
      throw Exception("Could not launch telegram ${student.get<String>('telegram_id')}");
    }
  }

  Color scoreColor() {
    if (student.get<dynamic>('average_score')! <= 3.0) {
      return Colors.red;
    } else if (student.get<dynamic>('average_score')! > 4.0) {
      return Colors.green;
    } else {
      return const Color.fromARGB(255, 190, 172, 2);
    }
  }

  String getDateOfBirth(DateTime dateOfBirth) {
    return DateFormat('dd-MM-yyyy').format(dateOfBirth);
  }
}