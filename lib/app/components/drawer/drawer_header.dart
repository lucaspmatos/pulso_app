import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:pulso_app/app/core/themes/themes.dart';
import 'package:pulso_app/app/core/constants/constants.dart';
import 'package:pulso_app/app/features/login/model/user.dart';

class Header extends StatelessWidget {
  Header({super.key});
  final user = UserSession.instance.user;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kIsWeb
          ? Numbers.drawerWebSize
          : MediaQuery.of(context).size.width * Numbers.drawerAppHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(
              left: 15,
              right: 15,
              bottom: 17,
            ),
            child: const CircleAvatar(
              backgroundColor: Colors.pink,
              radius: 40,
              child: Icon(
                Icons.person,
                color: ColorConstants.white,
                size: Numbers.fifty,
              ),
            ),
          ),
          Column(
            children: [
              Text(
                user?.name ?? Texts.noData,
                style: getTextTheme(context).headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                    ),
              ),
              Text(
                '${user?.age.toString() ?? Texts.noData} ${Texts.years}',
                style: getTextTheme(context).headlineMedium?.copyWith(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
