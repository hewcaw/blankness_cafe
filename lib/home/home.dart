import 'package:flutter/material.dart';

import '../data.dart';
import '../generator/generator.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: ,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: IconButton(
            icon: Icon(Icons.menu_open_sharp),
            onPressed: () {},
          ),
        ),
        actions: <Widget>[AppBarAvatar()],
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 26),
        itemCount: HomeMockData.cardItems.length,
        itemBuilder: (context, index) {
          final item = HomeMockData.cardItems[index];
          return SuggestionBlock(item: item);
        },
      ),
    );
  }
}

class AppBarAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.shade300,
              offset: Offset(0.0, 1.0),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.5),
          child: Image.asset(
            'assets/images/others/girl_toy_face.jpg',
            height: 32.0,
            width: 32.0,
          ),
        ),
      ),
      onPressed: null,
    );
  }
}

class SuggestionBlock extends StatelessWidget {
  SuggestionBlock({required this.item});

  final CardItemModel item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // TODO: Responsive - remove all of the SizedBoxes below
      children: [
        Text(
          item.guide,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: 16),
        ...item.items.map<Widget>(
          (value) => Column(
            children: [
              GeneratorListTile(
                thumbnail: value.img,
                title: value.title,
                subtitle: value.subtitle,
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
        SizedBox(height: 32),
      ],
    );
  }
}

class GeneratorListTile extends StatelessWidget {
  const GeneratorListTile({
    required this.thumbnail,
    required this.title,
    required this.subtitle,
  });

  final String thumbnail;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    // TODO: Responsive
    // TODO: Can I use ListTile?
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Generator()),
        );
      },
      child: SizedBox(
        height: 64,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset(thumbnail, height: 64.0, width: 64.0),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    this.title,
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    this.subtitle,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
