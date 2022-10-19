import 'package:flutter/material.dart';

class Device {
  late final String nameDevice;
  late final Image photoDevice;
  late final String modelDevice;
  late final bool connected;

  Device(this.nameDevice, this.photoDevice, this.modelDevice, this.connected);
}
