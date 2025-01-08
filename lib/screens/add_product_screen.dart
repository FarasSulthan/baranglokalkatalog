import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../models/product.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tambah Barang')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nama Barang'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Harga Barang'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Deskripsi'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final name = _nameController.text;
                final price = double.tryParse(_priceController.text);
                final description = _descriptionController.text;

                if (name.isNotEmpty && price != null && description.isNotEmpty) {
                  final product = Product(
                    name: name,
                    price: price,
                    description: description,
                  );
                  Provider.of<ProductProvider>(context, listen: false).addProduct(product);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Semua kolom harus diisi!')),
                  );
                }
              },
              child: Text('Tambah Barang'),
            ),
          ],
        ),
      ),
    );
  }
}