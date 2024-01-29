import 'package:flutter/material.dart';
import 'package:pulso_app/app/features/contacts/model/contact.dart';

abstract class ContactsView {
  void reloadPage();
}

abstract class ContactsController {
  late final TextEditingController nameCtl;
  late final TextEditingController phoneCtl;

  void dispose();
  void saveContact();
  void screenOpened();
  void deleteAllContacts();
  void deleteContact(int id);
  String? validateName(String? value);
  String? validatePhone(String? value);
  Future<List<Contact>?> loadContacts();
}