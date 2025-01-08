import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../models/product.dart';

class EditProductScreen extends StatefulWidget {
  final Product product;
  final int index;

  EditProductScreen({required this.product, required this.index});

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product.name);
    _priceController = TextEditingController(text: widget.product.price.toString());
    _descriptionController = TextEditingController(text: widget.product.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Barang'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nama Barang',
                  labelStyle: TextStyle(color: Colors.teal),
                  filled: true,
                  fillColor: Colors.teal[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: 'Harga Barang',
                  labelStyle: TextStyle(color: Colors.teal),
                  filled: true,
                  fillColor: Colors.teal[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Deskripsi Barang',
                  labelStyle: TextStyle(color: Colors.teal),
                  filled: true,
                  fillColor: Colors.teal[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                maxLines: 4,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  final name = _nameController.text;
                  final price = double.tryParse(_priceController.text);
                  final description = _descriptionController.text;

                  if (name.isNotEmpty && price != null && description.isNotEmpty) {
                    final updatedProduct = Product(
                      name: name,
                      price: price,
                      description: description,
                    );
                    Provider.of<ProductProvider>(context, listen: false).updateProduct(widget.index, updatedProduct);
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Semua kolom harus diisi!')),
                    );
                  }
                },
                child: Text('Update Barang'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}