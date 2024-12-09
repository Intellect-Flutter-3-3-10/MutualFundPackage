class SchemaSearchFilterModel {
  List<SchemeAMCs>? schemeAMCs;
  List<SchemeAssetClasses>? schemeAssetClasses;
  List<SchemeRisks>? schemeRisks;
  List<SortingColumns>? sortingColumns;
  List<SchemeStarRating>? schemeStarRating;

  SchemaSearchFilterModel({this.schemeAMCs, this.schemeAssetClasses, this.schemeRisks, this.sortingColumns, this.schemeStarRating});

  SchemaSearchFilterModel.fromJson(Map<String, dynamic> json) {
    if (json['SchemeAMCs'] != null) {
      schemeAMCs = <SchemeAMCs>[];
      json['SchemeAMCs'].forEach((v) {
        schemeAMCs!.add(new SchemeAMCs.fromJson(v));
      });
    }
    if (json['SchemeAssetClasses'] != null) {
      schemeAssetClasses = <SchemeAssetClasses>[];
      json['SchemeAssetClasses'].forEach((v) {
        schemeAssetClasses!.add(new SchemeAssetClasses.fromJson(v));
      });
    }
    if (json['SchemeRisks'] != null) {
      schemeRisks = <SchemeRisks>[];
      json['SchemeRisks'].forEach((v) {
        schemeRisks!.add(new SchemeRisks.fromJson(v));
      });
    }
    if (json['SortingColumns'] != null) {
      sortingColumns = <SortingColumns>[];
      json['SortingColumns'].forEach((v) {
        sortingColumns!.add(new SortingColumns.fromJson(v));
      });
    }
    if (json['SchemeStarRating'] != null) {
      schemeStarRating = <SchemeStarRating>[];
      json['SchemeStarRating'].forEach((v) {
        schemeStarRating!.add(new SchemeStarRating.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.schemeAMCs != null) {
      data['SchemeAMCs'] = this.schemeAMCs!.map((v) => v.toJson()).toList();
    }
    if (this.schemeAssetClasses != null) {
      data['SchemeAssetClasses'] = this.schemeAssetClasses!.map((v) => v.toJson()).toList();
    }
    if (this.schemeRisks != null) {
      data['SchemeRisks'] = this.schemeRisks!.map((v) => v.toJson()).toList();
    }
    if (this.sortingColumns != null) {
      data['SortingColumns'] = this.sortingColumns!.map((v) => v.toJson()).toList();
    }
    if (this.schemeStarRating != null) {
      data['SchemeStarRating'] = this.schemeStarRating!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SchemeAMCs {
  int? aMCId;
  String? aMCName;

  SchemeAMCs({this.aMCId, this.aMCName});

  SchemeAMCs.fromJson(Map<String, dynamic> json) {
    aMCId = json['AMCId'];
    aMCName = json['AMCName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AMCId'] = this.aMCId;
    data['AMCName'] = this.aMCName;
    return data;
  }
}

class SchemeAssetClasses {
  int? assetClassId;
  String? assetClass;
  List<SchemeCategories>? schemeCategories;

  SchemeAssetClasses({this.assetClassId, this.assetClass, this.schemeCategories});

  SchemeAssetClasses.fromJson(Map<String, dynamic> json) {
    assetClassId = json['AssetClassId'];
    assetClass = json['AssetClass'];
    if (json['SchemeCategories'] != null) {
      schemeCategories = <SchemeCategories>[];
      json['SchemeCategories'].forEach((v) {
        schemeCategories!.add(new SchemeCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AssetClassId'] = this.assetClassId;
    data['AssetClass'] = this.assetClass;
    if (this.schemeCategories != null) {
      data['SchemeCategories'] = this.schemeCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SchemeCategories {
  int? categoryId;
  String? categoryName;

  SchemeCategories({this.categoryId, this.categoryName});

  SchemeCategories.fromJson(Map<String, dynamic> json) {
    categoryId = json['CategoryId'];
    categoryName = json['CategoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CategoryId'] = this.categoryId;
    data['CategoryName'] = this.categoryName;
    return data;
  }
}

class SchemeRisks {
  int? riskId;
  String? riskName;

  SchemeRisks({this.riskId, this.riskName});

  SchemeRisks.fromJson(Map<String, dynamic> json) {
    riskId = json['RiskId'];
    riskName = json['RiskName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RiskId'] = this.riskId;
    data['RiskName'] = this.riskName;
    return data;
  }
}

class SortingColumns {
  String? sortColumnValue;
  String? sortColumnText;

  SortingColumns({this.sortColumnValue, this.sortColumnText});

  SortingColumns.fromJson(Map<String, dynamic> json) {
    sortColumnValue = json['SortColumnValue'];
    sortColumnText = json['SortColumnText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SortColumnValue'] = this.sortColumnValue;
    data['SortColumnText'] = this.sortColumnText;
    return data;
  }
}

class SchemeStarRating {
  int? starRating;

  SchemeStarRating({this.starRating});

  SchemeStarRating.fromJson(Map<String, dynamic> json) {
    starRating = json['StarRating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StarRating'] = this.starRating;
    return data;
  }
}
