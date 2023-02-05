// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:medical_devices/business_logic/bloc/authorization/authorization_bloc.dart';
import 'package:medical_devices/data/Models/Observation.dart';
import 'package:medical_devices/data/Services/userService.dart';
import 'package:settings_ui/settings_ui.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({Key? key}) : super(key: key);

  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  late String selectedLanguage = "English";
  UserService userService = UserService();
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getCurrentLanguage();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        title: Text(
          translate('titles.beHealthApp'),
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.chat_bubble_rounded))],
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text(translate('pages.config_page.common')),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                onPressed: ((context) {
                  if (selectedLanguage == "English") {
                    selectedLanguage = "Español";
                    changeLocale(context, 'es');
                  } else {
                    selectedLanguage = "English";
                    changeLocale(context, 'en');
                  }
                  setState(() {});
                }),
                leading: Icon(Icons.language),
                title: Text(translate('pages.config_page.language')),
                value: Text(selectedLanguage),
              ),
            ],
          ),
          SettingsSection(
            title: Text(translate('pages.config_page.profile')),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                onPressed: ((context) {}),
                leading: Icon(Icons.language),
                title: Text('Email'),
              ),
              SettingsTile.navigation(
                onPressed: ((context) {}),
                leading: Icon(Icons.phone),
                title: Text(translate('pages.config_page.phone_number')),
              ),
              SettingsTile.navigation(
                onPressed: ((context) {}),
                leading: Icon(Icons.house),
                title: Text(translate('pages.config_page.addresses')),
              ),
            ],
          ),
          SettingsSection(
            title: Text(translate('pages.config_page.security')),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                onPressed: ((context) {}),
                leading: Icon(Icons.security),
                title: Text(translate('pages.config_page.roles_permissions')),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void getCurrentLanguage() {
    if (Localizations.localeOf(context).languageCode == 'es') {
      selectedLanguage = "Español";
    }
    if (Localizations.localeOf(context).languageCode == 'en') {
      selectedLanguage = "English";
    }
    setState(() {});
  }
}
