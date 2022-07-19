import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

enum ObjectType {
  @JsonValue('entry')
  entry,
  @JsonValue('info')
  info,
  @JsonValue('checkout')
  checkout,
  @JsonValue('restroom')
  restroom,
  @JsonValue('section')
  section,
  @JsonValue('store')
  store;

  IconData getIcon() {
    switch (this) {
      case ObjectType.entry:
        return FontAwesomeIcons.doorOpen;
      case ObjectType.info:
        return FontAwesomeIcons.circleInfo;
      case ObjectType.checkout:
        return FontAwesomeIcons.cashRegister;
      case ObjectType.restroom:
        return FontAwesomeIcons.restroom;
      case ObjectType.section:
        return FontAwesomeIcons.square;
      case ObjectType.store:
        return FontAwesomeIcons.warehouse;
    }
  }

  String getTooltipMsg() {
    switch (this) {
      case ObjectType.entry:
        return 'Entry';
      case ObjectType.info:
        return 'Info Center';
      case ObjectType.checkout:
        return 'Checkout';
      case ObjectType.restroom:
        return 'Restroom';
      case ObjectType.section:
        return 'Section';
      case ObjectType.store:
        return 'Store Dimensions';
    }
  }

  bool get isSectionObject =>
      this == ObjectType.section || this == ObjectType.store;
}
