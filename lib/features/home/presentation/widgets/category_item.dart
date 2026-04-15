import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/category_model.dart';

class CategoryItem extends StatelessWidget{

  final CategoryModel category;

  const CategoryItem({required this.category});

  @override
  Widget build(BuildContext context){
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.green.withOpacity(0.1),
              child: ClipOval(
                child: Image.network(
                  category.image,
                  fit: BoxFit.cover,
                  width: 40,
                  height: 40,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.image_not_supported, size: 30);
                  },
                ),
              ),
            ),
            SizedBox(height: 5,),
            Text(
              category.name,
              style: TextStyle(fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}