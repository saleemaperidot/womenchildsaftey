import 'package:hive_flutter/hive_flutter.dart';
import 'package:womensaftey/models/trusted_contact_model/trusted_contacts_model.dart';
import 'package:womensaftey/services/trusted_contact_servises/trusted_contact_servises.dart';

const String DBNAME = 'contact_db';

class TrustedRepo implements TrustedContactServises {
  TrustedRepo._internal();
  static TrustedRepo instance = TrustedRepo._internal();
  factory TrustedRepo() {
    return instance;
  }
  @override
  Future<void> delete(String id) async {
    final _categorydb = await Hive.openBox<TrustedContact>(DBNAME);
    _categorydb.delete(id);
  }

  @override
  Future<List<TrustedContact>> getContact() async {
    try {
      final _contactdb = await Hive.openBox<TrustedContact>(DBNAME);
      final contactList = _contactdb.values.toList();
      return contactList;
    } catch (e) {
      return [];
    }
    // TODO: implement getCategories
  }

  @override
  Future<int> insert(TrustedContact trustedModel) async {
    try {
      final _contactdb = await Hive.openBox<TrustedContact>(DBNAME);
      _contactdb.put(trustedModel.id, trustedModel);
      // TODO: implement insert
      return 1;
    } catch (e) {
      return 0;
    }
  }
}
