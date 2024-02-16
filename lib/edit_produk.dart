import 'package:app_produk/halaman_produk.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UbahProduk extends StatefulWidget {
  final Map ListData;
UbahProduk({Key? key, required this.ListData}) : super (key : key);

  @override
  State<UbahProduk> createState() => _UbahProdukState();
}

class _UbahProdukState extends State<UbahProduk> {
  final formKey = GlobalKey<FormState>();
   TextEditingController id_produk = TextEditingController();
  TextEditingController nama_produk = TextEditingController();
  TextEditingController harga_produk = TextEditingController();

  Future _ubah() async {
    final respon = await http
        .post(Uri.parse('http://192.168.153.41/api_produk/edit.php'), 
        body: {
      'id_produk': id_produk.text, 
      'nama_produk': nama_produk.text,
      'harga_produk': harga_produk.text,
    });
    if (respon.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    id_produk.text = widget.ListData['id_produk'];
    nama_produk.text = widget.ListData['nama_produk'];
    harga_produk.text = widget.ListData['harga_produk'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Ubah Produk'),
        backgroundColor: Color.fromARGB(255, 57, 12, 148),
      ),

      body: Form(
          key: formKey,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                TextFormField(
                  controller: nama_produk,
                  decoration: InputDecoration(
                      hintText: 'Nama Produk',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                  validator: (value) {

                    if (value!.isEmpty) {
                      return "Nama produk tidak boleh kosong!";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 10),
                TextFormField(
                  controller: harga_produk,
                  decoration: InputDecoration(
                      hintText: 'Harga Produk',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),

                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Harga produk tidak boleh kosong!";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 10),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 13, 15, 107),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),

                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        _ubah().then((value) {
                          if (value) {
                            final snackBar = SnackBar(
                              content: const Text('Data berhasil di ubah'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            final snackBar = SnackBar(
                              content: const Text('Data gagal di ubah'),

                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        });

                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => HalamanProduk())),
                            (route) => false);
                      }
                    },
                    child: Text('Update'))
              ],
            ),
          )),
    );
  }
}