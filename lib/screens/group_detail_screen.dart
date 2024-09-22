import 'package:currator_app/screens/schedule_screen.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart'; 

import 'members_screen.dart';
import 'calendar_screen.dart';
import 'documents_screen.dart';
import 'login_screen.dart';

class GroupDetailScreen extends StatelessWidget {
  final ParseObject group;

  GroupDetailScreen({required this.group});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(group.get<String>('name').toString()),
        
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.logout),
        onPressed: () => doUserLogout(context),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Участники'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MembersScreen(group: group,) 
                )
              );
            },
          ),
          ListTile(
            title: Text('Календарь'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CalendarScreen() 
                )
              );
            },
          ),
          ListTile(
            title: Text('Документы'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DocumentsScreen() 
                )
              );
            },
          ),
          ListTile(
            title: Text('Расписание'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScheduleScreen(group: group) 
                )
              );
            },
          ),
        ],
      ),
    );
  }

  void doUserLogout(BuildContext context) async {
    var user = await ParseUser.currentUser();
    var response = await user.logout();

    if (response.success) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen()
        )
      );
    }
  }
}