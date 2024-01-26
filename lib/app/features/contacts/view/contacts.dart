import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:pulso_app/app/components/components.dart';
import 'package:pulso_app/app/core/themes/text_theme.dart';
import 'package:pulso_app/app/core/constants/constants.dart';

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
  void reloadPage() => setState(() {});

  Widget _errorWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          FontAwesomeIcons.userXmark,
          size: Numbers.hundred,
          color: Colors.pinkAccent.shade200,
        ),
        const Text(Texts.contactsError),
      ],
    );
  }

  Widget _loadPage(
    BuildContext context,
    AsyncSnapshot<List<Contact>?> snapshot,
  ) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            Text(
              Texts.loadingContacts,
              style: TextStyle(
                height: Numbers.four,
              ),
            ),
          ],
        ),
      );
    }
    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        return _errorWidget();
      } else if (snapshot.hasData) {
        contacts = snapshot.data;
        return ListView.builder(
          itemCount: contacts!.length,
          itemBuilder: (context, index) {
            final contact = contacts![index];
            return Container(
              margin: Numbers.contactsMargin,
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
                          padding: Numbers.deleteContactButtonPadding,
                        ),
                        child: const Icon(
                          Icons.delete_forever_outlined,
                          size: Numbers.deleteContactIconSize,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      }
    }
    return _errorWidget();
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
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width *
              (kIsWeb ? Numbers.monitorWebWidth : Numbers.monitorAppWidth),
          child: FutureBuilder<List<Contact>?>(
            future: _controller.loadContacts(),
            builder: _loadPage,
          ),
        ),
      ),
    );
  }
}
