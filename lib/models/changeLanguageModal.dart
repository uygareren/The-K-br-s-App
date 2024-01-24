class ChangeLanguageModal {
  final String id;
  final String country_icon;
  final String country_name;

  ChangeLanguageModal(this.id, this.country_icon, this.country_name);

  static List<ChangeLanguageModal> getLanguageName() {
    List<ChangeLanguageModal> languageNames = [];

    languageNames.add(ChangeLanguageModal(
        "1", "assets/icons/turkey-flag-icon.svg", "Türkçe"));
    languageNames.add(ChangeLanguageModal(
        "2", "assets/icons/Flag_of_the_United_States.svg", "English"));

    return languageNames;
  }
}
