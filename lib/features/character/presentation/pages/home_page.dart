import 'package:bigio_test_app/core/utils/request_state.dart';
import 'package:bigio_test_app/features/character/presentation/pages/detail_page.dart';
import 'package:bigio_test_app/features/character/presentation/pages/favorite_page.dart';
import 'package:bigio_test_app/features/character/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bigio_test_app/features/character/presentation/provider/character_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      context.read<CharacterProvider>().fetchCharacters();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rick and Morty's Wiki "),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SearchPage();
                  },
                ),
              );
            },
            icon: Icon(Icons.search_outlined),
          ),
          IconButton(icon: Icon(Icons.bookmark), onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return FavoritePage();
            }));
          }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<CharacterProvider>(
          builder: (BuildContext context, CharacterProvider charProv, _) {
            final object = charProv.homeCharacters;
            if (charProv.homeState == RequestState.loading) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [CircularProgressIndicator(), Text("Loading..")],
                ),
              );
            } else if (charProv.homeState == RequestState.loaded) {
              return ListView.builder(
                itemCount: object.length,
                itemBuilder: (context, index) {
                  final e = object[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DetailPage(char: e);
                            },
                          ),
                        );
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      tileColor: Colors.blueAccent[100],
                      leading: CircleAvatar(
                        backgroundColor: Colors.green,
                        backgroundImage: NetworkImage(e.image),
                      ),
                      title: Text(e.name.toString()),
                    ),
                  );
                },
              );
            } else if (charProv.homeState == RequestState.empty) {
              return Center(child: Text(charProv.message));
            } else if (charProv.homeState == RequestState.error) {
              return Center(child: Text(charProv.message));
            } else {
              return Center();
            }
          },
        ),
      ),
    );
  }
}
