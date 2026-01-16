import 'package:bigio_test_app/core/utils/request_state.dart';
import 'package:bigio_test_app/features/character/presentation/pages/detail_page.dart';
import 'package:bigio_test_app/features/character/presentation/provider/character_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CharacterProvider>().loadFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your favorite characters"),
        centerTitle: true,
      ),
      body: Consumer<CharacterProvider>(
        builder: (BuildContext context, charProv, _) {
          final object = charProv.favCharacters;
          if (charProv.favState == RequestState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (charProv.favState == RequestState.error) {
            return Center(child: Text(charProv.message));
          } else if (charProv.favState == RequestState.empty ||
              charProv.favCharacters.isEmpty) {
            return const Center(
              child: Text("You don't have favorite characters yet."),
            );
          } else if (charProv.favState == RequestState.loaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 4,
              ),
              child: ListView.builder(
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
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
