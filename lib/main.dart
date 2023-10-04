import 'package:app_catatan_harian/tambahCatatan.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> catatanHarian = [];

  @override
  void initState() {
    super.initState();
    _loadCatatanHarian();
  }

  _loadCatatanHarian() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedCatatan = prefs.getStringList('catatan_harian');
    if (savedCatatan != null) {
      setState(() {
        catatanHarian.addAll(savedCatatan.map((catatan) {
          final parts = catatan.split(': ');
          return {'judul': parts[0], 'konten': parts[1]};
        }));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 243, 250),
      appBar: AppBar(
        elevation: 0,
        title: const Text('Catatan Harian'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: catatanHarian.length,
          itemBuilder: (context, index) {
            final catatan = catatanHarian[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Card(
                elevation: 5,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          catatan['judul']!,
                          style: const TextStyle(fontSize: 18),
                        ),
                        const Divider(),
                        Text(catatan['konten']!),
                      ]),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TambahCatatanPage(),
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
