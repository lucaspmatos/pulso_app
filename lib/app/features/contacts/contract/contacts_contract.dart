import 'package:pulso_app/app/features/contacts/model/contact.dart';

abstract class ContactsView {
  void reloadPage();
}

abstract class ContactsController {
  void screenOpened();
  void deleteContact(int id);
  Future<List<Contact>?> loadContacts();
}