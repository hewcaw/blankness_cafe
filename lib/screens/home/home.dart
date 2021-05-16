import 'package:flutter/material.dart';

import '../../domain/models/models.dart' show GeneratorPack, GeneratorInfo;
import '../../domain/repositories.dart';
import '../generator/generator.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<GeneratorPack>> futureGeneratorPack;

  @override
  void initState() {
    super.initState();
    futureGeneratorPack = GeneratorRepository.fetchGeneratorPack();
  }

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
      body: FutureBuilder(
        future: futureGeneratorPack,
        builder: (context, AsyncSnapshot<List<GeneratorPack>> snapshot) {
          if (snapshot.hasData) {
            // return Text(snapshot.data!.title);
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 26),
              // itemCount: HomeMockData.cardItems.length,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                // final item = HomeMockData.cardItems[index];
                final item = snapshot.data![index];
                return SuggestionBlock(genPack: item);
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner.
          return CircularProgressIndicator();
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
  SuggestionBlock({required this.genPack});

  final GeneratorPack genPack;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // TODO: Responsive - remove all of the SizedBoxes below
      children: [
        Text(
          genPack.suggestion,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: 16),
        ...genPack.generators.map<Widget>(
          (value) => Column(
            children: [
              GeneratorListTile(genInfo: value),
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
    required this.genInfo,
  });

  final GeneratorInfo genInfo;

  @override
  Widget build(BuildContext context) {
    // TODO: Responsive
    // TODO: Can I use ListTile?
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Generator(
                    audios: genInfo.audios,
                  )),
        );
      },
      child: SizedBox(
        height: 64,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset(genInfo.thumbnail, height: 64.0, width: 64.0),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    genInfo.name,
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    genInfo.description,
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
