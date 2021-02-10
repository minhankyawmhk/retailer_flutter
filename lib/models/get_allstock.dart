class GetAllStock {
  final String syskey;
  final String code;
  final String desc;
  final String img;
  final String packTypeCode;
  final String packSizeCode;
  final String floverCode;
  final String brandCode;
  final String brandOwnerCode;
  final String brandOwnerName;
  final String brandOwnerSyskey;
  final String vendorCode;
  final String categoryCode;
  final String subCategoryCode;
  final String categoryCodeDesc;
  final String subCategoryCodeDesc;
  final String whCode;
  final String whSyskey;
  final List details;
  GetAllStock(
      {this.syskey,
      this.code,
      this.desc,
      this.img,
      this.packTypeCode,
      this.packSizeCode,
      this.floverCode,
      this.brandCode,
      this.brandOwnerCode,
      this.brandOwnerName,
      this.brandOwnerSyskey,
      this.vendorCode,
      this.categoryCode,
      this.subCategoryCode,
      this.categoryCodeDesc,
      this.subCategoryCodeDesc,
      this.whCode,
      this.whSyskey,
      this.details});

  factory GetAllStock.fromJson(Map<String, dynamic> json) {
    return GetAllStock(
      syskey: json['syskey'],
      code: json['code'],
      desc: json['desc'],
      img: json['img'],
      packTypeCode: json['packTypeCode'],
      packSizeCode: json['packSizeCode'],
      floverCode: json['floverCode'],
      brandCode: json['brandCode'],
      brandOwnerCode: json['brandOwnerCode'],
      brandOwnerName: json['brandOwnerName'],
      brandOwnerSyskey: json['brandOwnerSyskey'],
      vendorCode: json['vendorCode'],
      categoryCode: json['categoryCode'],
      subCategoryCode: json['subCategoryCode'],
      categoryCodeDesc: json['categoryCodeDesc'],
      subCategoryCodeDesc: json['subCategoryCodeDesc'],
      whCode: json['whCode'],
      whSyskey: json['whSyskey'],
    );
  }
}
