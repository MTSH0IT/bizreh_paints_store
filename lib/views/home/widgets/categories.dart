import 'package:bizreh_paints_store/views/catogorieDetails/catogorie_ditails_view.dart';
import 'package:flutter/material.dart';
import 'package:bizreh_paints_store/utils/widgets/image_network.dart';
import 'package:get/get.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});
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
    return SizedBox(
      height: 120,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, i) {
          final item = _categories[i];
          return GestureDetector(
            onTap: () {
              Get.to(() => CatogorieDitailsView());
            },
            child: _CategorieItem(item: item),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemCount: _categories.length,
      ),
    );
  }
}

class _CategorieItem extends StatelessWidget {
  const _CategorieItem({required this.item});

  final Map<String, String> item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: ImageNetwork(image: item['image'] as String),
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 80,
          child: Text(
            item['label'] as String,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}
