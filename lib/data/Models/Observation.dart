import 'package:http/http.dart';
import 'package:medical_devices/data/Models/Patient.dart';

class Observation {
  late final String id;
  late final String resourceType;
  late final String status;
  late final List<Category> category;
  late final Code code;
  late final Subject subject;
  late final String effectiveDateTime;
  late final ValueQuantity valueQuantity;
  late final List<Component> component;
  late final List<ReferenceRange> referenceRange;

  Observation();

  factory Observation.fromJSON(dynamic json, bool jsonContainsComponents, bool jsonContainsReferences) {
    Observation observation = Observation();
    if (jsonContainsComponents) {
      final componentData = json['component'] as List<dynamic>?;
      final componentList = componentData != null ? componentData.map((component) => Component.fromJSON(component)).toList() : <Component>[];
      observation.component = componentList;
    }
    if (!jsonContainsComponents) {
      observation.valueQuantity = ValueQuantity.fromJSON(json['valueQuantity']);
    }
    if (jsonContainsReferences) {
      final referencesData = json['referenceRange'] as List<dynamic>?;
      final referencesList = referencesData != null ? referencesData.map((reference) => ReferenceRange.fromJSON(reference)).toList() : <ReferenceRange>[];
      observation.referenceRange = referencesList;
    }
    observation.id = json['id'];
    observation.resourceType = json['resourceType'];
    observation.status = json['status'];
    final categoryData = json['category'] as List<dynamic>?;
    final categoryList = categoryData != null ? categoryData.map((category) => Category.fromJSON(category)).toList() : <Category>[];
    observation.category = categoryList;
    observation.code = Code.fromJSON(json['code']);
    observation.subject = Subject.fromJSON(json['subject']);
    observation.effectiveDateTime = json['effectiveDateTime'];

    return observation;
  }
}

class Category {
  late final List<Coding> coding;
  Category();
  factory Category.fromJSON(dynamic json) {
    Category category = Category();
    final codingsData = json['coding'] as List<dynamic>?;
    final listCodings = codingsData != null ? codingsData.map((coding) => Coding.fromJSON(coding)).toList() : <Coding>[];
    category.coding = listCodings;
    return category;
  }
}

class Code {
  late final List<Coding> coding;
  Code();
  factory Code.fromJSON(dynamic json) {
    Code code = Code();
    final codingsData = json['coding'] as List<dynamic>?;
    final listCodings = codingsData != null ? codingsData.map((coding) => Coding.fromJSON(coding)).toList() : <Coding>[];
    code.coding = listCodings;
    return code;
  }
}

class Subject {
  late final String reference;
  Subject();
  factory Subject.fromJSON(dynamic json) {
    Subject subject = Subject();
    subject.reference = json['reference'];
    return subject;
  }
}

class ValueQuantity {
  late final num value;
  late final String unit;
  late final String system;
  late final String code;

  ValueQuantity();
  factory ValueQuantity.fromJSON(dynamic json) {
    ValueQuantity valueQuantity = ValueQuantity();
    valueQuantity.value = json['value'];
    valueQuantity.unit = json['unit'];
    valueQuantity.system = json['system'];
    valueQuantity.code = json['code'];
    return valueQuantity;
  }
}

class Component {
  late final Code code;
  late final ValueQuantity valueQuantity;

  Component();
  factory Component.fromJSON(dynamic json) {
    Component component = Component();
    component.code = Code.fromJSON(json['code']);
    component.valueQuantity = ValueQuantity.fromJSON(json['valueQuantity']);
    return component;
  }
}

class BodySite {
  late final List<Coding> coding;
  BodySite();

  factory BodySite.fromJSON(dynamic json) {
    BodySite bodySite = BodySite();
    final codingsData = json['coding'] as List<dynamic>?;
    final listCodings = codingsData != null ? codingsData.map((coding) => Coding.fromJSON(coding)).toList() : <Coding>[];
    bodySite.coding = listCodings;
    return bodySite;
  }
}

class ReferenceRange {
  late final HighOrLow high;
  late final HighOrLow low;
  ReferenceRange();

  factory ReferenceRange.fromJSON(dynamic json) {
    ReferenceRange referenceRange = ReferenceRange();
    referenceRange.high = HighOrLow.fromJSON(json['high']);
    referenceRange.low = HighOrLow.fromJSON(json['low']);
    return referenceRange;
  }
}

class HighOrLow {
  late final num value;
  late final String unit;
  HighOrLow(this.value, this.unit);

  factory HighOrLow.fromJSON(dynamic json) {
    HighOrLow highOrLow = HighOrLow(json['value'], json['unit']);
    return highOrLow;
  }
}
