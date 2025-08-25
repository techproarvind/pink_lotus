class WeeklySummeryModel {
  List<CategoryData>? categoryData;
  dynamic endDate;
  dynamic startDate;
  dynamic storeCode;
  dynamic weekNumber;

  WeeklySummeryModel({
    this.categoryData,
    this.endDate,
    this.startDate,
    this.storeCode,
    this.weekNumber,
  });

  WeeklySummeryModel.fromJson(Map<String, dynamic> json) {
    if (json['category_data'] != null) {
      categoryData = <CategoryData>[];
      json['category_data'].forEach((v) {
        categoryData!.add(new CategoryData.fromJson(v));
      });
    }
    endDate = json['end_date'];
    startDate = json['start_date'];
    storeCode = json['store_code'];
    weekNumber = json['week_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categoryData != null) {
      data['category_data'] =
          this.categoryData!.map((v) => v.toJson()).toList();
    }
    data['end_date'] = this.endDate;
    data['start_date'] = this.startDate;
    data['store_code'] = this.storeCode;
    data['week_number'] = this.weekNumber;
    return data;
  }
}

class CategoryData {
  dynamic cATEGORY;
  dynamic cID;
  dynamic cURRWEEK;
  dynamic l1COMMENTS;
  dynamic pREVWEEK;
  dynamic sTORE;
  dynamic wEEKNUM;

  CategoryData({
    this.cATEGORY,
    this.cID,
    this.cURRWEEK,
    this.l1COMMENTS,
    this.pREVWEEK,
    this.sTORE,
    this.wEEKNUM,
  });

  CategoryData.fromJson(Map<String, dynamic> json) {
    cATEGORY = json['CATEGORY'];
    cID = json['CID'];
    cURRWEEK = json['CURRWEEK'];
    l1COMMENTS = json['L1_COMMENTS'];
    pREVWEEK = json['PREVWEEK'];
    sTORE = json['STORE'];
    wEEKNUM = json['WEEKNUM'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CATEGORY'] = this.cATEGORY;
    data['CID'] = this.cID;
    data['CURRWEEK'] = this.cURRWEEK;
    data['L1_COMMENTS'] = this.l1COMMENTS;
    data['PREVWEEK'] = this.pREVWEEK;
    data['STORE'] = this.sTORE;
    data['WEEKNUM'] = this.wEEKNUM;
    return data;
  }
}
