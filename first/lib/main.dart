import 'package:first/views/form_view_task.dart';
import 'package:first/views/list_view_task.dart';
import 'package:flutter/material.dart';

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
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.person),
              ),
            ),
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
