import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/item_service.dart';

class EditItemScreen extends StatefulWidget {
  final String documentId;
  final TextEditingController _itemName = TextEditingController();
  final TextEditingController _itemDesc = TextEditingController();

  EditItemScreen(this.documentId, String itemName, String itemDesc) {
    _itemName.text = itemName;
    _itemDesc.text = itemDesc;
  }

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  final ItemService _itemService = ItemService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: widget._itemName,
              decoration: const InputDecoration(label: Text("Item")),
            ),
            TextField(
              controller: widget._itemDesc,
              decoration: const InputDecoration(label: Text("Detail")),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      onPrimary: Colors.white,
                    ),
                    onPressed: _deleteItem,
                    child: Row(
                      children: [
                        const Icon(Icons.delete), // ไอคอน
                        const SizedBox(
                            width: 8), // ระยะห่างระหว่างไอคอนกับข้อความ
                        const Text("ลบ"), // ข้อความ
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      onPrimary: Colors.white,
                    ),
                    onPressed: _editItem,
                    child: Row(
                      children: [
                        const Icon(Icons.edit), // ไอคอน
                        const SizedBox(
                            width: 8), // ระยะห่างระหว่างไอคอนกับข้อความ
                        const Text("แก้ไข"), // ข้อความ
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _editItem() {
    final String newName = widget._itemName.text;
    final String newDesc = widget._itemDesc.text;

    if (newName.isNotEmpty && newDesc.isNotEmpty) {
      _itemService.updateItem(widget.documentId, {
        'name': newName,
        'desc': newDesc,
      }).then((value) {
        Navigator.pop(context);
      }).catchError((error) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('ERROR'),
            content: Text(error.toString()),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      });
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('ERROR'),
          content: const Text('error'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _deleteItem() {
    _itemService.deleteItem(widget.documentId).then((value) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('successfully deleted'),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('ERROR'),
          content: Text(error.toString()),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    });
  }
}
