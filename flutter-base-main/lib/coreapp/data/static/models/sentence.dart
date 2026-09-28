import 'package:myeshop/coreapp/data/static/models/custom_text.dart';

abstract class Sentence implements CustomText {
  const Sentence(this.text);
  final String text;
}
