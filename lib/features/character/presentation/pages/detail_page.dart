import 'package:bigio_test_app/features/character/domain/entities/character_entity.dart';
import 'package:bigio_test_app/features/character/presentation/provider/character_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final CharacterEntity char;
  const DetailPage({super.key, required this.char});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  CharacterEntity get object => widget.char;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      context.read<CharacterProvider>().checkIsFavorite(widget.char.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail's Page"),
        centerTitle: true,
        actions: [
          Consumer<CharacterProvider>(
            builder: (BuildContext context, charProv, _) {
              final isFavorite = charProv.isFav;
              return IconButton(
                onPressed: () async {
                  charProv.toggleFavorite(widget.char);
                },
                icon: Icon(
                  isFavorite == false
                      ? Icons.bookmark_add_outlined
                      : Icons.bookmark_added,
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(),
              child: Image.network(object.image, fit: BoxFit.cover),
            ),
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    IdentityText(title: "Name: ", content: object.name),
                    IdentityText(title: "Species: ", content: object.species),
                    IdentityText(title: "Gender: ", content: object.gender),
                    IdentityText(title: "Origin: ", content: object.origin),
                    IdentityText(title: "Location: ", content: object.location),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IdentityText extends StatelessWidget {
  const IdentityText({super.key, required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
          ),
          Text(
            content,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
