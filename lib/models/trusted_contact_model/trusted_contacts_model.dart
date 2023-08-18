import 'package:hive/hive.dart';
part 'trusted_contacts_model.g.dart';

@HiveType(typeId: 1)
class TrustedContact {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String phoneNumber;
  TrustedContact(
      {required this.id, required this.name, required this.phoneNumber});
}
