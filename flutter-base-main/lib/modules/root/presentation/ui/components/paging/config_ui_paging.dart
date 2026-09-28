import 'package:flutter/material.dart';

abstract class ConfigUiPaging {
  abstract final AssetImage? baseLogoImage;
}

class BaseConfigUiPaging extends ConfigUiPaging {
  @override
  AssetImage? get baseLogoImage => null;
}
