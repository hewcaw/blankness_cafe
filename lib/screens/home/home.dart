import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../../providers/generator_model.dart';
import '../../services/models/models.dart' show GeneratorPack, GeneratorInfo;
// import '../../services/generator_service.dart';
import '../generator/generator.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = context.read<GeneratorModel>();

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
        future: vm.fetchGeneratorPack(),
        builder: (context, AsyncSnapshot<List<GeneratorPack>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 26),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final item = snapshot.data![index];
                return SuggestionBlock(genPack: item);
              },
            );
          }

          if (snapshot.hasError) return Text("${snapshot.error}");

          return Center(child: CircularProgressIndicator());
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
      onTap: () async {
        // final repo = HomeRepository(await SharedPreferences.getInstance());
        // repo.moveToGenerator(genInfo.name);

        Navigator.push(
          context,
          // MaterialPageRoute(builder: (context) => Generator(audios: genInfo.audios)),
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
