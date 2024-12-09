import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/models/product.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageUrlController;
  late TextEditingController _categoryController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _priceController = TextEditingController();
    _descriptionController = TextEditingController();
    _imageUrlController = TextEditingController();
    _categoryController = TextEditingController();
  }

  void _addProduct() {
    if (_formKey.currentState!.validate()) {
      // Agregar el nuevo producto a la lista
      Product newProduct = Product(
        productId: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        price: double.parse(_priceController.text),
        description: _descriptionController.text,
        imageUrl: _imageUrlController.text,
        category: _categoryController.text,
      );

      // Aquí deberías agregar el producto a tu base de datos o lista
      Navigator.pop(context);  // Regresar a la página anterior
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Producto agregado')));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Agregar Producto')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) => value!.isEmpty ? 'El nombre no puede estar vacío' : null,
              ),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Precio'),
                validator: (value) => value!.isEmpty ? 'El precio no puede estar vacío' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descripción'),
                validator: (value) => value!.isEmpty ? 'La descripción no puede estar vacía' : null,
              ),
              TextFormField(
                controller: _imageUrlController,
                decoration: InputDecoration(labelText: 'URL de la imagen'),
                validator: (value) => value!.isEmpty ? 'La URL de la imagen no puede estar vacía' : null,
              ),
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(labelText: 'Categoría'),
                validator: (value) => value!.isEmpty ? 'La categoría no puede estar vacía' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addProduct,
                child: Text('Agregar Producto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
