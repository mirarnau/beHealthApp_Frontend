class Patient {
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

  Patient();

  factory Patient.fromJSON(dynamic json) {
    Patient patient = Patient();

    patient.id = json['id'];
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

    return patient;
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

  Name({required this.use, required this.family});

  factory Name.fromJSON(dynamic json) {
    Name name = Name(use: json['name'], family: json['family']);
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

  Coding({required this.system, required this.code});

  factory Coding.fromJSON(dynamic json) {
    Coding coding = Coding(system: json['system'], code: json['code']);
    return coding;
  }
}
