import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers.dart';
import '../widgets/add_category_dialog.dart';
import '../widgets/edit_category_dialog.dart';
import 'category_task_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your to-do lists'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, SettingsScreen.routeName);
            },
          ),
        ],
      ),
      body: Consumer<CategoryProvider>(
        builder: (context, categoryProvider, child) {
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: categoryProvider.categories.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 3 / 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (ctx, index) {
              final category = categoryProvider.categories[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    CategoryTaskScreen.routeName,
                    arguments: {'categoryIndex': index, 'categoryTitle': category['title']},
                  );
                },
                child: Card(
                  child: Column(
                    children: [
                      Image.network(category['imageUrl'], fit: BoxFit.cover, height: 340, width: double.infinity),
                      SizedBox(height: 10),
                      Text(category['title']),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => EditCategoryDialog(index: index, category: category),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              Provider.of<CategoryProvider>(context, listen: false).deleteCategory(index);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddCategoryDialog(),
          );
        },
      ),
    );
  }
}
