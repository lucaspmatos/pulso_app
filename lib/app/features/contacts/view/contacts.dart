import 'package:flutter/material.dart';

import 'package:pulso_app/app/components/components.dart';
import 'package:pulso_app/app/core/constants/constants.dart';
import 'package:pulso_app/app/core/themes/text_theme.dart';

import 'package:pulso_app/app/features/contacts/model/contact.dart';
import 'package:pulso_app/app/features/contacts/contract/contacts_contract.dart';
import 'package:pulso_app/app/features/contacts/controller/contacts_controller.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> implements ContactsView {
  late final ContactsController _controller;
  List<Contact>? contacts;

  _ContactsState() {
    _controller = ContactsControllerImpl(this);
  }

  @override
  void initState() {
    super.initState();
    _controller.screenOpened();
  }

  @override
  void loadContacts(List<Contact> contactsList) {
    setState(() => contacts = contactsList);
  }

  Widget _loadPage(List<Contact>? contacts) {
    if (contacts != null) {
      return ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          if (contacts.isNotEmpty) {
            return Container(
              margin: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    contact.name ?? Texts.unavailable,
                    style: getTextTheme(context).headlineMedium,
                  ),
                  Row(
                    children: [
                      Text(
                        contact.phone ?? Texts.unavailable,
                        style: getTextTheme(context).bodyMedium,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _controller.deleteContact(contact.id!);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(1.0),
                        ),
                        child: const Icon(
                          Icons.delete_forever_outlined,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: ListTile(
              title: Text(Texts.contactsError),
            ),
          );
        },
      );
    }

    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          Text(
            Texts.loadingContacts,
            style: TextStyle(height: 4),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: DrawerAppBar(
        title: Texts.contacts,
        context: context,
      ),
      drawer: const AppDrawer(),
      body: _loadPage(contacts),
    );
  }
}
