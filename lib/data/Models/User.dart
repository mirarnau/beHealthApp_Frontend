import 'package:medical_devices/data/Models/Device.dart';
import 'package:medical_devices/data/Models/Group.dart';

class User {
  late final String apiId;
  late final String password;
  late final String id;
  late final String resourceType;
  late final List<Identifier> identifier;
  late final bool active;
  late final List<Name> name;
  late final List<Telecom> telecom;
  late final String gender;
  late final String birthDate;
  late final List<Address> address;
  late final List<Communication> communication;
  late final List<Group> groups;
  late final List<String> role;
  late final String imageUrl;
  late final String fullName;
  late final String email;
  late final List<Device> listDevices;
  late final List<FootstepsData> footsteps;
  late final num todayFootsteps;

  User();

  factory User.fromJSON(dynamic json) {
    User patient = User();

    patient.apiId = json['_id'];
    if (json.containsKey('fhir_id')) {
      patient.id = json['fhir_id'];
    } else {
      patient.id = json['id'];
    }
    patient.resourceType = json['resourceType'];
    final identifierData = json['identifier'] as List<dynamic>?;
    final listIdentifier = identifierData != null ? identifierData.map((identifier) => Identifier.fromJSON(identifier)).toList() : <Identifier>[];
    patient.identifier = listIdentifier;
    patient.active = json['active'] as bool;
    final nameData = json['name'] as List<dynamic>?;
    final listName = nameData != null ? nameData.map((name) => Name.fromJSON(name)).toList() : <Name>[];
    patient.name = listName;
    final telecomData = json['telecom'] as List<dynamic>?;
    final listTelecom = telecomData != null ? telecomData.map((telecom) => Telecom.fromJSON(telecom)).toList() : <Telecom>[];
    patient.telecom = listTelecom;
    patient.gender = json['gender'];
    patient.birthDate = json['birthDate'];
    final addressData = json['address'] as List<dynamic>?;
    final listAddress = addressData != null ? addressData.map((address) => Address.fromJSON(address)).toList() : <Address>[];
    patient.address = listAddress;
    final communicationData = json['communication'] as List<dynamic>?;
    final listCommunication = communicationData != null ? communicationData.map((communication) => Communication.fromJSON(communication)).toList() : <Communication>[];
    patient.communication = listCommunication;
    if (json.containsKey('role')) {
      patient.role = json['role'].cast<String>();
    }
    if (json.containsKey('image_url')) {
      patient.imageUrl = json['image_url'];
    }
    if (json.containsKey('full_name')) {
      patient.fullName = json['full_name'];
    }
    if (json.containsKey('email')) {
      patient.email = json['email'];
    }
    if (json.containsKey('devices')) {
      final devicesData = json['devices'] as List<dynamic>?;
      final listDevices = devicesData != null ? devicesData.map((device) => Device.fromJSON(device)).toList() : <Device>[];
      patient.listDevices = listDevices;
    }
    final footstepsData = json['footsteps'] as List<dynamic>?;
    final listFootSteps = footstepsData != null ? footstepsData.map((footstep) => FootstepsData.fromJSON(footstep)).toList() : <FootstepsData>[];
    patient.footsteps = listFootSteps;
    patient.todayFootsteps = json['today_footsteps'];
    return patient;
  }

  static Map<String, dynamic> toJsonApi(User patient) {
    String? getTelecomAtributePatient(String atribute) {
      for (int i = 0; i < patient.telecom.length; i++) {
        if (patient.telecom[i].system == atribute) {
          return patient.telecom[i].value.toString();
        }
      }
      return null;
    }

    return {
      'full_name': patient.name[0].text,
      'surnames': patient.name[0].family,
      'gender': patient.gender,
      'birth_date': patient.birthDate,
      'language': patient.communication[0].language.coding[0].code,
      'email': getTelecomAtributePatient('email'),
      'phone_number': getTelecomAtributePatient('phone'),
      'use_address': patient.address[0].use,
      'line': patient.address[0].line[0],
      'city': patient.address[0].city,
      'postal_code': patient.address[0].postalCode,
      'country': patient.address[0].country,
      'password': patient.password,
    };
  }
}

class Identifier {
  late final String use;
  late final String system;
  late final String value;

  Identifier({required this.use, required this.system, required this.value});

  factory Identifier.fromJSON(dynamic json) {
    Identifier identifier = Identifier(use: json['use'], system: json['system'], value: json['value']);
    return identifier;
  }
}

class Name {
  late final String use;
  late final String family;
  late final String text;

  Name({required this.use, required this.family, required this.text});

  factory Name.fromJSON(dynamic json) {
    Name name = Name(use: json['name'], family: json['family'], text: json['text']);
    return name;
  }
}

class Telecom {
  late final String system;
  late final String value;

  Telecom({required this.system, required this.value});

  factory Telecom.fromJSON(dynamic json) {
    Telecom telecom = Telecom(system: json['system'], value: json['value']);
    return telecom;
  }
}

class Address {
  late final String use;
  late final List<String> line;
  late final String city;
  late final String postalCode;
  late final String country;

  Address({required this.use, required this.city, required this.postalCode, required this.country});

  factory Address.fromJSON(dynamic json) {
    Address address = Address(use: json['use'], city: json['city'], postalCode: json['postalCode'], country: json['country']);
    final lineData = json['line'].cast<String>();
    address.line = lineData;
    return address;
  }
}

class Communication {
  late final Language language;
  Communication();

  Communication.fromJSON(dynamic json) {
    Communication communication = Communication();
    communication.language = Language.fromJSON(json['language']);
  }
}

class Language {
  late final List<Coding> coding;
  Language();

  Language.fromJSON(dynamic json) {
    Language language = Language();
    final codingsData = json['coding'] as List<dynamic>?;
    final listCodings = codingsData != null ? codingsData.map((coding) => Coding.fromJSON(coding)).toList() : <Coding>[];
    language.coding = listCodings;
  }
}

class Coding {
  late final String system;
  late final String code;
  late final String display;

  Coding({required this.system, required this.code, required this.display});

  factory Coding.fromJSON(dynamic json) {
    Coding coding = Coding(system: json['system'], code: json['code'], display: json['display']);
    return coding;
  }
}

class FootstepsData {
  late final DateTime dateTime;
  late final num value;
  FootstepsData();
  factory FootstepsData.fromJSON(dynamic json) {
    FootstepsData footstepsData = FootstepsData();
    footstepsData.dateTime = DateTime.parse(json['date']);
    footstepsData.value = json['value'];
    return footstepsData;
  }
}


/*
PROFILE PICS
Arnau -> https://i.pinimg.com/736x/81/67/b1/8167b1b499e349324ec5d5fc276726c4--persian-kittens-animal-fun.jpg
Bianca -> https://media.donedeal.ie/eyJidWNrZXQiOiJkb25lZGVhbC5pZS1waG90b3MiLCJlZGl0cyI6eyJ0b0Zvcm1hdCI6ImpwZWciLCJyZXNpemUiOnsiZml0IjoiaW5zaWRlIiwid2lkdGgiOjYwMCwiaGVpZ2h0Ijo2MDB9fSwia2V5IjoicGhvdG9fMjM5ODU5ODYwIn0=?signature=68b806698af8a57c685d7b2232c9b67a581eb855acaa1319ca90565196af768a
Henry -> https://www.hogarmania.com/archivos/202207/gato-negro-1280x720x80xX-1.jpg
*/