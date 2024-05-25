import 'package:flutter/material.dart';
import 'package:responsipraktpm/model/kopiDB.dart';
import 'package:hive/hive.dart';

class DetailPage extends StatefulWidget {
  final JenisKopi detail;

  const DetailPage({Key? key, required this.detail}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Box<bool>? favoritesBox;

  @override
  void initState() {
    super.initState();
    favoritesBox = Hive.box<bool>('favorites');
    isFavorited = favoritesBox?.get(widget.detail.name) ?? false;
  }

  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          widget.detail.name ?? 'Character Detail',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(isFavorited ? Icons.favorite : Icons.favorite_border),
            onPressed: () async {
              setState(() {
                isFavorited = !isFavorited;
              });
              await favoritesBox?.put(widget.detail.name, isFavorited);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isFavorited
                      ? 'Added to Favorites'
                      : 'Removed from Favorites'),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.detail.imageUrl != null)
                Center(
                  child: Image.network(
                    widget.detail.imageUrl!,
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              SizedBox(height: 16.0),
              Text('Name: ${widget.detail.name ?? ''}'),
              Text('Price: ${widget.detail.price ?? 'N/A'}'),
              Text('Roast Level: ${widget.detail.roastLevel ?? 'N/A'}'),
              Text('Region: ${widget.detail.region ?? 'N/A'}'),
              Text('Description: ${widget.detail.description ?? ''}'),
            ],
          ),
        ),
      ),
    );
  }
}
