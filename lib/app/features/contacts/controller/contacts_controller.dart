import 'package:fluttertoast/fluttertoast.dart';

import 'package:pulso_app/app/broker/mqtt_handler.dart';
import 'package:pulso_app/app/api/contacts_service.dart';
import 'package:pulso_app/app/core/constants/constants.dart';

import 'package:pulso_app/app/features/contacts/model/contact.dart';
import 'package:pulso_app/app/features/contacts/contract/contacts_contract.dart';

class ContactsControllerImpl implements ContactsController {
  final ContactsView _view;

  ContactsControllerImpl(this._view);

  void _changeSensorValue(String topic, String payload) {
    if (topic == Texts.refreshTopic) _loadContacts();
  }

  Future<void> _loadContacts() async {
    try {
      List<Contact> fetchedContacts = await ContactService.getContacts();
      _view.loadContacts(fetchedContacts);
    } catch (e) {
      Fluttertoast.showToast(msg: Texts.loadContactsErrorMsg);
    }
  }

  @override
  void deleteContact(int id) async {
    try {
      await ContactService.deleteContact(id)
          .then((_) => MqttHandler.publish(Texts.refreshTopic));
    } catch (e) {
      Fluttertoast.showToast(msg: Texts.deleteContactErrorMsg);
    }
  }

  @override
  void screenOpened() {
    MqttHandler.subscribe([Texts.refreshTopic], _changeSensorValue);
    _loadContacts();
  }
}
