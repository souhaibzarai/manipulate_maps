import '../../data/models/country.dart';

final List<Country> allCountries = [
  Country(
    countryID: 'ma',
    countryName: 'Morocco',
    phonePrefix: '212',
  ),
  Country(
    countryID: 'us',
    countryName: 'USA',
    phonePrefix: '1',
  ),
  Country(
    countryID: 'ca',
    countryName: 'Canada',
    phonePrefix: '1',
  ),
  Country(
    countryID: 'eg',
    countryName: 'Egypt',
    phonePrefix: '2',
  ),
];

List<Country> copyCountries = List.from(allCountries);

List<Country> get shuffledCountries {
  copyCountries.shuffle();
  return copyCountries;
}
