import 'package:womensaftey/models/trusted_contact_model/trusted_contacts_model.dart';

abstract class TrustedContactServises {
  Future<void> insert(TrustedContact categoryModel);
  Future<List<TrustedContact>> getContact();
  Future<void> delete(String id);
}
