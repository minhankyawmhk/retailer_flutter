class GetStockDetails {
  final String u31Syskey;
  final String uomSyskey;
  final String barcode;
  final String price;
  final String uomType;
  final String priceType;
  final String ratio;

  GetStockDetails(
      {this.u31Syskey,
      this.uomSyskey,
      this.barcode,
      this.price,
      this.uomType,
      this.priceType,
      this.ratio});
  factory GetStockDetails.fromJson(Map<String, dynamic> json) {
    return GetStockDetails(
      u31Syskey: json['u31Syskey'],
      uomSyskey: json['uomSyskey'],
      barcode: json['barcode'],
      price: json['price'],
      uomType: json['uomType'],
      priceType: json['priceType'],
      ratio: json['ratio'],
    );
  }
}
