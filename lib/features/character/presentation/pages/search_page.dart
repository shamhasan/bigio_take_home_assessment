import 'dart:async';

import 'package:bigio_test_app/core/utils/request_state.dart';
import 'package:bigio_test_app/features/character/presentation/pages/detail_page.dart';
import 'package:bigio_test_app/features/character/presentation/provider/character_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.length >= 3) {
        Provider.of<CharacterProvider>(
          context,
          listen: false,
        ).searchCharacter(query);
      } else if (query.length < 3) {
        Provider.of<CharacterProvider>(context, listen: false).resetSearch();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Search Page"),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 80),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchBar(
              leading: Icon(Icons.search),
              hintText: "Type your character here",
              controller: _searchController,
              onChanged: _onSearchChanged,
            ),
          ),
        ),
      ),
      body: Consumer<CharacterProvider>(
        builder: (context, charProv, _) {
          if (charProv.searchState == RequestState.loading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Loading.."),
                  const CircularProgressIndicator(),
                ],
              ),
            );
          } else if (charProv.searchState == RequestState.loaded) {
            if (charProv.searchCharacters.isEmpty) {
              return const Center(child: Text("Character not found"));
            }

            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 16,
              ),
              child: ListView.builder(
                itemCount: charProv.searchCharacters.length,
                itemBuilder: (context, index) {
                  final e = charProv.searchCharacters[index];
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
          } else if (charProv.searchState == RequestState.empty) {
            if (_searchController.text.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search),
                    Text("Type name to search"),
                  ],
                ),
              );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("Character not found")],
              ),
            );
          } else if (charProv.searchState == RequestState.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.warning, size: 80, color: Colors.grey),
                  Text(charProv.message),
                ],
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
