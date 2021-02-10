class AllShopSaleList {
  final List shopsByUser;
  final List shopsByTeam;
  final String status;
  final String cause;
  final int totalcount;

  AllShopSaleList(
      {this.shopsByUser,
      this.shopsByTeam,
      this.status,
      this.cause,
      this.totalcount});

  factory AllShopSaleList.fromJson(Map<String, dynamic> json) {
    return AllShopSaleList(
      shopsByUser: json['data']['shopsByUser'],
      shopsByTeam: json['data']['shopsByTeam'],
      status: json['status'],
      cause: json['cause'],
      totalcount: json['totalcount'],
    );
  }
}
