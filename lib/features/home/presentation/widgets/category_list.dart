import 'package:ecommerce_app/category_mock_data.dart';
import 'package:ecommerce_app/features/home/presentation/widgets/category_item.dart';
import 'package:flutter/cupertino.dart';

class CategoryList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return CategoryItem(category: categories[index]);
          }
      ),
    );
  }
}