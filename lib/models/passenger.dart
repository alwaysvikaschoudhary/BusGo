class Passenger {
  final String name;
  final String phoneNumber;
  final String email;
  final int? age;
  final String? gender;

  Passenger({
    required this.name,
    required this.phoneNumber,
    required this.email,
    this.age,
    this.gender,
  });
}
