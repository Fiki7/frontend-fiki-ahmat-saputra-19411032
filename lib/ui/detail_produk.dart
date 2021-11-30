import 'dart:async';
import 'dart:convert';

import 'package:flutter_app/const/collor.dart';
import 'package:flutter_app/server/server.dart';
import 'package:flutter_app/ui/view_produk.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class detail_produk_view extends StatefulWidget {
  final String id;
  final String merk;
  final String size;
  final String deskrispi;
  final String warna;

  const detail_produk_view(
      {Key? key,
        required this.id,
        required this.warna,
        required this.deskrispi,
        required this.merk,
        required this.size})
      : super(key: key);
  // print(size);

  @override
  _detail_produk_viewState createState() => _detail_produk_viewState();
}

class _detail_produk_viewState extends State<detail_produk_view> {
  TextEditingController merk_sepatu = new TextEditingController();
  TextEditingController warna_sepatu = new TextEditingController();
  TextEditingController deskrispi_sepatu = new TextEditingController();
  TextEditingController ukuran_sepatu = new TextEditingController();
  final _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0, bottom: 15),
              child: Center(
                child: Container(
                    width: 150,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('assets/iconsepatu.png')),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Center(
                child: Text(
                  'Detail Produk',
                  style: (TextStyle(
                      color: Colors.blue, fontSize: 25, fontFamily: 'Raleway')),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: merk_sepatu,
                autofocus: true,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    labelText: 'Merk Sepatu',
                    hintText: 'Masukan Merk Sepatu'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: warna_sepatu,
                autofocus: true,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    labelText: 'Warna Sepatu',
                    hintText: 'Masukan Warna Sepatu'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: deskrispi_sepatu,
                autofocus: true,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    labelText: 'Deskripsi Produk',
                    hintText: 'Deskripsi Produk'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: ukuran_sepatu,
                autofocus: true,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    labelText: 'Ukuran',
                    hintText: 'Masukan Ukuran Sepatu'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                margin: const EdgeInsets.all(10),
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () {
                    updatedata(context);
                  },
                  child: const Text(
                    'Update Produk',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                margin: const EdgeInsets.all(10),
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () {
                    deletedata(context);
                  },
                  child: const Text(
                    'Delete Produk',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ),
            // Text('Belum Punya Akun? Daftar')
          ],
        ),
      ),
    );
  }

  //fungsi set data kedalam value dari data produk yang di simpan di SharedPreferences
  void setdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    merk_sepatu.text = prefs.getString('merk').toString();
    ukuran_sepatu.text = prefs.getString('size').toString();
    warna_sepatu.text = prefs.getString('warna').toString();
    deskrispi_sepatu.text = prefs.getString('deskripsi').toString();
  }

  //fungsi delete data
  void deletedata(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('_id').toString();
    var url = UrlServer + "produk/delete/" + id;
    final response = await http.delete(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    var result = convert.jsonDecode(response.body);
    print(result);
    String Message = result['message'];
    if (result['status']) {
      // Navigator.of(context, rootNavigator: true).pop();
      showSnakbar(context, Message, SuccesColor);
      var _duration = const Duration(seconds: 1);
      Timer(_duration, () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => ProdukView()));
      });
    } else {
      showSnakbar(context, Message, ErrorColor);
      print(Message);
    }
  }

  // fungsi edit data
  void updatedata(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('_id').toString();
    String warna = warna_sepatu.text;
    String deskripsi = deskrispi_sepatu.text;
    String size = ukuran_sepatu.text;
    String merk = merk_sepatu.text;
    var url = UrlServer + "produk/update/" + id;
    final response = await http.put(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "warna": warna,
        "deskripsi": deskripsi,
        "size": size,
        "merk": merk
      }),
    );
    var result = convert.jsonDecode(response.body);
    print(result);
    String Message = result['message'];
    if (result['status']) {
      // Navigator.of(context, rootNavigator: true).pop();
      showSnakbar(context, Message, SuccesColor);
      var _duration = const Duration(seconds: 1);
      Timer(_duration, () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => ProdukView()));
      });
    } else {
      showSnakbar(context, Message, ErrorColor);
      print(Message);
    }
  }

  //fungsi untuk menampilkan tanda
  void showSnakbar(BuildContext context, Message, color) {
    final snackBar = SnackBar(content: Text(Message), backgroundColor: color);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}