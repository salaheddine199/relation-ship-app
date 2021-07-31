class PersonModel {
  final int? id;
  final String? name;
  final String? number;
  final String? birthDate;
  final String? informationAbout;
  final String? relation;

  PersonModel({
    this.id,
    this.name,
    this.number,
    this.birthDate,
    this.informationAbout,
    this.relation,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) => PersonModel(
        id: json["id"],
        name: json["name"],
        number: json["number"],
        birthDate: json["birthDate"],
        informationAbout: json["informationAbout"],
        relation: json["relation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "number": number,
        "birthDate": birthDate,
        "informationAbout": informationAbout,
        "relation": relation,
      };
}
