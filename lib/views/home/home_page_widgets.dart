import 'package:flutter/material.dart';

// Class for the product card in small form
class ProductCard extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final String price;
  final String imagePath;

  const ProductCard({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'product-$id',
      child: Material(
        elevation: 4.0,
        borderRadius: BorderRadius.circular(20.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(
                  id: id,
                  title: title,
                  description: description,
                  price: price,
                  imagePath: imagePath,
                ),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
                child: Image.asset(
                  imagePath,
                  height: 150.0,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4.0),
                    Text(description, style: TextStyle(fontSize: 12.0)),
                    SizedBox(height: 8.0),
                    Text(price,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Class for the product detail page
class ProductDetailPage extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final String price;
  final String imagePath;

  const ProductDetailPage({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Hero(
              tag: 'product-$id',
              child: Material(
                elevation: 4.0,
                borderRadius: BorderRadius.circular(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20.0)),
                      child: Image.asset(
                        imagePath,
                        height: 300.0,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    ListTile(
                      title: Text(title),
                      subtitle: Text(description),
                      trailing: Text(price, style: TextStyle(fontSize: 20.0)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
