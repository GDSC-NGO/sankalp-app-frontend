class NGO {
  int? id;
  final int userId;
  final String ngoName;
  final String? description;
  final int? establishedYear;
  final String? registrationNumber;
  final String? domain;
  final String? website;
  final String? location;

  // These fields will be populated from the users table join
  String? contactName;
  String? email;
  String? phone;
  String? address;

  NGO({
    this.id,
    required this.userId,
    required this.ngoName,
    this.description,
    this.establishedYear,
    this.registrationNumber,
    this.domain,
    this.website,
    this.location,
    this.contactName,
    this.email,
    this.phone,
    this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'ngoName': ngoName,
      'description': description,
      'establishedYear': establishedYear,
      'registrationNumber': registrationNumber,
      'domain': domain,
      'website': website,
      'location': location,
    };
  }

  factory NGO.fromMap(Map<String, dynamic> map) {
    return NGO(
      id: map['id'],
      userId: map['userId'],
      ngoName: map['ngoName'],
      description: map['description'],
      establishedYear: map['establishedYear'],
      registrationNumber: map['registrationNumber'],
      domain: map['domain'],
      website: map['website'],
      location: map['location'],
    );
  }

  factory NGO.fromJoinedMap(Map<String, dynamic> map) {
    return NGO(
      id: map['id'],
      userId: map['userId'],
      ngoName: map['ngoName'],
      description: map['description'],
      establishedYear: map['establishedYear'],
      registrationNumber: map['registrationNumber'],
      domain: map['domain'],
      website: map['website'],
      location: map['location'],
      contactName: map['name'],
      email: map['email'],
      phone: map['phone'],
      address: map['address'],
    );
  }
}
