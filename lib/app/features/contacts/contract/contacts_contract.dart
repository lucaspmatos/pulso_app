import 'package:pulso_app/app/features/contacts/model/contact.dart';

abstract class ContactsView {
  void loadContacts(List<Contact> contacts);
}

abstract class ContactsController {
  void screenOpened();
  void deleteContact(int id);
}