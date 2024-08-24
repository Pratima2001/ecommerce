import 'dart:convert';

class UserModule {
  final String name;
  final String uid;
  final String email;
  final String fname;
  final String lname;
  final String street;
  final String city;
  final String phoneNumber;
  final String zipCode;
  final String address;
  UserModule({
    required this.name,
    required this.uid,
    required this.email,
    required this.fname,
    required this.lname,
    required this.street,
    required this.city,
    required this.phoneNumber,
    required this.zipCode,
    required this.address,
  });

  UserModule copyWith({
    String? name,
    String? uid,
    String? email,
    String? fname,
    String? lname,
    String? street,
    String? city,
    String? phoneNumber,
    String? zipCode,
    String? Address,
  }) {
    return UserModule(
      name: name ?? this.name,
      uid: uid ?? this.uid,
      email: email ?? this.email,
      fname: fname ?? this.fname,
      lname: lname ?? this.lname,
      street: street ?? this.street,
      city: city ?? this.city,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      zipCode: zipCode ?? this.zipCode,
      address: address ?? address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'email': email,
      'fname': fname,
      'lname': lname,
      'street': street,
      'city': city,
      'phoneNumber': phoneNumber,
      'zipCode': zipCode,
      'Address': address,
    };
  }

  factory UserModule.fromMap(Map<String, dynamic> map) {
    return UserModule(
      name: map['name'] ?? '',
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      fname: map['fname'] ?? '',
      lname: map['lname'] ?? '',
      street: map['street'] ?? '',
      city: map['city'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      zipCode: map['zipCode'] ?? '',
      address: map['Address'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModule.fromJson(String source) =>
      UserModule.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModule(name: $name, uid: $uid, email: $email, fname: $fname, lname: $lname, street: $street, city: $city, phoneNumber: $phoneNumber, zipCode: $zipCode, Address: $address)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModule &&
        other.name == name &&
        other.uid == uid &&
        other.email == email &&
        other.fname == fname &&
        other.lname == lname &&
        other.street == street &&
        other.city == city &&
        other.phoneNumber == phoneNumber &&
        other.zipCode == zipCode &&
        other.address == address;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        uid.hashCode ^
        email.hashCode ^
        fname.hashCode ^
        lname.hashCode ^
        street.hashCode ^
        city.hashCode ^
        phoneNumber.hashCode ^
        zipCode.hashCode ^
        address.hashCode;
  }
}
