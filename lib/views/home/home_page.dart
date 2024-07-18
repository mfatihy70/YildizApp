import 'package:flutter/material.dart';
import 'package:yildiz_app/localization/localization.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String l(key) => Localizer.of(context).translate(key);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Yildiz App')),
      ),
      body: ListView(
        children: [
          ProductCard(
            id: '1',
            title: l('milk'),
            description: l('milk_description'),
            price: '7€',
            imagePath: 'assets/images/milk.jpeg',
          ),
          ProductCard(
            id: '2',
            title: l('egg'),
            description: l('egg_description'),
            price: '7€',
            imagePath: 'assets/images/egg.jpeg',
          ),
          ProductCard(
            id: '3',
            title: l('nuts_title'),
            description: l('nuts_description'),
            price: '19€',
            imagePath: 'assets/images/nuts.jpeg',
          ),
          ProductCard(
            id: '4',
            title: l('honey_title'),
            description: l('honey_description'),
            price: '30€',
            imagePath: 'assets/images/honey.jpeg',
          ),
          ProductCard(
            id: '5',
            title: l('yogurt_title'),
            description: l('yogurt_description'),
            price: '10€',
            imagePath: 'assets/images/yogurt.jpeg',
          ),
          ProductCard(
            id: '6',
            title: l('cheese_title'),
            description: l('cheese_description'),
            price: '15€',
            imagePath: 'assets/images/cheese.jpeg',
          ),
        ],
      ),
    );
  }
}

// Custom ProductCard widget
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Hero(
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
    );
  }
}

// Custom ProductDetailPage widget
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
      body: Center(
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
                        BorderRadius.vertical(top: Radius.circular(10.0)),
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
    );
  }
}
