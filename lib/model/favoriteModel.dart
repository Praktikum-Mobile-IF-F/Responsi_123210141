import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsipraktpm/main.dart';

@HiveType(typeId: 0)
class JenisKopi extends HiveObject {
  @HiveField(0)
  String? name;

  @HiveField(1)
  String? imageUrl;

  @HiveField(2)
  double? price;

  // Additional fields
}
