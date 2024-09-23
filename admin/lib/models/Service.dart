class ServiceModel {
  ServiceModel({required this.service_id, required this.service_name});

  String service_id;
  String service_name;

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
        service_id: json['_id'], service_name: json['service_name']);
  }
}
