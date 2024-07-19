import 'package:flutter/material.dart';
import 'package:yildiz_app/localization/localization.dart';
import 'home_page_widgets.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    String l(key) => Localizer.of(context).translate(key);
    final productData = [
      {
        'id': '1',
        'title': l('milk'),
        'description': l('milk_description'),
        'price': '7€',
        'imagePath': 'assets/images/milk.jpeg',
      },
      {
        'id': '2',
        'title': l('egg'),
        'description': l('egg_description'),
        'price': '7€',
        'imagePath': 'assets/images/egg.jpeg',
      },
      {
        'id': '3',
        'title': l('nuts_title'),
        'description': l('nuts_description'),
        'price': '19€',
        'imagePath': 'assets/images/nuts.jpeg',
      },
      {
        'id': '4',
        'title': l('honey_title'),
        'description': l('honey_description'),
        'price': '30€',
        'imagePath': 'assets/images/honey.jpeg',
      },
      {
        'id': '5',
        'title': l('yogurt_title'),
        'description': l('yogurt_description'),
        'price': '10€',
        'imagePath': 'assets/images/yogurt.jpeg',
      },
      {
        'id': '6',
        'title': l('cheese_title'),
        'description': l('cheese_description'),
        'price': '15€',
        'imagePath': 'assets/images/cheese.jpeg',
      },
    ];

    final filteredProducts = productData.where((product) {
      final titleLower = product['title']!.toLowerCase();
      final searchLower = searchQuery.toLowerCase();
      return titleLower.contains(searchLower);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Yildiz App')),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: l('search_hint'),
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              onChanged: (query) {
                setState(() {
                  searchQuery = query;
                });
              },
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.75,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return ProductCard(
                  id: product['id']!,
                  title: product['title']!,
                  description: product['description']!,
                  price: product['price']!,
                  imagePath: product['imagePath']!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
