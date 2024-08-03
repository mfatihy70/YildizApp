import 'package:yildiz_app/localization/localization.dart';

List<Map<String, dynamic>> getProductData(context) {
  return [
    {
      'id': '1',
      'title': l('milk', context),
      'description': l('milk_description', context),
      'price': '7€',
      'imagePath': 'assets/images/milk.jpeg',
    },
    {
      'id': '2',
      'title': l('egg', context),
      'description': l('egg_description', context),
      'price': '7€',
      'imagePath': 'assets/images/egg.jpeg',
    },
    {
      'id': '3',
      'title': l('nuts_title', context),
      'description': l('nuts_description', context),
      'price': '19€',
      'imagePath': 'assets/images/nuts.jpeg',
    },
    {
      'id': '4',
      'title': l('honey_title', context),
      'description': l('honey_description', context),
      'price': '30€',
      'imagePath': 'assets/images/honey.jpeg',
    },
    {
      'id': '5',
      'title': l('yogurt_title', context),
      'description': l('yogurt_description', context),
      'price': '10€',
      'imagePath': 'assets/images/yogurt.jpeg',
    },
    {
      'id': '6',
      'title': l('cheese_title', context),
      'description': l('cheese_description', context),
      'price': '15€',
      'imagePath': 'assets/images/cheese.jpeg',
    },
  ];
}