class Fuels {
  List<Combustibles>? combustibles;
  bool? success;
  String? message;

  Fuels({this.combustibles, this.success, this.message});

  Fuels.fromJson(Map<String, dynamic> json) {
    if (json['combustibles'] != null) {
      combustibles = <Combustibles>[];
      json['combustibles'].forEach((v) {
        combustibles!.add(new Combustibles.fromJson(v));
      });
    }
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.combustibles != null) {
      data['combustibles'] = this.combustibles!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}

class Combustibles {
  String? nombre;
  String? precio;
  String? updateDate;

  Combustibles({this.nombre, this.precio, this.updateDate});

  Combustibles.fromJson(Map<String, dynamic> json) {
    nombre = json['nombre'];
    precio = json['precio'];
    updateDate = json['updateDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nombre'] = this.nombre;
    data['precio'] = this.precio;
    data['updateDate'] = this.updateDate;
    return data;
  }
}
