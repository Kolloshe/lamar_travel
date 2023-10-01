import 'package:intl/intl.dart';

class TravelInsurancePaxDetailsData {
  final String title;
  final String firstName;
  final String middleName;
  final String lastname;
  final String nationality;
  final String nationalityText;
  final DateTime dateOfBirth;

  const TravelInsurancePaxDetailsData(
      {required this.firstName,
        required this.lastname,
        required this.middleName,
        required this.nationality,
        required this.dateOfBirth,
        required this.title,
        required this.nationalityText});

  Map<String, dynamic> toJson() => {
    "title": title,
    "first_name": firstName,
    "middle_name": middleName,
    "last_name": lastname,
    "birth_date": DateFormat('yyyy-MM-dd').format(dateOfBirth),
    "nationality": nationalityText
  };
}
