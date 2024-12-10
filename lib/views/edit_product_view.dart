import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/models/product.dart';
import 'package:my_ecommerce_app/controllers/product_controller.dart';
import 'package:provider/provider.dart';

class EditProductPage extends StatefulWidget {
  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  late Product product;
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Recibir el producto desde la navegación
    product = ModalRoute.of(context)!.settings.arguments as Product;
    _nameController = TextEditingController(text: product.name);
    _priceController = TextEditingController(text: product.price.toString());
    _descriptionController = TextEditingController(text: product.description);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveProduct(ProductController productController) {
    if (_formKey.currentState!.validate()) {
      setState(() {
        product.name = _nameController.text;
        product.price = double.parse(_priceController.text);
        product.description = _descriptionController.text;
      });

      // Usar el ProductController para actualizar el producto
      productController.updateProduct(product);

      Navigator.pop(context);  // Regresar a la página anterior
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Producto actualizado')));
    }
  }
  

  @override
  Widget build(BuildContext context) {
    final productController = Provider.of<ProductController>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Editar Producto')),
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _saveProduct(productController),
                child: Text('Guardar Cambios'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
