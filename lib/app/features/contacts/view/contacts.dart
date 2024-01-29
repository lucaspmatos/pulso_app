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
  final _formKey = GlobalKey<FormState>();

  _ContactsState() {
    _controller = ContactsControllerImpl(this);
  }

  @override
  void initState() {
    super.initState();
    _controller.screenOpened();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void reloadPage() => setState(() {});

  void _addContact() async {
    if (_formKey.currentState!.validate()) _controller.saveContact();
  }

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
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              contact.phone ?? Texts.unavailable,
                              style: getTextTheme(context).bodyMedium,
                            ),
                            const SizedBox(width: Numbers.ten),
                            InkWell(
                              onTap: () =>
                                  _controller.deleteContact(contact.id!),
                              child: CircleAvatar(
                                child: Icon(
                                  Icons.delete_forever_outlined,
                                  size: Numbers.deleteContactIconSize,
                                  color: Colors.pinkAccent.shade200,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Visibility(
              visible: !kIsWeb,
              child: Container(
                color: ColorConstants.white,
                child: Padding(
                  padding: Numbers.measurementCardPadding,
                  child: ElevatedButton(
                    onPressed: _controller.deleteAllContacts,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          FontAwesomeIcons.userXmark,
                          color: Colors.redAccent,
                        ),
                        const SizedBox(
                          width: Numbers.ten,
                        ),
                        Text(
                          Texts.deleteAllContacts,
                          style: getTextTheme(context).bodyMedium?.copyWith(
                                color: Colors.redAccent,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
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
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Visibility(
                  visible: kIsWeb,
                  child: Container(
                    margin: Numbers.contactsMargin,
                    height: Numbers.drawerWebSize,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _controller.nameCtl,
                            decoration: InputDecoration(
                              labelStyle:
                                  getTextTheme(context).bodyMedium?.copyWith(
                                        color: Colors.pinkAccent.shade200,
                                      ),
                              labelText: Texts.name,
                            ),
                            validator: _controller.validateName,
                          ),
                          TextFormField(
                            controller: _controller.phoneCtl,
                            decoration: InputDecoration(
                              labelStyle:
                                  getTextTheme(context).bodyMedium?.copyWith(
                                        color: Colors.pinkAccent.shade200,
                                      ),
                              labelText: Texts.telephone,
                            ),
                            validator: _controller.validatePhone,
                          ),
                          const SizedBox(
                            height: Numbers.ten,
                          ),
                          ElevatedButton(
                            onPressed: _addContact,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  FontAwesomeIcons.userPlus,
                                  color: Colors.pinkAccent.shade200,
                                ),
                                const SizedBox(
                                  width: Numbers.ten,
                                ),
                                Text(
                                  Texts.addContact,
                                  style: getTextTheme(context)
                                      .bodyMedium
                                      ?.copyWith(
                                        color: Colors.pinkAccent.shade200,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: Numbers.ten),
              ),
              SliverFillRemaining(
                child: FutureBuilder<List<Contact>?>(
                  future: _controller.loadContacts(),
                  builder: _loadPage,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
