import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projecteiei/services/item_service.dart';
import 'package:logger/logger.dart';

class NewItemScreen extends StatefulWidget {
  @override
  State<NewItemScreen> createState() => _NewItemScreenState();
}

class _NewItemScreenState extends State<NewItemScreen> {
  final _itemName = TextEditingController();
  final _itemDesc = TextEditingController();

  final ItemService _itemService = ItemService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Announce"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _itemName,
              decoration: InputDecoration(label: Text("Item")),
            ),
            TextField(
              controller: _itemDesc,
              decoration: InputDecoration(label: Text("Details")),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      onPrimary: Colors.white,
                    ),
                    onPressed: _addItem,
                    child: Row(
                      children: [
                        const Icon(Icons.edit), // ไอคอน
                        const SizedBox(
                            width: 8), // ระยะห่างระหว่างไอคอนกับข้อความ
                        const Text("เพิ่ม"), // ข้อความ
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _addItem() async {
    if (_itemName.text.isEmpty || _itemDesc.text.isEmpty) return;

    await FirebaseFirestore.instance.collection("items").add({
      "name": _itemName.text,
      "desc": _itemDesc.text,
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("successfully added"),
        content: const Text("add"),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("ok"),
          ),
        ],
      ),
    );

    _itemName.clear();
    _itemDesc.clear();
  }
}
