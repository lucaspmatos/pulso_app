import 'package:fluttertoast/fluttertoast.dart';

import 'package:pulso_app/app/api/contacts_service.dart';

import 'package:pulso_app/app/features/contacts/model/contact.dart';
import 'package:pulso_app/app/features/contacts/contract/contacts_contract.dart';

class ContactsControllerImpl implements ContactsController {
  final ContactsView _view;

  ContactsControllerImpl(this._view);

  Future<void> _loadContacts() async {
    try {
      List<Contact> fetchedContacts = await ContactService.getContacts();
      _view.loadContacts(fetchedContacts);
    } catch (e) {
      Fluttertoast.showToast(msg: 'Erro ao carregar contatos!');
    }
  }

  @override
  void deleteContact(int id) async {
    try {
      await ContactService.deleteContact(id);
      _loadContacts();
    } catch (e) {
      Fluttertoast.showToast(msg: 'Erro ao deletar contato!');
    }
  }

  @override
  void screenOpened() {
    _loadContacts();
  }
}
