class Country {
  final String countryID;
  final String countryName;
  final String phonePrefix;
  final String flag;

  Country({
    required this.countryID,
    required this.countryName,
    required this.phonePrefix,
  }) : flag = countryID.toUpperCase().replaceAllMapped(
          RegExp(r'[A-Z]'),
          (flag) {
            return String.fromCharCode(flag.group(0)!.codeUnitAt(0) + 127397);
          },
        ).toString();
}
