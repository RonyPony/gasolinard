class Fuels {
  bool? valid;
  Meta? meta;
  List<Data>? data;

  Fuels({this.valid, this.meta, this.data});

  Fuels.fromJson(Map<String, dynamic> json) {
    valid = json['valid'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['valid'] = this.valid;
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meta {
  String? source;
  String? updatedAt;
  int? week;
  int? year;

  Meta({this.source, this.updatedAt, this.week, this.year});

  Meta.fromJson(Map<String, dynamic> json) {
    source = json['source'];
    updatedAt = json['updatedAt'];
    week = json['week'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['source'] = this.source;
    data['updatedAt'] = this.updatedAt;
    data['week'] = this.week;
    data['year'] = this.year;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? code;
  String? currency;
  String? price;
  String? date;

  Data({this.id, this.name, this.code, this.currency, this.price, this.date});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    currency = json['currency'];
    price = json['price'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['currency'] = this.currency;
    data['price'] = this.price;
    data['date'] = this.date;
    return data;
  }
}
