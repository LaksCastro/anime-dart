import 'package:anime_dart/app/screens/home/screens/category/widgets/list.dart';
import 'package:anime_dart/app/widgets/waifu/waifu_widget.dart';
import 'package:flutter/material.dart';
import 'package:anime_dart/app/screens/home/screens/category/categories_enum.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({Key key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(top: 10, bottom: 0),
      separatorBuilder: (_, __) =>
          Divider(height: 5, color: Colors.transparent),
      itemCount: categories.length + 1,
      itemBuilder: (context, index) {
        if (index == categories.length) {
          return WaifuWidget();
        }

        void onTap() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CategoryList(
                label: categories[index]['label'],
                query: categories[index]['query'],
              ),
            ),
          );
        }

        return GestureDetector(
          onTap: onTap,
          child: Container(
            color: Theme.of(context).cardColor,
            child: ListTile(
              title: Text(categories[index]['label']),
              leading: Icon(
                categories[index]['icon'],
                color: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .color
                    .withOpacity(0.5),
              ),
            ),
          ),
        );
      },
    );
  }
}
