import 'package:flutter/material.dart';
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

  @override
  TextEditingController nameCtl = TextEditingController();
  @override
  TextEditingController phoneCtl = TextEditingController();

  ContactsControllerImpl(this._view);

  @override
  void dispose() {
    nameCtl.dispose();
    phoneCtl.dispose();
  }

  @override
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return Texts.usernameMsg;
    }
    return null;
  }

  @override
  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return Texts.passwordMsg;
    }
    return null;
  }

  void _changeSensorValue(String topic, String payload) {
    if (topic == Texts.refreshTopic) _view.reloadPage();
  }

  @override
  void saveContact() async {
    try {
      final newContact = Contact(
        userId: UserSession.instance.user!.id!,
        name: nameCtl.text,
        phone: phoneCtl.text,
      );

      await ContactService.postContact(newContact)
          .then((_) => MqttHandler.publish(Texts.refreshTopic));
      Fluttertoast.showToast(msg: Texts.saveContactSuccessMsg);

      nameCtl.clear();
      phoneCtl.clear();
    } catch (e) {
      Fluttertoast.showToast(msg: Texts.saveContactErrorMsg);
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
