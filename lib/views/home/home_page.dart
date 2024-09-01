import 'package:flutter/material.dart';
import 'package:yildiz_app/localization/localization.dart';
import 'package:yildiz_app/views/home/products.dart';
import 'home_page_widgets.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    var productData = getProductData(context);

    final filteredProducts = productData.where((product) {
      final titleLower = product['title']!.toLowerCase();
      final searchLower = searchQuery.toLowerCase();
      return titleLower.contains(searchLower);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Yildiz App')),
      ),
      body: GestureDetector(
        onTap: () {
          // This will unfocus the search field when tapping outside
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            SearchField(
              onSearchChanged: (query) {
                setState(() {
                  searchQuery = query;
                });
              },
              hintText: l('search_hint', context),
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
      ),
    );
  }
}
