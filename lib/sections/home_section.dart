import 'package:flutter/material.dart';

class HomeSection extends StatelessWidget {
   HomeSection({super.key});

  final List<Map<String, String>> tileItems =  [
    {"title": "Tasbih", "icon": "assets/icons/tasbih.png"},
    {"title": "Hadith", "icon": "assets/icons/hadith.png"},
    {"title": "Dua", "icon": "assets/icons/islamic.png"},
    {"title": "Ayah", "icon": "assets/icons/quran.png"},
    {"title": "Naat", "icon": "assets/icons/naat.png"},
    {"title": "Nohy", "icon": "assets/icons/nohay.png"},
    {"title": "Post", "icon": "assets/icons/post.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0,right: 12.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: tileItems.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          final item = tileItems[index];
          return GestureDetector(
            onTap: () {
              // TODO: Handle on tap for each tile
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(item['icon']!, height: 50),
                  const SizedBox(height: 10),
                  Text(
                    item['title']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
