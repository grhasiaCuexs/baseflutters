import 'package:myeshop/coreapp/data/static/models/custom_text.dart';

abstract class SentencesList implements CustomText {
  const SentencesList(this.sentences);
  final List<String> sentences;
}
