import 'package:flutter/material.dart';

class DocumentsScreen extends StatelessWidget {
  final List<String> documents = ['Документ 1', 'Документ 2']; // Пример документов

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Документы'),
      ),
      body: ListView.builder(
        itemCount: documents.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(documents[index]),
            onTap: () {
              // Логика открытия документа
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Логика загрузки документа
        },
      ),
    );
  }
}