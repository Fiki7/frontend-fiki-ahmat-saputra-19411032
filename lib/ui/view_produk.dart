import 'dart:io';

import 'package:flutter_app/server/server.dart';
import 'package:flutter_app/ui/detail_produk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ProdukView extends StatelessWidget {
  final String apiUrl = UrlServer + "produk/get";
  void showSnakbar(BuildContext context, Message, color) {
    final snackBar = SnackBar(content: Text(Message), backgroundColor: color);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    List<dynamic>? fecthDataProduk;
  }

  Future<List<dynamic>> getLists() async {
    var response = await http.get(Uri.parse(apiUrl));
    try {
      var decodedResponse = json.decode(response.body)['data'];
      print(decodedResponse);
      return decodedResponse;
    } on SocketException catch (_) {}
    return [];
  }
  void setDetail(BuildContext context,id, merk, deskripsi, size,warna)async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('_id', id);
    await prefs.setString('merk', merk);
    await prefs.setString('deskripsi', deskripsi);
    await prefs.setString('size', size);
    await prefs.setString('warna', warna);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                detail_produk_view(id:id, warna: warna,deskrispi:warna,
                    merk: merk,size: size)));


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produk Anda'),
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: getLists(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  padding: EdgeInsets.all(5),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () =>
                          setDetail(context,snapshot.data[index]['_id'],snapshot.data[index]['merk'],
                            snapshot.data[index]['deskripsi'],snapshot.data[index]['size'],
                            snapshot.data[index]['warna'],
                          ),
                      child: SizedBox(
                        height: 150,
                        width: 150,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            AspectRatio(
                              aspectRatio: 1.0,
                              child: Image.asset('assets/Sepatu1.jpg'),
                              // child: Image.network("http://pasar.pptik.id/" +
                              //     snapshot.data[index]['IMAGE']),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    10.0, 0.0, 2.0, 0.0),
                                child: ListTile(
                                  title: Text(
                                    snapshot.data[index]['merk'],
                                    style: const TextStyle(
                                        color: Colors.blue,
                                        fontSize: 20,
                                        fontStyle: FontStyle.normal),
                                  ),
                                  subtitle: Text("Ukuran:" +
                                      snapshot.data[index]['size'] +
                                      "" +
                                      "            " +
                                      "Deskripsi:" +
                                      snapshot.data[index]['deskripsi'] +
                                      "" +
                                      "            " +
                                      "warna:" +
                                      snapshot.data[index]['warna']),

                                  // Text(),

                                  // author: author,
                                  // publishDate: publishDate,
                                  // readDuration: readDuration,
                                ),
                              ),
                            ),
                            // child:Card(),

                            // child:Text('Detail'),
                            // Expanded(child: Text)
                            // widget(child:)
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
