// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

@HiveType(typeId: 3)
class CurrencyUnit extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  List<int> unitType;

  CurrencyUnit({
    required this.id,
    required this.name,
    required this.unitType,
  });
}
