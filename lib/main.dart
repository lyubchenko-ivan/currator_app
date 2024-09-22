import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'screens/login_screen.dart';

void main() async {
  const keyApplicationId = 'sKZsiYTiwKes4t1gUp0fDuRxAhNqR287Fzw63uBK';
  const keyClientKey = 'F8s7u7vMDLM4YGmq6D8b0MF2dTUpx8yAawCXAB5z';
  const keyParseServerUrl = 'https://parseapi.back4app.com';

  print(keyClientKey);
  print(keyApplicationId);
  print(keyParseServerUrl);

  await Parse().initialize(
    keyApplicationId,
    keyParseServerUrl,
    clientKey: keyClientKey,
    debug: true
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Group Curator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
    );
  }
}