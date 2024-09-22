import 'group_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();
  String? userId;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 70),
              child: FlutterLogo(
                size: 40,
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: TextField(
                controller: controllerUsername,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                  labelText: 'Имя пользователя',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: TextField(
                controller: controllerPassword,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                  labelText: 'Пароль',
                ),
              ),
            ),
            Container(
              height: 80,
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text('Войти'),
                onPressed: userId != null ? null : () => doUserLogin(),
              )
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Забыли пароль?',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
          ],
        )
      ),
    );
  }

  void showSuccess(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Успех!"),
          content: Text(message),
          actions: <Widget>[
            new TextButton(
              child: const Text("Ok"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GroupListScreen()
                  )
                );
              },
            )
          ],
        );
      }
    );
  }

  void showError(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Ошибка!"),
          content: Text(message),
          actions: <Widget>[
            new TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  void doUserLogin() async {
    final username = controllerUsername.text.trim();
    final password = controllerPassword.text.trim();
    
    final user = ParseUser(username, password, null);

    var response = await user.login();

    if (response.success) {
      showSuccess("Вы успешно вошли в систему!");
      setState(() {
        userId = response.result.objectId;
      });
    } else {
      showError(response.error!.message);
    }
  }
}