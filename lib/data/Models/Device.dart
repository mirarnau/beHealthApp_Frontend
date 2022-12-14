import 'package:flutter/material.dart';

class Device {
  late final String nameDevice;
  late final String photoDevice;
  late final String modelDevice;
  late final bool connected;
  late final bool added;
  late final bool verified;

  Device(this.nameDevice, this.photoDevice, this.modelDevice, this.connected, this.added, this.verified);
  factory Device.fromJSON(dynamic json) {
    Device device = Device(json['name'], json['assets_image_url'], json['model'], true, true, json['verified']);
    return device;
  }
}
