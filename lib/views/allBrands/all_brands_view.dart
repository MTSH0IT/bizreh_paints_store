import 'package:flutter/material.dart';
import '../../utils/widgets/see_all_card.dart';

class AllBrandsView extends StatelessWidget {
  const AllBrandsView({super.key});

  List<Map<String, String>> get _brands => const [
    {
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRWbvsXkRkBLypibCkCWT_GQ9VWFXkGWU79Q&s',
      'name': 'Bizreh Group',
    },
    {
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRWbvsXkRkBLypibCkCWT_GQ9VWFXkGWU79Q&s',
      'name': 'Bizreh Group',
    },
    {
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRWbvsXkRkBLypibCkCWT_GQ9VWFXkGWU79Q&s',
      'name': 'Bizreh Group',
    },
    {
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRWbvsXkRkBLypibCkCWT_GQ9VWFXkGWU79Q&s',
      'name': 'Bizreh Group',
    },
    {
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRWbvsXkRkBLypibCkCWT_GQ9VWFXkGWU79Q&s',
      'name': 'Bizreh Group',
    },
    {
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRWbvsXkRkBLypibCkCWT_GQ9VWFXkGWU79Q&s',
      'name': 'Bizreh Group',
    },
    {
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRWbvsXkRkBLypibCkCWT_GQ9VWFXkGWU79Q&s',
      'name': 'Bizreh Group',
    },
    {
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRWbvsXkRkBLypibCkCWT_GQ9VWFXkGWU79Q&s',
      'name': 'Bizreh Group',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text('All Brands', style: TextStyle(color: Colors.black)),

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
                itemCount: _brands.length,
                itemBuilder: (context, index) {
                  final brand = _brands[index];
                  return SeeAllCard(
                    name: brand['name']!,
                    imageUrl: brand['image']!,
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
