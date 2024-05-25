import 'package:flutter/material.dart';
import 'package:responsipraktpm/model/kopiDB.dart';
import 'package:hive/hive.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  Box<JenisKopi>? favoritesBox;
  List<JenisKopi> favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() async {
    favoritesBox = Hive.box<JenisKopi>('favorites');
    setState(() {
      favorites = favoritesBox!.values.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final item = favorites[index];
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Image.network(
                    item.imageUrl ?? 'https://via.placeholder.com/150',
                    fit: BoxFit.cover,
                  ),
                ),
                ListTile(
                  title: Text(item.name ?? 'Unknown'),
                  subtitle: Text('Price: ${item.price ?? 'N/A'}'),
                  trailing: IconButton(
                    icon: Icon(Icons.favorite, color: Colors.red),
                    onPressed: () {
                      _removeFromFavorites(item);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _removeFromFavorites(JenisKopi item) async {
    await favoritesBox!.delete(item.name);
    _loadFavorites(); // Refresh the list after removing the item
  }
}
