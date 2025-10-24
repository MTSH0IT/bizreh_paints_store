import 'package:flutter/material.dart';
import 'package:bizreh_paints_store/utils/widgets/see_all_card.dart';

class AllCategoriesView extends StatelessWidget {
  const AllCategoriesView({super.key});

  final _categories = const [
    {
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0EicNy1W3l04-ZEW1Tnp1TUN6FlX6SJ77Zg&s',
      'label': 'Interior',
    },
    {
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0EicNy1W3l04-ZEW1Tnp1TUN6FlX6SJ77Zg&s',
      'label': 'Exterior',
    },
    {
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0EicNy1W3l04-ZEW1Tnp1TUN6FlX6SJ77Zg&s',
      'label': 'Supplies',
    },
    {
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0EicNy1W3l04-ZEW1Tnp1TUN6FlX6SJ77Zg&s',
      'label': 'Stains',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          'All Categories',
          style: TextStyle(color: Colors.black),
        ),

        //actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 8),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.only(top: 8, bottom: 24),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 18,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.25,
                ),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  return SeeAllCard(
                    name: category['label']!,
                    imageUrl: category['image']!,
                    onTap: () {},
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
