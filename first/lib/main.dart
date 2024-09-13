import 'dart:io';

import 'package:first/views/form_view_task.dart';
import 'package:first/views/list_view_task.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //initialRoute: '/',
      home: AppTeste(),
      routes: {
        //'/': (context) => AppTeste(),
        'listaDeTarefas': (context) => ListViewTask(),
        'formulario': (context) => FormViewTask()
      },
    );
  }
}

class AppTeste extends StatefulWidget {
  const AppTeste({super.key});

  @override
  State<AppTeste> createState() => _AppTesteState();
}

class _AppTesteState extends State<AppTeste> {
  File? _image;
  ImagePicker _picker = ImagePicker();

  pickImage() async {
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (pickedFile != null) {
      prefs.setString('image_path', pickedFile.path);
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  loadImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('image_path');

    if (imagePath != null) {
      setState(() {
        _image = File(imagePath);
      });
    }
  }

  @override
  void initState() {
    loadImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de tarefas'),
        backgroundColor: Colors.green,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
                accountName: Text(
                  'teste',
                  style: TextStyle(fontSize: 20),
                ),
                accountEmail: Text('Teste@gmail.com'),
                currentAccountPicture: ClipOval(
                    child: Container(
                  height: 100,
                  width: 100,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Image.asset('assets/tasks.jpg'),
                  ),
                ))),
            ListTile(
              title: Text('Lista de tarefas'),
              onTap: () {
                Navigator.pushNamed(context, 'listaDeTarefas');
              },
              leading: Icon(Icons.list),
            ),
            Divider(
              thickness: 2,
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
              child: Column(
            children: [
              Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5fTvBqEpyLmHNzZVx0YlKR5wOxFoLRAtZxA&s'),
              _image != null
                  ? Image.file(
                      _image!,
                      fit: BoxFit.cover,
                      width: 300,
                      height: 300,
                    )
                  : new Container(),
              ElevatedButton(
                  onPressed: () {
                    pickImage();
                  },
                  child: Text('Selecionar texto da galeria'))
            ],
          )),
          Padding(
            padding: EdgeInsets.only(bottom: 20, right: 10),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'formulario');
                },
                child: Icon(Icons.add),
              ),
            ),
          )
        ],
      ),
    );
  }
}
