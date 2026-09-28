class LocalizationSettingEntity {
  final String languageCode;
  final String? countryCode;
  LocalizationSettingEntity(this.languageCode, [this.countryCode]);

  @override
  bool operator ==(covariant LocalizationSettingEntity other) {
    if (identical(this, other)) return true;

    return other.languageCode == languageCode &&
        other.countryCode == countryCode;
  }

  @override
  int get hashCode => Object.hash(languageCode, countryCode);

  @override
  String toString() {
    return '$languageCode,$countryCode';
  }
}
