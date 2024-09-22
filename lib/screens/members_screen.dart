import 'package:currator_app/screens/student_screen.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'login_screen.dart';

class MembersScreen extends StatefulWidget {
  final ParseObject group;
  const MembersScreen({super.key, required this.group});

  @override
  _MembersScreenState createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  List<ParseObject> students = [];
  TextEditingController studentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Участники группы'),
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.logout),
        onPressed: () => doUserLogout(),
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          return ListTile(
            title: Text(getFullName(student)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StudentScreen(student: student, group: widget.group,)
                )
              );
            },
          );
        },
      ),
    );
  }

  Future<void> getStudents() async {
    var queryBuilder = QueryBuilder<ParseObject>(ParseObject('Student'))
      ..whereEqualTo('group', (ParseObject('Group')..objectId = widget.group.objectId).toPointer());
    var apiResponse = await queryBuilder.query();

    if (apiResponse.success && apiResponse.results != null) {
      setState(() {
        students = apiResponse.results as List<ParseObject>;
      });
    } else {
      throw(apiResponse.error.toString());
    }
  }

  String getFullName(ParseObject student) {
    return "${student.get<String>('last_name')} ${student.get<String>('first_name')} ${student.get<String>('parent_name')}";
  }

  void doUserLogout() async {
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