import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projecteiei/screens/edit_item_screen.dart';
import 'package:flutter_projecteiei/screens/login_screen.dart';
import 'package:flutter_projecteiei/screens/new_item_screen.dart';
import 'package:flutter_projecteiei/services/auth_service.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter PR',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: LoginScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AuthService _service = AuthService();

  @override
  Widget build(BuildContext context) {
    User? currentUser = _service.user;
    String displayEmail = "";
    if (currentUser != null && currentUser.email != null) {
      displayEmail = currentUser.email!;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.lightGreen),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    "Account : $displayEmail",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout"),
              onTap: () {
                _service.logout(currentUser);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false);
              },
            )
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("items").snapshots(),
        builder: ((context, snapshot) {
          final dataDocuments = snapshot.data?.docs;
          if (dataDocuments == null) return const Text("No data");
          return ListView.builder(
            itemCount: dataDocuments.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.add, color: Colors.greenAccent),
                title: Text(dataDocuments[index]["name"].toString()),
                subtitle: Text(dataDocuments[index]["desc"].toString()),
                onTap: () => _editItemScreen(dataDocuments[index].id,
                    dataDocuments[index]["name"], dataDocuments[index]["desc"]),
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewItem,
        tooltip: 'New Item',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _createNewItem() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NewItemScreen()));
  }

  _editItemScreen(String documentid, String itemName, String itemDesc) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                EditItemScreen(documentid, itemName, itemDesc)));
  }
}
