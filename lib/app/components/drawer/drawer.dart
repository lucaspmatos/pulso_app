import 'package:flutter/material.dart';

import 'package:pulso_app/app/router/routes.dart';
import 'package:pulso_app/app/core/constants/constants.dart';
import 'package:pulso_app/app/components/drawer/drawer_item.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Drawer(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 1,
          child: Column(
            children: <Widget>[
              const DrawerHeader(child:
                SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                )
              ),
              DrawerItem(
                icon: Icons.monitor_heart,
                text: Texts.monitorItem,
                onTap: () => Routes.homePageRoute(context),
              ),
              const Divider(color: ColorConstants.grey),
              DrawerItem(
                icon: Icons.history,
                text: Texts.historyItem,
                onTap: () => Routes.homePageRoute(context),
              ),
              const Divider(color: ColorConstants.grey),
              DrawerItem(
                icon: Icons.contacts,
                text: Texts.contactsItem,
                onTap: () => Routes.homePageRoute(context),
              ),
              // Spacer(),
              const Divider(color: ColorConstants.grey),
              /*DrawerItem(
                icon: Icons.logout_rounded,
                iconColor: ColorConstants.mainOrange,
                text: Texts.signOut,
                textColor: ColorConstants.mainOrange,
                onTap: () => Get.offAllNamed(Routes.login),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
