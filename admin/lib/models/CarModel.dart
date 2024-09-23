class CarModel {
  CarModel(
      {required this.car_id,
      required this.car_name,
      required this.brand,
      required this.models});

  String car_id;
  String car_name;
  String brand;
  List<dynamic> models;

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      car_id: json['_id'],
      car_name: json['car_name'],
      brand: json['brand'],
      models:
          json['models'].map((modelJson) => Model.fromJson(modelJson)).toList(),
    );
  }
}

class Model {
  Model({required this.model_id, required this.model_name});
  String model_id;
  String model_name;

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      model_id: json['_id'],
      model_name: json['name'],
    );
  }
}
