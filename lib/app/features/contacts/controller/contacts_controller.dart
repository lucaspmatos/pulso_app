import 'package:fluttertoast/fluttertoast.dart';

import 'package:pulso_app/app/broker/mqtt_handler.dart';
import 'package:pulso_app/app/api/contacts_service.dart';
import 'package:pulso_app/app/core/constants/constants.dart';

import 'package:pulso_app/app/features/login/model/user.dart';
import 'package:pulso_app/app/features/contacts/model/contact.dart';
import 'package:pulso_app/app/features/contacts/contract/contacts_contract.dart';

class ContactsControllerImpl implements ContactsController {
  final ContactsView _view;
  List<Contact> fetchedContacts = [];
  ContactsControllerImpl(this._view);

  void _changeSensorValue(String topic, String payload) {
    if (topic == Texts.refreshTopic) _view.reloadPage();
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
    UserSession.instance.currentRoute = Texts.contactsRoute;
    MqttHandler.subscribe([Texts.refreshTopic], _changeSensorValue);
  }

  @override
  Future<List<Contact>?> loadContacts() async {
    try {
      fetchedContacts = await ContactService.getContacts();
      return fetchedContacts;
    } catch (e) {
      Fluttertoast.showToast(msg: Texts.loadContactsErrorMsg);
      return null;
    }
  }
}
