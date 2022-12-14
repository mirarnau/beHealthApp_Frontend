// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:medical_devices/business_logic/bloc/authorization/authorization_bloc.dart';
import 'package:medical_devices/data/Models/User.dart';
import 'package:medical_devices/presentation/Pages/utilities/constants.dart';

List<String> listElementsLanguage = <String>['English', 'Español'];

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _rememberMe = false;

  List<String> listElementsGender = <String>[
    translate('pages.register_page.male'),
    translate('pages.register_page.female'),
    translate('pages.register_page.unknown'),
    translate('pages.register_page.others'),
  ];
  List<String> listElementsUseAddress = <String>[
    translate('pages.register_page.home'),
    translate('pages.register_page.work'),
    translate('pages.register_page.temporal'),
  ];

  String selectedElementGender = translate('pages.register_page.male');
  String selectedElementUseAddress = translate('pages.register_page.home');
  String selectedElementLanguage = listElementsLanguage.first;

  String selectedRole = "";
  bool managerSelected = false;

  final nameController = TextEditingController();
  final surnamesController = TextEditingController();
  final emailController = TextEditingController();
  final birthDateController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final postalController = TextEditingController();
  final countryController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();

  void initState() {
    changeLocale(context, 'en');
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    repeatPasswordController.dispose();
    super.dispose();
  }

  Widget _buildNameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          translate('pages.register_page.name'),
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: nameController,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: translate('pages.register_page.enter_name'),
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSurnameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          translate('pages.register_page.surnames'),
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: surnamesController,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: translate('pages.register_page.enter_surnames'),
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          translate('pages.login_page.email'),
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: emailController,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.mail,
                color: Colors.white,
              ),
              hintText: translate('pages.login_page.enter_email'),
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBirthDateTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          translate('pages.register_page.birth_date'),
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: birthDateController,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.calendar_month,
                color: Colors.white,
              ),
              hintText: translate('pages.register_page.enter_birthdate'),
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          translate('pages.register_page.gender'),
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: DropdownButton(
              value: selectedElementGender,
              items: listElementsGender.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedElementGender = value!;
                });
              },
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
                fontSize: 15.0,
              ),
              dropdownColor: Color.fromARGB(255, 30, 61, 72),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUseAddressTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          translate('pages.register_page.use_address'),
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: DropdownButton(
              value: selectedElementUseAddress,
              items: listElementsUseAddress.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedElementUseAddress = value!;
                });
              },
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
                fontSize: 15.0,
              ),
              dropdownColor: Color.fromARGB(255, 30, 61, 72),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneNumberTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          translate('pages.register_page.phone_number'),
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: phoneNumberController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.phone,
                color: Colors.white,
              ),
              hintText: translate('pages.register_page.enter_phone_number'),
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddressTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          translate('pages.register_page.address'),
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: addressController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.house,
                color: Colors.white,
              ),
              hintText: translate('pages.register_page.enter_address'),
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCityTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          translate('pages.register_page.city'),
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: cityController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.location_city,
                color: Colors.white,
              ),
              hintText: translate('pages.register_page.enter_city'),
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPostalCodeTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          translate('pages.register_page.postal_code'),
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: postalController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.change_history,
                color: Colors.white,
              ),
              hintText: translate('pages.register_page.enter_postal_code'),
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCountryTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          translate('pages.register_page.country'),
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: countryController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.flag,
                color: Colors.white,
              ),
              hintText: translate('pages.register_page.select_country'),
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLanguageTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          translate('pages.register_page.language'),
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: DropdownButton(
              value: selectedElementLanguage,
              items: listElementsLanguage.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedElementLanguage = value!;
                  if (selectedElementLanguage == 'English') changeLocale(context, 'en');
                  if (selectedElementLanguage == 'Español') changeLocale(context, 'es');
                });
              },
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
                fontSize: 15.0,
              ),
              dropdownColor: Color.fromARGB(255, 30, 61, 72),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          translate('pages.login_page.password'),
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: passwordController,
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: translate('pages.login_page.enter_password'),
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRepeatPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          translate('pages.register_page.repeat_password'),
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: repeatPasswordController,
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: translate('pages.register_page.enter_repeat_password'),
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRoleSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          translate('pages.register_page.select_role'),
          style: kLabelStyle,
        ),
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedRole = "PATIENT";
                  managerSelected = false;
                });
              },
              child: Container(
                height: 140.0,
                width: 140.0,
                decoration: BoxDecoration(
                  color: selectedRole == "PATIENT" ? Color.fromARGB(255, 5, 232, 185) : Color.fromARGB(190, 30, 61, 72),
                  borderRadius: BorderRadius.circular(40.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 24.0, 0.0, 32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        color: selectedRole == "PATIENT" ? Colors.black : Colors.white,
                        size: 60.0,
                      ),
                      Spacer(),
                      Text(
                        translate('pages.register_page.role_patient'),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: selectedRole == "PATIENT" ? Colors.black : Colors.white,
                          fontSize: 16.0,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedRole = "MANAGER";
                  managerSelected = true;
                });
              },
              child: Container(
                height: 140.0,
                width: 140.0,
                decoration: BoxDecoration(
                  color: selectedRole == "MANAGER" ? Color.fromARGB(255, 5, 232, 185) : Color.fromARGB(190, 30, 61, 72),
                  borderRadius: BorderRadius.circular(40.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 24.0, 0.0, 32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.settings_accessibility,
                        color: selectedRole == "MANAGER" ? Colors.black : Colors.white,
                        size: 60.0,
                      ),
                      Spacer(),
                      Text(
                        translate('pages.register_page.role_manager'),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: selectedRole == "MANAGER" ? Colors.black : Colors.white,
                          fontSize: 16.0,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildRegisterBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      // ignore: deprecated_member_use
      child: BlocConsumer<AuthorizationBloc, AuthorizationState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AuthorizingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return BlocConsumer<AuthorizationBloc, AuthorizationState>(
              listener: (context, state) {
                if (state is AuthorizedState) {
                  Navigator.of(context).pushNamed('/');
                }
              },
              builder: (context, state) {
                if (state is RegisteringState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return RaisedButton(
                  elevation: 5.0,
                  onPressed: () {
                    if (nameController.text.isNotEmpty && surnamesController.text.isNotEmpty && emailController.text.isNotEmpty && birthDateController.text.isNotEmpty && phoneNumberController.text.isNotEmpty && addressController.text.isNotEmpty && cityController.text.isNotEmpty && postalController.text.isNotEmpty && countryController.text.isNotEmpty && passwordController.text.isNotEmpty && repeatPasswordController.text.isNotEmpty) {
                      User newPatient = User();
                      newPatient.password = passwordController.text;
                      newPatient.resourceType = 'Patient';
                      newPatient.active = true;
                      newPatient.name = [Name(use: 'usual', family: surnamesController.text, text: '${nameController.text} ${surnamesController.text}')];
                      newPatient.telecom = [Telecom(system: 'email', value: emailController.text), Telecom(system: 'phone', value: phoneNumberController.text)];
                      newPatient.gender = selectedElementGender == translate('pages.register_page.male')
                          ? "male"
                          : selectedElementGender == translate('pages.register_page.female')
                              ? "female"
                              : selectedElementGender == translate('pages.register_page.unknown')
                                  ? "unknown"
                                  : "others";
                      var splittedBirthDate = birthDateController.text.split('/');
                      newPatient.birthDate = '${splittedBirthDate.last}-${splittedBirthDate[1]}-${splittedBirthDate[0]}';
                      Address address = Address(
                          use: selectedElementUseAddress == translate('pages.register_page.home')
                              ? 'home'
                              : selectedElementUseAddress == translate('pages.register_page.work')
                                  ? 'work'
                                  : 'temp',
                          city: cityController.text,
                          postalCode: postalController.text,
                          country: countryController.text);
                      address.line = [addressController.text];
                      newPatient.address = [address];
                      Communication communication = Communication();
                      Language language = Language();
                      Coding coding = Coding(system: 'urn:ietf:bcp:47', code: selectedElementLanguage == 'Español' ? 'es' : 'en', display: selectedElementLanguage);
                      language.coding = [coding];
                      communication.language = language;
                      newPatient.communication = [communication];
                      print(jsonEncode(User.toJsonApi(newPatient)));
                      BlocProvider.of<AuthorizationBloc>(context).add(RegisterEvent(newPatient, managerSelected));
                      Navigator.pushNamed(context, '/');
                    }
                  },
                  padding: EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Colors.white,
                  child: Text(
                    translate('pages.register_page.sign_up'),
                    style: TextStyle(
                      color: Color.fromARGB(255, 33, 40, 48),
                      letterSpacing: 1.5,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
            () => print('Login with Google'),
            AssetImage(
              'assets/images/google.png',
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 30, 61, 72),
                      Color.fromARGB(255, 30, 61, 72),
                      Color.fromARGB(222, 30, 61, 72),
                      Color.fromARGB(255, 242, 183, 5),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 10.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                          width: 200.0,
                          height: 160.0,
                          image: AssetImage(
                            'assets/images/logo.png',
                          )),
                      _buildLanguageTF(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildNameTF(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildSurnameTF(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildEmailTF(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildBirthDateTF(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildGenderTF(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildPhoneNumberTF(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildAddressTF(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildUseAddressTF(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildCityTF(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildPostalCodeTF(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildCountryTF(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildPasswordTF(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildRepeatPasswordTF(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildRoleSelection(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildRegisterBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
