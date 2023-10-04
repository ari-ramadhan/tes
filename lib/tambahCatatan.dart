import 'package:app_catatan_harian/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TambahCatatanPage extends StatefulWidget {
  @override
  _TambahCatatanPageState createState() => _TambahCatatanPageState();
}

class _TambahCatatanPageState extends State<TambahCatatanPage> {
  final TextEditingController judulController = TextEditingController();
  final TextEditingController kontenController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Catatan Harian'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: judulController,
              decoration: const InputDecoration(labelText: 'Judul'),
            ),
            TextField(
              controller: kontenController,
              decoration: const InputDecoration(labelText: 'Konten'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final judul = judulController.text;
                final konten = kontenController.text;
                if (judul.isNotEmpty && konten.isNotEmpty) {
                  SharedPreferences.getInstance().then((prefs) {
                    final catatan = '$judul: $konten';
                    List<String>? savedCatatan = prefs.getStringList('catatan_harian');
                    if (savedCatatan != null) {
                      savedCatatan.add(catatan);
                    } else {
                      savedCatatan = [catatan];
                    }
                    prefs.setStringList('catatan_harian', savedCatatan);
                  });

                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyApp(),));
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
