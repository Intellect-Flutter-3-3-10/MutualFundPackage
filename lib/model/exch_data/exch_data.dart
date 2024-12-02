
class ExchData {
  //ExchPos: 0- Nse Cash, 1- Nse Deriv, 2- Bse Cash, 3- Nse Currency, 4- Bse Curreny, 5- MCX
  List<ScripInfoModel> _scripData = [];
  List<ScripStaticModel> _scripStaticData = [];
  List<ScripStaticModel> tempList = [];
  List<int> reqDataForScrip = [];
  String exchTypeShort, exch;

  ExchangeStatus exchangeStatus = ExchangeStatus.nesNone;

  ExchData({
    required this.exch,
    required this.exchTypeShort,
  });

  int scripPos(int? exchCode) {
    for (int i = 0; i < _scripData.length; i++) {
      if (_scripData[i].exchCode == exchCode) return i;
    }
    return -1;
  }

  int scripPosForIsec(String isecName) {
    for (int i = 0; i < _scripData.length; i++) {
      if (_scripData[i].isecName == isecName) return i;
    }
    return null!;
  }

  void addModel(ScripInfoModel model) {
    if (scripPos(model.exchCode) < 0) _scripData.add(model);
  }

  void addMFModel(ScripInfoModel model) {
    _scripData.add(model);
  }

  List<ScripInfoModel> getAllScripsForMarketSummary() {
    return _scripData.where((element) => element.todayTrades >= 1 || element.close >= 1).toList();
  }

  List<ScripInfoModel> getAllScripsForNifty500MarketSummary() {
    var nifty500 = CommonFunction.getMembers(
      'P',
      'P0009',
    );
    List<ScripInfoModel> result = [];
    for (var model in _scripData) {
      if (model.todayTrades < 1 && model.close < 1) continue;
      if (!nifty500.any((element) => model.exchCode == element.exchCode)) continue;
      result.add(model);
    }
    return result;
  }

  List<ScripInfoModel> getAllScripsForBse500MarketSummary() {
    var bse500 = CommonFunction.getMembers(
      'Q',
      'BSE500',
    );
    List<ScripInfoModel> result = [];
    for (var model in _scripData) {
      if (model.todayTrades < 1 && model.close < 1) continue;
      if (!bse500.any((element) => model.exchCode == element.exchCode)) continue;
      result.add(model);
    }
    return result;
  }

  List<ScripInfoModel> getAllScripsForMarketSummaryForFuture() {
    return _scripData.where((element) => (element.todayTrades >= 1 || element.close >= 1) && element.exchCategory == ExchCategory.nseFuture).toList();
  }

  ScripStaticModel getStaticModelFromNameOI(String name) {
    name = name.toLowerCase();
    for (int i = 0; i < _scripStaticData.length; i++) {
      if (_scripStaticData[i].name!.toLowerCase() != name) continue;
      return _scripStaticData[i];
    }
    return null!;
  }

  List<ScripInfoModel> getFutureModels(ScripInfoModel model) {
    if (model.series.toLowerCase() != 'eq') return [];
    List<ScripInfoModel> models = [];
    for (var data in _scripStaticData) {
      if (data.ulToken != model.exchCode) continue;
      if (data.ofisType != 1 && data.ofisType != 3) continue;
      ScripInfoModel? temp = CommonFunction.getScripDataModel(exch: data.exch!, exchCode: data.exchCode!, sendReq: false);
      models.add(temp!);
    }
    models.sort((a, b) => a.expiry.compareTo(b.expiry));
    return models;
  }

  List<ScripInfoModel> getNextFarFutureModels(ScripInfoModel model) {
    if (model.exchCategory != ExchCategory.nseFuture) return [];
    List<ScripInfoModel> models = [];
    for (var data in _scripStaticData) {
      if (data.ulToken != model.ulToken) continue;
      if (data.ofisType != 1 && data.ofisType != 3) continue;
      if (data.expiry! <= model.expiry) continue;
      ScripInfoModel? temp = CommonFunction.getScripDataModel(exch: data.exch!, exchCode: data.exchCode!, sendReq: false);
      models.add(temp!);
    }
    models.sort((a, b) => a.expiry.compareTo(b.expiry));
    return models;
  }

  List<ScripInfoModel> getFutureModelsForCurr(int ulToken) {
    List<ScripInfoModel> models = [];
    for (var data in _scripStaticData) {
      if (data.ulToken != ulToken) continue;
      if (data.ofisType != 6) continue;
      ScripInfoModel? temp = CommonFunction.getScripDataModel(exch: data.exch!, exchCode: data.exchCode!, sendReq: false);
      models.add(temp!);
    }
    models.sort((a, b) => a.expiry.compareTo(b.expiry));
    return models;
  }

  List<ScripInfoModel> getFutureModelsForMcx(int ulToken) {
    List<ScripInfoModel> models = [];
    for (var data in _scripStaticData) {
      if (data.ulToken != ulToken) continue;
      if (data.ofisType != 9) continue;
      ScripInfoModel? temp = CommonFunction.getScripDataModel(exch: data.exch!, exchCode: data.exchCode!, sendReq: false);
      models.add(temp!);
    }
    models.sort((a, b) => a.expiry.compareTo(b.expiry));
    return models;
  }

  List<int> getDatesForOptions(ScripInfoModel model) {
    if (model.series.toLowerCase() != 'eq') return [];
    List<int> dates = [];
    for (var data in _scripStaticData) {
      if (data.ulToken != model.exchCode) continue;
      if (data.ofisType != 2 && data.ofisType != 4) continue;
      if (!dates.contains(data.expiry)) dates.add(data.expiry!);
    }
    dates.sort((a, b) => a.compareTo(b));
    return dates;
  }

  List<int> getDatesForOptionsCurr(int ulToken) {
    List<int> dates = [];
    for (var data in _scripStaticData) {
      if (data.ulToken != ulToken) continue;
      if (data.ofisType != 7) continue;
      if (!dates.contains(data.expiry)) dates.add(data.expiry!);
    }
    dates.sort((a, b) => a.compareTo(b));
    return dates;
  }

  List<int> getDatesForOptionsMcx(int ulToken) {
    List<int> dates = [];
    for (var data in _scripStaticData) {
      if (data.ulToken != ulToken) continue;
      if (data.ofisType != 10) continue;
      if (!dates.contains(data.expiry)) dates.add(data.expiry!);
    }
    dates.sort((a, b) => a.compareTo(b));
    return dates;
  }

  Map<String, List<OptionChainScripData>> getOptionModels(ScripInfoModel model, int date) {
    if (model.series.toLowerCase() != 'eq') return null!;

    List<ScripStaticModel> options = [];
    for (var data in _scripStaticData) {
      if (data.ulToken != model.exchCode) continue;
      if (data.ofisType != 2 && data.ofisType != 4) continue;
      if (data.expiry != date) continue;
      options.add(data);
    }
    var lessThanCtm = options.where((element) => element.strikePrice! <= model.close).toList();
    lessThanCtm.sort((b, a) => a.strikePrice!.compareTo(b.strikePrice!));
    var lessThanCtmResultCE = lessThanCtm
        .where((element) => element.cpType == 3)
        .take(20)
        .map((e) => OptionChainScripData(CommonFunction.getScripDataModel(exch: e.exch!, exchCode: e.exchCode!)!))
        .toList();
    lessThanCtmResultCE.sort((a, b) => a.model.strikePrice.compareTo(b.model.strikePrice));
    var lessThanCtmResultPE = lessThanCtm
        .where((element) => element.cpType == 4)
        .take(20)
        .map((e) => OptionChainScripData(CommonFunction.getScripDataModel(exch: e.exch!, exchCode: e.exchCode!)!))
        .toList();
    lessThanCtmResultPE.sort((a, b) => a.model.strikePrice.compareTo(b.model.strikePrice));
    var moreThanCtm = options.where((element) => element.strikePrice! > model.close).toList();
    moreThanCtm.sort((a, b) => a.strikePrice!.compareTo(b.strikePrice!));
    var moreThanCtmResultCE = moreThanCtm
        .where((element) => element.cpType == 3)
        .take(20)
        .map((e) => OptionChainScripData(CommonFunction.getScripDataModel(exch: e.exch!, exchCode: e.exchCode!)!))
        .toList();
    var moreThanCtmResultPE = moreThanCtm
        .where((element) => element.cpType == 4)
        .take(20)
        .map((e) => OptionChainScripData(CommonFunction.getScripDataModel(exch: e.exch!, exchCode: e.exchCode!)!))
        .toList();

    return {'LessCE': lessThanCtmResultCE, 'MoreCE': moreThanCtmResultCE, 'LessPE': lessThanCtmResultPE, 'MorePE': moreThanCtmResultPE};
  }

  Map<String, List<OptionChainScripData>> getOptionModelsCurr(ScripInfoModel model, int date) {
    List<ScripStaticModel> options = [];
    for (var data in _scripStaticData) {
      if (data.ulToken != model.ulToken) continue;
      if (data.ofisType != 7) continue;
      if (data.expiry != date) continue;
      options.add(data);
    }
    var lessThanCtm = options.where((element) => element.strikePrice! <= model.close).toList();
    lessThanCtm.sort((b, a) => a.strikePrice!.compareTo(b.strikePrice!));
    var lessThanCtmResultCE = lessThanCtm
        .where((element) => element.cpType == 3)
        .take(5)
        .map((e) => OptionChainScripData(CommonFunction.getScripDataModel(exch: e.exch!, exchCode: e.exchCode!)!))
        .toList();
    lessThanCtmResultCE.sort((a, b) => a.model.strikePrice.compareTo(b.model.strikePrice));
    var lessThanCtmResultPE = lessThanCtm
        .where((element) => element.cpType == 4)
        .take(5)
        .map((e) => OptionChainScripData(CommonFunction.getScripDataModel(exch: e.exch!, exchCode: e.exchCode!)!))
        .toList();
    lessThanCtmResultPE.sort((a, b) => a.model.strikePrice.compareTo(b.model.strikePrice));
    var moreThanCtm = options.where((element) => element.strikePrice! > model.close).toList();
    moreThanCtm.sort((a, b) => a.strikePrice!.compareTo(b.strikePrice!));
    var moreThanCtmResultCE = moreThanCtm
        .where((element) => element.cpType == 3)
        .take(5)
        .map((e) => OptionChainScripData(CommonFunction.getScripDataModel(exch: e.exch!, exchCode: e.exchCode!)!))
        .toList();
    var moreThanCtmResultPE = moreThanCtm
        .where((element) => element.cpType == 4)
        .take(5)
        .map((e) => OptionChainScripData(CommonFunction.getScripDataModel(exch: e.exch!, exchCode: e.exchCode!)!))
        .toList();

    return {'LessCE': lessThanCtmResultCE, 'MoreCE': moreThanCtmResultCE, 'LessPE': lessThanCtmResultPE, 'MorePE': moreThanCtmResultPE};
  }

  Map<String, List<OptionChainScripData>> getOptionModelsMcx(ScripInfoModel model, int date) {
    List<ScripStaticModel> options = [];
    for (var data in _scripStaticData) {
      if (data.ulToken != model.ulToken) continue;
      if (data.ofisType != 10) continue;
      if (data.expiry != date) continue;
      options.add(data);
    }
    var lessThanCtm = options.where((element) => element.strikePrice! <= model.close).toList();
    lessThanCtm.sort((b, a) => a.strikePrice!.compareTo(b.strikePrice!));
    var lessThanCtmResultCE = lessThanCtm
        .where((element) => element.cpType == 3)
        .take(50)
        .map((e) => OptionChainScripData(CommonFunction.getScripDataModel(exch: e.exch!, exchCode: e.exchCode!)!))
        .toList();
    lessThanCtmResultCE.sort((a, b) => a.model.strikePrice.compareTo(b.model.strikePrice));
    var lessThanCtmResultPE = lessThanCtm
        .where((element) => element.cpType == 4)
        .take(50)
        .map((e) => OptionChainScripData(CommonFunction.getScripDataModel(exch: e.exch!, exchCode: e.exchCode!)!))
        .toList();
    lessThanCtmResultPE.sort((a, b) => a.model.strikePrice.compareTo(b.model.strikePrice));
    var moreThanCtm = options.where((element) => element.strikePrice! > model.close).toList();
    moreThanCtm.sort((a, b) => a.strikePrice!.compareTo(b.strikePrice!));
    var moreThanCtmResultCE = moreThanCtm
        .where((element) => element.cpType == 3)
        .take(50)
        .map((e) => OptionChainScripData(CommonFunction.getScripDataModel(exch: e.exch!, exchCode: e.exchCode!)!))
        .toList();
    var moreThanCtmResultPE = moreThanCtm
        .where((element) => element.cpType == 4)
        .take(50)
        .map((e) => OptionChainScripData(CommonFunction.getScripDataModel(exch: e.exch!, exchCode: e.exchCode!)!))
        .toList();

    return {'LessCE': lessThanCtmResultCE, 'MoreCE': moreThanCtmResultCE, 'LessPE': lessThanCtmResultPE, 'MorePE': moreThanCtmResultPE};
  }

  ScripInfoModel getModel(int scripPos) => _scripData[scripPos];

  ScripStaticModel? getStaticModel(int? exchCode) {
    for (int i = 0; i < _scripStaticData.length; i++) {
      if (_scripStaticData[i].exchCode != exchCode) continue;
      return _scripStaticData[i];
    }
    return null;
  }

  ScripStaticModel? getStaticModelForIsec(String isecName) {
    for (int i = 0; i < _scripStaticData.length; i++) {
      if (_scripStaticData[i].isecName != isecName) continue;
      return _scripStaticData[i];
    }
    return null;
  }

  ScripStaticModel? getStaticModelForCurrFno(String contractName) {
    for (int i = 0; i < _scripStaticData.length; i++) {
      if (_scripStaticData[i].desc!.trim() == contractName.trim()) {
        return _scripStaticData[i];
      }
    }
    return null;
  }

  ScripStaticModel? getStaticFOModelForIsec({
    required String isecName,
    required int expiryDate,
    required String expiryDate2,
    double? strikePrice,
    bool? isCall,
    String? des,
  }) {
    var des2 = "$isecName $expiryDate2 ${!isCall! ? "PE" : "CE"} ${strikePrice!.toStringAsFixed(2)}";

    if (strikePrice == null && strikePrice != 0) {
      int cpType = !isCall ? 3 : 4;
      for (int i = 0; i < _scripStaticData.length; i++) {
        if (_scripStaticData[i].desc != des2) continue;
        // if (_scripData[i].expiry != expiryDate) continue;
        // if (_scripData[i].strikePrice == 15000) {
        //   // print('ADS');
        // }
        // if (_scripData[i].strikePrice != strikePrice) continue;
        if (_scripStaticData[i].cpType != cpType) continue;

        return _scripStaticData[i];
      }
    } else {
      for (int i = 0; i < _scripStaticData.length; i++) {
        if (_scripStaticData[i].cpType != 0) continue;
        if (_scripStaticData[i].isecName != isecName) continue;

        if (_scripStaticData[i].expiry != expiryDate) continue;
        return _scripStaticData[i];
      }
    }

    //   if (strikePrice != null && strikePrice != 0) {
    //
    //   int cpType = isCall ? 3 : 4;
    //   for (int i = 0; i < _scripData.length; i++) {
    //     if (_scripData[i].name != isecName) continue;
    //     if (_scripData[i].expiry != expiryDate) continue;
    //     if (_scripData[i].strikePrice == 15000) {
    //       // print('ADS');
    //     }
    //     if (_scripData[i].strikePrice != strikePrice) continue;
    //     if (_scripData[i].cpType != cpType) continue;
    //
    //
    //     return _scripData[i];
    //   }
    // } else {
    //   for (int i = 0; i < _scripData.length; i++) {
    //     if (_scripData[i].cpType != 0) continue;
    //     if (_scripData[i].isecName != isecName) continue;
    //
    //     if (_scripData[i].expiry != expiryDate) continue;
    //     return _scripData[i];
    //   }
    // }

    // if (strikePrice != null && strikePrice != 0) {
    //
    //   int cpType = isCall ? 3 : 4;
    //   for (int i = 0; i < _scripStaticData.length; i++) {
    //     if (_scripStaticData[i].name != isecName) continue;
    //     if (_scripStaticData[i].expiry != expiryDate) continue;
    //     if (_scripStaticData[i].strikePrice == 15000) {
    //       // print('ADS');
    //     }
    //     if (_scripStaticData[i].strikePrice != strikePrice) continue;
    //     if (_scripStaticData[i].cpType != cpType) continue;
    //     return _scripStaticData[i];
    //   }
    // } else {
    //   for (int i = 0; i < _scripStaticData.length; i++) {
    //     if (_scripStaticData[i].cpType != 0) continue;
    //     if (_scripStaticData[i].isecName != isecName) continue;
    //
    //     if (_scripStaticData[i].expiry != expiryDate) continue;
    //     return _scripStaticData[i];
    //   }
    // }

    return null;
  }

  ScripStaticModel? getStaticFOModelForFlashTrade({
    required String isecName,
    // @required int expiryDate,
    // @required String expiryDate2,
    // double strikePrice,
    // bool isCall,
    // String des,
  }) {
    // var des2 ="$isecName $expiryDate2 ${!isCall?"CE":"PE"} ${strikePrice.toStringAsFixed(2)}";

    // if (strikePrice != null && strikePrice != 0)
    // {

    // int cpType = isCall ? 3 : 4;
    for (int i = 0; i < _scripStaticData.length; i++) {
      // if (_scripData[i].desc != des2) continue;
      if (_scripStaticData[i].name != isecName) continue;
      // if (_scripData[i].strikePrice == 15000) {
      //   // print('ADS');
      // }
      // if (_scripData[i].strikePrice != strikePrice) continue;
      if (_scripStaticData[i].cpType != 0) continue;

      return _scripStaticData[i];
    }
    // }
    // else {
    //   for (int i = 0; i < _scripData.length; i++) {
    //     if (_scripData[i].cpType != 0) continue;
    //     if (_scripData[i].isecName != isecName) continue;
    //
    //     if (_scripData[i].expiry != expiryDate) continue;
    //     return _scripData[i];
    //   }
    // }

    //   if (strikePrice != null && strikePrice != 0) {
    //
    //   int cpType = isCall ? 3 : 4;
    //   for (int i = 0; i < _scripData.length; i++) {
    //     if (_scripData[i].name != isecName) continue;
    //     if (_scripData[i].expiry != expiryDate) continue;
    //     if (_scripData[i].strikePrice == 15000) {
    //       // print('ADS');
    //     }
    //     if (_scripData[i].strikePrice != strikePrice) continue;
    //     if (_scripData[i].cpType != cpType) continue;
    //
    //
    //     return _scripData[i];
    //   }
    // } else {
    //   for (int i = 0; i < _scripData.length; i++) {
    //     if (_scripData[i].cpType != 0) continue;
    //     if (_scripData[i].isecName != isecName) continue;
    //
    //     if (_scripData[i].expiry != expiryDate) continue;
    //     return _scripData[i];
    //   }
    // }

    // if (strikePrice != null && strikePrice != 0) {
    //
    //   int cpType = isCall ? 3 : 4;
    //   for (int i = 0; i < _scripStaticData.length; i++) {
    //     if (_scripStaticData[i].name != isecName) continue;
    //     if (_scripStaticData[i].expiry != expiryDate) continue;
    //     if (_scripStaticData[i].strikePrice == 15000) {
    //       // print('ADS');
    //     }
    //     if (_scripStaticData[i].strikePrice != strikePrice) continue;
    //     if (_scripStaticData[i].cpType != cpType) continue;
    //     return _scripStaticData[i];
    //   }
    // } else {
    //   for (int i = 0; i < _scripStaticData.length; i++) {
    //     if (_scripStaticData[i].cpType != 0) continue;
    //     if (_scripStaticData[i].isecName != isecName) continue;
    //
    //     if (_scripStaticData[i].expiry != expiryDate) continue;
    //     return _scripStaticData[i];
    //   }
    // }

    return null;
  }

  ScripStaticModel? getStaticCommModelForIsec({
    required String isecName,
    required int expiryDate,
    double? strikePrice,
    bool? isCall,
  }) {
    if (strikePrice != null && strikePrice != 0) {
      int cpType = !isCall! ? 3 : 4;
      for (int i = 0; i < _scripStaticData.length; i++) {
        if (_scripStaticData[i].isecName != isecName) continue;
        if (_scripStaticData[i].expiry != expiryDate) continue;
        // if (_scripStaticData[i].strikePrice == 15000) {
        //   print('ADS');
        // }
        if (_scripStaticData[i].strikePrice != strikePrice) continue;
        if (_scripStaticData[i].cpType != cpType) continue;
        return _scripStaticData[i];
      }
    } else {
      for (int i = 0; i < _scripStaticData.length; i++) {
        if (_scripStaticData[i].cpType != 0) continue;
        if (_scripStaticData[i].isecName != isecName) continue;

        if (_scripStaticData[i].expiry != expiryDate) continue;

        return _scripStaticData[i];
      }
    }

    return null;
  }

  ScripStaticModel? getStaticCurrModelfromIsec({
    required String isecName,
    required int expiryDate,
    double? strikePrice,
    bool? isCall,
  }) {
    if (strikePrice != null && strikePrice != 0) {
      int cpType = isCall! ? 3 : 4;
      for (int i = 0; i < _scripStaticData.length; i++) {
        // print("name curr strikePrice =>" + _scripStaticData[i].isecName);
        if (_scripStaticData[i].name != isecName) continue;
        if (_scripStaticData[i].expiry != expiryDate) continue;
        if (_scripStaticData[i].strikePrice == 15000) {
          // print('ADS');
        }
        if (_scripStaticData[i].strikePrice != strikePrice) continue;
        if (_scripStaticData[i].cpType != cpType) continue;
        return _scripStaticData[i];
      }
    } else {
      for (int i = 0; i < _scripStaticData.length; i++) {
        // print("isecname for currency ->$isecName");
        // print("isecName from master ->${_scripStaticData[i].name}");
        if (_scripStaticData[i].cpType != 0) continue;
        if (_scripStaticData[i].name != isecName) continue;

        if (_scripStaticData[i].expiry != expiryDate) continue;
        // print(
        //     "${_scripStaticData[i].isecName} and category ${_scripStaticData[i].exchCode}");
        return _scripStaticData[i];
      }
    }

    return null;
  }

  ScripStaticModel? getStaticModelForCurr(int ulToken, int expiryDate) {
    for (int i = 0; i < _scripStaticData.length; i++) {
      if (_scripStaticData[i].ofisType != 6 && _scripStaticData[i].ulToken != ulToken && _scripStaticData[i].expiry != expiryDate) continue;
      return _scripStaticData[i];
    }
    return null;
  }

  ScripStaticModel? getStaticModelForMcx(int ulToken, int expiryDate) {
    for (int i = 0; i < _scripStaticData.length; i++) {
      if (_scripStaticData[i].ofisType != 9 && _scripStaticData[i].ulToken != ulToken && _scripStaticData[i].expiry != expiryDate) continue;
      return _scripStaticData[i];
    }
    return null;
  }

  Map<String, List<ScripStaticModel>> findModelsForSearchNse(List<String> words, String wholeWord) {
    List<ScripStaticModel> resultEq = [];
    List<ScripStaticModel> resultRest = [];
    int counter = 0;
    for (int i = 0; i < _scripStaticData.length; i++) {
      if (counter >= 100) break;
      if (_scripStaticData[i].series == 'EQ') {
        if (!wholeWord.contains(' ')) {
          if (ifStartsWith(words, _scripStaticData[i].name!) || ifStartsWith(words, _scripStaticData[i].desc!.replaceAll(' ', ''))) {
            resultEq.add(_scripStaticData[i]);
            counter++;
          } else {
            if (ifContainsWord(words, _scripStaticData[i].name!) || ifContainsWord(words, _scripStaticData[i].desc!.replaceAll(' ', ''))) {
              resultRest.add(_scripStaticData[i]);
              counter++;
            }
          }
        } else {
          if (ifContainsWord(words, _scripStaticData[i].name!) || ifContainsWord(words, _scripStaticData[i].desc!.replaceAll(' ', ''))) {
            resultEq.add(_scripStaticData[i]);
            counter++;
          }
        }
      } else {
        if (!wholeWord.contains(' ')) {
          if (ifStartsWith(words, _scripStaticData[i].name!) || ifStartsWith(words, _scripStaticData[i].desc!.replaceAll(' ', ''))) {
            resultEq.add(_scripStaticData[i]);
            counter++;
          }
        } else if (ifContainsWord(words, _scripStaticData[i].name!) || ifContainsWord(words, _scripStaticData[i].desc!.replaceAll(' ', ''))) {
          resultRest.add(_scripStaticData[i]);
          counter++;
        }
      }
    }
    return {'NseEq': resultEq, 'NseRest': resultRest};
  }

  Map<String, List<ScripStaticModel>> findModelsForSearchBse(List<String> words, String wholeWord) {
    List<ScripStaticModel> resultEq = [];
    List<ScripStaticModel> resultRest = [];
    int counter = 0;
    for (int i = 0; i < _scripStaticData.length; i++) {
      if (counter >= 100) break;
      // print(
      //     'this is scrip ${_scripStaticData[i].desc} series  ${_scripStaticData[i].series}');
      if (_scripStaticData[i].series == 'A') {
        // print("inside series a condition");
        if (!wholeWord.contains(' ')) {
          // print("inside no space condition");
          if (ifStartsWith(words, _scripStaticData[i].name!) || ifStartsWith(words, _scripStaticData[i].desc!.replaceAll(' ', ''))) {
            resultEq.add(_scripStaticData[i]);
            counter++;
          } else {
            if (ifContainsWord(words, _scripStaticData[i].name!) || ifContainsWord(words, _scripStaticData[i].desc!.replaceAll(' ', ''))) {
              resultRest.add(_scripStaticData[i]);
              counter++;
            }
          }
        } else {
          // print('inside else condition for no space');
          if (ifContainsWord(words, _scripStaticData[i].name!) || ifContainsWord(words, _scripStaticData[i].desc!.replaceAll(' ', ''))) {
            resultEq.add(_scripStaticData[i]);
            counter++;
          }
        }
      } else {
        // print('inside series not a condition');
        if (!wholeWord.contains(' ')) {
          if (ifStartsWith(words, _scripStaticData[i].name!) || ifStartsWith(words, _scripStaticData[i].desc!.replaceAll(' ', ''))) {
            resultEq.add(_scripStaticData[i]);
            counter++;
          }
        } else if (ifContainsWord(words, _scripStaticData[i].name!) || ifContainsWord(words, _scripStaticData[i].desc!.replaceAll(' ', ''))) {
          resultRest.add(_scripStaticData[i]);
          counter++;
        }
      }
    }
    return {'BseEq': resultEq, 'BseRest': resultRest};
  }

  Map<String, List<ScripStaticModel>> findModelsForSearchFO(List<String> words) {
    String number = '';
    List<ScripStaticModel> resultFutIdx = [];
    List<ScripStaticModel> resultFutStx = [];

    List<ScripStaticModel> resultOptIdx = [];
    List<ScripStaticModel> resultOptStx = [];

    List<ScripStaticModel> resultSpdIdx = [];
    List<ScripStaticModel> resultSpdStx = [];

    for (var word in words) {
      var val = int.tryParse(word);
      if (val != null) {
        number = val.toString();
        break;
      }
    }

    for (int i = 0; i < _scripStaticData.length; i++) {
      if (resultFutIdx.length >= 50 && resultFutStx.length >= 50 && resultOptIdx.length >= 50 && resultOptStx.length >= 50) break;

      bool boolStrikePrice = !(number.isNotEmpty && !_scripStaticData[i].strikePrice.toString().startsWith(number));

      if (ifContainsWord(words, _scripStaticData[i].name!) || ifContainsWord(words, _scripStaticData[i].desc!)) {
        if (_scripStaticData[i].ofisType == 1 && resultFutIdx.length < 50)
          resultFutIdx.add(_scripStaticData[i]);
        else if (_scripStaticData[i].ofisType == 3 && resultFutStx.length < 50)
          resultFutStx.add(_scripStaticData[i]);
        else if (boolStrikePrice && _scripStaticData[i].ofisType == 2)
          resultOptIdx.add(_scripStaticData[i]);
        else if (boolStrikePrice && resultOptStx.length < 50) resultOptStx.add(_scripStaticData[i]);
      }
    }
    resultFutIdx.sort((a, b) => a.expiry!.compareTo(b.expiry!));
    resultFutStx.sort((a, b) => a.expiry!.compareTo(b.expiry!));
    resultOptIdx.sort((a, b) {
      var r = a.expiry!.compareTo(b.expiry!);
      if (r != 0) return r;
      return a.strikePrice!.compareTo(b.strikePrice!);
    });
    resultOptStx.sort((a, b) {
      var r = a.expiry!.compareTo(b.expiry!);
      if (r != 0) return r;
      return a.strikePrice!.compareTo(b.strikePrice!);
    });

    return {'FutIdx': resultFutIdx, 'FutStx': resultFutStx, 'OptIdx': resultOptIdx, 'OptStx': resultOptStx};

    // List<ScripStaticModel> resultFutStxNew = [];
    // List<ScripStaticModel> resultFutIdxNew = [];
    //
    // for(int i=0;i<resultFutStx.length;i++){
    //   if(resultFutStx[i].name.toUpperCase().startsWith(words[0].toUpperCase())) {
    //     resultFutStxNew.add(resultFutStx[i]);
    //     resultFutStx.remove(resultFutStx[i]);
    //   }
    // }
    // for(int i=0;i<resultFutIdx.length;i++){
    //   if(resultFutIdx[i].name.toUpperCase().startsWith(words[0].toUpperCase())) {
    //     resultFutIdxNew.add(resultFutIdx[i]);
    //     resultFutIdx.remove(resultFutIdx[i]);
    //   }
    // }
    //
    // for(int j=0;j<resultFutStxNew.length;j++){
    //   resultFutStx.insert(j,resultFutStxNew[j]);
    // }
    //
    // for(int j=0;j<resultFutIdxNew.length;j++){
    //   resultFutIdx.insert(j,resultFutIdxNew[j]);
    // }
    //
    // List<ScripStaticModel> resultOptStxNew = [];
    // List<ScripStaticModel> resultOptIdxNew = [];
    //
    // try{
    //   String word1 = words.last;
    //   print(words.length);
    //
    //   if(words.length > 1){
    //     for(int i=0;i<resultOptStx.length;i++){
    //       // print(resultOptIdx[i].desc);
    //       if(resultOptStx[i].name.toUpperCase().startsWith(words[0].toUpperCase())) {
    //         // print(resultOptStx[i].desc);
    //         resultOptStxNew.add(resultOptStx[i]);
    //         resultOptStx.remove(resultOptStx[i]);
    //       }else{
    //         resultOptStxNew.add(resultOptStx[i]);
    //         resultOptStx.remove(resultOptStx[i]);
    //       }
    //     }
    //
    //     for(int i=0;i<resultOptIdx.length;i++){
    //       // print(resultOptIdx[i].desc);
    //       if(resultOptIdx[i].name.toUpperCase().startsWith(words[0].toUpperCase())) {
    //         // print(resultOptIdx[i].desc);
    //         resultOptIdxNew.add(resultOptIdx[i]);
    //         resultOptIdx.remove(resultOptIdx[i]);
    //       }else{
    //         resultOptIdxNew.add(resultOptIdx[i]);
    //         resultOptIdx.remove(resultOptIdx[i]);
    //       }
    //     }
    //   }else{
    //
    //   }
    //
    //
    // }catch(e){
    // }
    //
    //
    // for(int j=0;j<resultOptStxNew.length;j++){
    //   resultOptStx.insert(j,resultOptStxNew[j]);
    //   // resultOptStx.add(resultOptStxNew[j]);
    // }
    //
    // for(int j=0;j<resultOptIdxNew.length;j++){
    //   resultOptIdx.insert(j,resultOptIdxNew[j]);
    //   // resultOptIdx.add(resultOptIdxNew[j]);
    // }
    //
    //
    // bool value = isNumeric(words[0]);
    //
    // if(value){
    //   // print("true");
    //
    //   List<ScripStaticModel> resultOptStxNewList1 = [];
    //   for(int i=0;i<resultOptStx.length;i++){
    //     try{
    //       var value = words[1].toString().toUpperCase();
    //       if(resultOptStx[i].name.toString().toUpperCase().startsWith(value)){
    //         resultOptStxNewList1.add(resultOptStx[i]);
    //       }
    //     }catch(e){
    //       resultOptStxNewList1.add(resultOptStx[i]);
    //     }
    //   }
    //
    //   List<ScripStaticModel> resultOptIdxNewList1 = [];
    //   for(int i=0;i<resultOptIdx.length;i++){
    //     try{
    //       var value = words[1].toString().toLowerCase();
    //       if(resultOptIdx[i].name.toString().toLowerCase().startsWith(value)){
    //         resultOptIdxNewList1.add(resultOptIdx[i]);
    //       }
    //     }catch(e){
    //       resultOptIdxNewList1.add(resultOptIdx[i]);
    //     }
    //   }
    //
    //   resultOptStxNewList1.sort((a, b) {
    //     var r = a.expiry.compareTo(b.expiry);
    //     if (r != 0) return r;
    //     return a.strikePrice.compareTo(b.strikePrice);
    //   });
    //
    //   resultOptIdxNewList1.sort((a, b) {
    //     var r = a.expiry.compareTo(b.expiry);
    //     if (r != 0) return r;
    //     return a.strikePrice.compareTo(b.strikePrice);
    //   });
    //
    //   return {
    //     'FutIdx': resultFutIdx,
    //     'FutStx': resultFutStx,
    //     'OptIdx': resultOptIdxNewList1,
    //     'OptStx': resultOptStxNewList1
    //   };
    //
    // }else{
    //   // print("false");
    //   //if words containes alphabets initially
    //
    //   List<ScripStaticModel> resultOptStxNewList = [];
    //   for(int i=0;i<resultOptStx.length;i++){
    //     var value = words[0].toString().toUpperCase();
    //     if(resultOptStx[i].name.toString().toUpperCase().startsWith(value)){
    //       resultOptStxNewList.add(resultOptStx[i]);
    //     }
    //   }
    //
    //   List<ScripStaticModel> resultOptIdxNewList = [];
    //   for(int i=0;i<resultOptIdx.length;i++){
    //     var value = words[0].toString().toLowerCase();
    //     if(resultOptIdx[i].name.toString().toLowerCase().startsWith(value)){
    //       resultOptIdxNewList.add(resultOptIdx[i]);
    //     }else{
    //       // resultOptIdx.removeAt(i);
    //     }
    //   }
    //
    //   for(int j=0;j<resultOptStxNewList.length;j++){
    //     resultOptStx.add(resultOptStxNewList[j]);
    //   }
    //
    //   for(int j=0;j<resultOptIdxNewList.length;j++){
    //     resultOptIdx.add(resultOptIdxNewList[j]);
    //   }
    //
    //   resultOptIdxNewList.sort((a, b) {
    //     var r = a.expiry.compareTo(b.expiry);
    //     if (r != 0) return r;
    //     return a.strikePrice.compareTo(b.strikePrice);
    //   });
    //
    //   resultOptStxNewList.sort((a, b) {
    //     var r = a.expiry.compareTo(b.expiry);
    //     if (r != 0) return r;
    //     return a.strikePrice.compareTo(b.strikePrice);
    //   });
    //
    //   return {
    //     'FutIdx': resultFutIdx,
    //     'FutStx': resultFutStx,
    //     'OptIdx': resultOptIdxNewList,
    //     'OptStx': resultOptStxNewList
    //   };
    //
    // }
  }

  bool isNumeric(String str) {
    RegExp _numeric = RegExp(r'^-?[0-9]+$');
    return _numeric.hasMatch(str);
  }

  Map<String, List<ScripStaticModel>> findModelsForSearchCurrencyFO(List<String> words) {
    List<ScripStaticModel> resultCurrencyF = [];
    List<ScripStaticModel> resultCurrencyO = [];
    String number = '';
    for (var word in words) {
      var val = int.tryParse(word);
      if (val != null) {
        number = val.toString();
        break;
      }
    }

    for (int i = 0; i < _scripStaticData.length; i++) {
      if (resultCurrencyF.length >= 50 && resultCurrencyO.length >= 50) break;

      bool boolStrikePrice = !(number.isNotEmpty && !_scripStaticData[i].strikePrice.toString().startsWith(number));
      if (ifContainsWord(words, _scripStaticData[i].name!) || ifContainsWord(words, _scripStaticData[i].desc!)) {
        // if (_scripStaticData[i].ofisType == 6 && resultCurrencyF.length < 50)
        if (_scripStaticData[i].ofisType == 6)
          resultCurrencyF.add(_scripStaticData[i]);
        // else if (boolStrikePrice && _scripStaticData[i].ofisType == 7 && resultCurrencyO.length < 50)
        else if (boolStrikePrice && _scripStaticData[i].ofisType == 7) resultCurrencyO.add(_scripStaticData[i]);
      }
    }
    resultCurrencyF.sort((a, b) => a.expiry!.compareTo(b.expiry!));

    resultCurrencyO.sort((a, b) {
      var r = a.expiry!.compareTo(b.expiry!);
      if (r != 0) return r;
      return a.strikePrice!.compareTo(b.strikePrice!);
    });

    return {
      'CurrFut': resultCurrencyF,
      'CurrOpt': resultCurrencyO,
    };
  }

  List<ScripStaticModel> findModelsForSearch(List<String> words) {
    List<ScripStaticModel> result = [];
    List<ScripStaticModel> tempList = [];
    String number = '';
    for (var word in words) {
      var val = int.tryParse(word);
      if (val != null) {
        number = val.toString();
        break;
      }
    }
    for (int i = 0; i < _scripStaticData.length; i++) {
      if (result.length >= 100) break;
      bool boolStrikePrice = !(number.isNotEmpty && !_scripStaticData[i].strikePrice.toString().startsWith(number));

      if (ifContainsWord(words, _scripStaticData[i].name!) || ifContainsWord(words, _scripStaticData[i].desc!)) {
        if ((_scripStaticData[i].name == 'MCXCOMPDEX' ||
            _scripStaticData[i].name == 'MCXSILVDEX' ||
            _scripStaticData[i].name == 'MCXGOLDEX' ||
            _scripStaticData[i].name == 'MCXALUMDEX' ||
            _scripStaticData[i].name == 'MCXCOPRDEX' ||
            _scripStaticData[i].name == 'MCXNGASDEX' ||
            _scripStaticData[i].name == 'MCXCRUDEX' ||
            _scripStaticData[i].name == 'MCXLEADEX' ||
            _scripStaticData[i].name == 'MCXNICKDEX' ||
            (_scripStaticData[i].expiry == 0 && _scripStaticData[i].exch == 'M') ||
            (_scripStaticData[i].isecName == '' && _scripStaticData[i].cpType == 0 && _scripStaticData[i].exch == 'M') ||
            _scripStaticData[i].name == 'MCXZINCDEX'))
          continue;
        // else {
        //   _scripStaticData.sort((a, b) {
        //     var r = a.cpType.compareTo(b.cpType);
        //     if (r != 0) return r;
        //     var n = a.name.compareTo(b.name);
        //     if (n != 0) return n;
        //     return a.expiry.compareTo(b.expiry);
        //   });
        //   // _scripStaticData.sort((a, b) => a.cpType.compareTo(b.cpType));
        //
        //   result.add(_scripStaticData[i]);
        // }
        else {
          if (boolStrikePrice &&
              _scripStaticData[i].ofisType == 10 &&
              (ifExactly(words, _scripStaticData[i].desc!) || ifContainsWord(words, _scripStaticData[i].name!))) {
            _scripStaticData.sort((a, b) {
              var r = a.cpType!.compareTo(b.cpType!);
              if (r != 0) return r;
              var n = a.name!.compareTo(b.name!);
              if (n != 0) return n;
              return a.expiry!.compareTo(b.expiry!);
            });
          } else {
            if (boolStrikePrice &&
                _scripStaticData[i].ofisType == 10 &&
                (ifExactly(words, _scripStaticData[i].desc!) || ifContainsWord(words, _scripStaticData[i].name!)))
              _scripStaticData.sort((a, b) {
                var r = a.cpType!.compareTo(b.cpType!);
                if (r != 0) return r;
                var n = a.name!.compareTo(b.name!);
                if (n != 0) return n;
                return a.expiry!.compareTo(b.expiry!);
              });
          }

          // _scripStaticData.sort((a, b) => a.cpType.compareTo(b.cpType));

          result.add(_scripStaticData[i]);
        }
      }
    }
    return result;
  }

  bool ifContainsWord(List<String> words, String inputSearch) {
    bool found = true;
    inputSearch = inputSearch.toLowerCase();
    for (int i = 0; i < words.length; i++) {
      if (!inputSearch.contains(words[i])) {
        found = false;
        break;
      }
    }
    return found;
  }

  bool ifExactly(List<String> words, String inputSearch) {
    bool found = true;
    inputSearch = inputSearch.toLowerCase();
    for (int i = 0; i < words.length; i++) {
      if (inputSearch != words[i]) {
        found = false;
        break;
      }
    }
    return found;
  }

  bool ifStartsWith(List<String> words, String inputSearch) {
    bool found = false;
    inputSearch = inputSearch.toLowerCase();
    for (int i = 0; i < words.length; i++) {
      if (inputSearch.startsWith(words[i])) {
        found = true;
        break;
      }
    }
    return found;
  }

  ScripStaticModel? getStaticModelFromName(
      String name,
      ExchCategory exchCategory,
      String isecName,
      ) {
    name = name.toUpperCase();
    for (int i = 0; i < _scripStaticData.length; i++) {
      if (_scripStaticData[i].name == name) {
        if (exchCategory == ExchCategory.bseEquity && _scripStaticData[i].series == "EQ")
          return _scripStaticData[i];
        else if (exchCategory == ExchCategory.nseEquity) return _scripStaticData[i];
      } else
        continue;
    }
    return null;
  }

  ScripStaticModel? getStaticModelFromNameForFlashTrade(
      String name,
      ExchCategory exchCategory,
      String isecName,
      ) {
    name = name.toUpperCase();
    for (int i = 0; i < _scripStaticData.length; i++) {
      if (_scripStaticData[i].name == name) {
        // if (exchCategory == ExchCategory.bseEquity &&
        //     _scripStaticData[i].series == "EQ")
        //   return _scripStaticData[i];
        // else if (exchCategory == ExchCategory.nseEquity)
        return _scripStaticData[i];
      } else
        continue;
    }
    return null;
  }

  // ScripStaticModel getStaticModelFromName(String name) {
  //   name = name.toLowerCase();
  //   for (int i = 0; i < _scripStaticData.length; i++) {
  //     if (_scripStaticData[i].name.toLowerCase() != name) continue;
  //     return _scripStaticData[i];
  //   }
  //   return null;
  // }

  ScripStaticModel? getStaticModelFromSeries(String name, String series) {
    name = name.toLowerCase();
    for (int i = 0; i < _scripStaticData.length; i++) {
      if (_scripStaticData[i].isecName!.toLowerCase() != name) continue;
      return _scripStaticData[i];
    }
    return null;
  }

  void printDuplicate() {
    var codes = <int>[];
    _scripData.forEach((element) {
      if (codes.contains(element.exchCode))
        print('${element.name} ${element.exchCode}');
      else
        codes.add(element.exchCode);
    });
  }

  void addAllNseDeriv(List<Map<String, dynamic>> data) {
    _scripStaticData = [];
    for (int i = 0; i < data.length; i++) {
      _scripStaticData.add(ScripStaticModel.nseDeriv(data[i]));
    }
  }

  void addAllNseCurrDeriv(List<Map<String, dynamic>> data) {
    _scripStaticData = [];
    for (int i = 0; i < data.length; i++) {
      _scripStaticData.add(ScripStaticModel.nseCurrData(data[i]));
    }
  }

  void addAllBseCurrDeriv(List<Map<String, dynamic>> data) {
    _scripStaticData = [];
    for (int i = 0; i < data.length; i++) {
      _scripStaticData.add(ScripStaticModel.bseCurrData(data[i]));
    }
  }

  void addAllMFData(List<Map<String, dynamic>> data) {
    _scripStaticData = [];
    for (int i = 0; i < data.length; i++) {
      _scripStaticData.add(ScripStaticModel.mutualFundData(data[i]));
    }
  }

  void addAllMcx(List<Map<String, dynamic>> data) {
    _scripStaticData = [];
    for (int i = 0; i < data.length; i++) {
      // _scripStaticData.sort((a, b) => a.expiry.compareTo(b.expiry));
      _scripStaticData.add(ScripStaticModel.mcxData(data[i]));
    }
  }

  void addAllNseEquity(List<Map<String, dynamic>> data) async {
    _scripStaticData = [];
    for (int i = 0; i < data.length; i++) {
      _scripStaticData.add(ScripStaticModel.nseEquityData(data[i]));
    }
  }

  void addAllBseEquity(List<Map<String, dynamic>> data) {
    _scripStaticData = [];
    for (int i = 0; i < data.length; i++) {
      _scripStaticData.add(ScripStaticModel.bseEquityData(data[i]));
    }
  }

  List<ScripStaticModel> getNseIndices(String searchText) {
    if (searchText.isEmpty)
      return _scripStaticData
          .where((element) => element.exchCode! >= Dataconstants.nseCashIndexCodeStart && element.exchCode! <= Dataconstants.nseCashIndexCodeEnd)
          .toList();
    else
      return _scripStaticData
          .where((element) =>
      element.exchCode! >= Dataconstants.nseCashIndexCodeStart &&
          element.exchCode! <= Dataconstants.nseCashIndexCodeEnd &&
          element.desc!.toLowerCase().contains(searchText))
          .toList();
  }

  List<ScripStaticModel> getBseIndices(String searchText) {
    if (searchText.isEmpty)
      return _scripStaticData
          .where((element) => element.exchCode! >= Dataconstants.bseCashIndexCodeStart && element.exchCode! <= Dataconstants.bseCashIndexCodeEnd)
          .toList();
    else
      return _scripStaticData
          .where((element) =>
      element.exchCode! >= Dataconstants.bseCashIndexCodeStart &&
          element.exchCode! <= Dataconstants.bseCashIndexCodeEnd &&
          element.desc!.toLowerCase().contains(searchText))
          .toList();
  }

  List<ScripStaticModel> getMutualFund(String searchText) {
    return _scripStaticData.toList();
  }
}

enum ExchangeStatus {
  nesNone,
  nesOpen,
  nesClosed,
  nesPostClosing,
  nesPreopen,
  nesPreopenMatch,
  nesAHOpen,
  nesAHClosed,
  nesProblem,
  nesExerciseOpen,
  nesExerciseClosed,
  mcxOpen,
  mcxClosed
}