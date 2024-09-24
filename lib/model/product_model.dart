
class ProductListResponseDto {
  List<Products>? products;

  ProductListResponseDto({this.products});

  ProductListResponseDto.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add( Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? id;
  String? title;
  String? description;
  double? mrp;
  String? productImages;
  bool? isAdded;

  Products(
      {this.id,
        this.title,
        this.description,
        this.mrp,
        this.productImages,
        this.isAdded
      });

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    mrp = json['mrp'];
    productImages = json['productImages'];
    isAdded = json['isAdded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] =description;
    data['mrp'] = mrp;
    data['productImages'] =productImages;
    data['isAdded'] =isAdded;
    return data;
  }
}