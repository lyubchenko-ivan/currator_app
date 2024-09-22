// ignore_for_file: await_only_futures

import 'package:currator_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'group_detail_screen.dart';

class GroupListScreen extends StatefulWidget {
  GroupListScreen({super.key});

  @override
  _GroupListScreenState createState() => _GroupListScreenState();
}

class _GroupListScreenState extends State<GroupListScreen> {
  List<ParseObject> groups = [];
  TextEditingController groupsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    
    getCurrentUser();
    getGroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Мои группы'),
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.logout),
        onPressed: () => doUserLogout(),
      ),
      body: ListView.builder(
        itemCount: groups.length,
        itemBuilder: (context, index) {
          final group = groups[index]; 
          return ListTile(
            title: Text(group.get<String>('name').toString()),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GroupDetailScreen(group: group),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> getGroups() async {
    var user = await ParseUser.currentUser();
    var queryBuilder = QueryBuilder<ParseObject>(ParseObject('Group'))
      ..whereEqualTo('user', user.objectId);
    var apiResponse = await queryBuilder.query();

    if (apiResponse.success && apiResponse.results != null) {
      setState(() {
        groups = apiResponse.results as List<ParseObject>;
      });
    } else {
      throw("Error;");
    }
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

  void getCurrentUser() async {
    var user = await ParseUser.currentUser();
    setState(() {
      user = user;
    });
  }
}