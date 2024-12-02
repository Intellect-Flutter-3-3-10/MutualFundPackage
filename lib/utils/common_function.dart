
class CommonFunction {
  static const platform = MethodChannel('samples.flutter.dev/tokens');

  static void setUsernamePass({
    required String userName,
  }) async {
    GetStorageData.write('username', userName);
  }

  static void setUserData(userName, bioMetricCoe, mpin) async {
    //bigul

    GetStorageData.write('username', userName);
    GetStorageData.write('bioMetricCoe', bioMetricCoe);
    GetStorageData.write('mpin', mpin);
  }

  static void getUserData() async {
    //bigul

    GetStorageData.read('username');
    GetStorageData.read('bioMetricCoe');
    GetStorageData.read('mpin');
  }

  static getScannersList(token) async {
    http.Response response = await Dataconstants.itsClient.httpPostWithHeader(
        BrokerInfo.mainUrl == BrokerInfo.UATURL
            ? "https://bigulint.bigul.app/chart/api/Scanner/ScannerBodyList"
            : BrokerInfo.mainUrl == BrokerInfo.LiveURL
            ? "https://bigulint.bigul.co/chart/api/Scanner/ScannerBodyList"
            : "https://bigulint.bigul.app/chart/api/Scanner/ScannerBodyList",
        {},
        token);
    // //print("generate OTP response - ${response.body.toString()}");
    return response.body.toString();
  }

  static ScripInfoModel getScripDataModels({
    required String exch,
    required int exchCode,
    bool sendReq = true,
    bool getNseBseMap = false,
    int getChartDataTime = 0,
  }) {
    int counter = 0;
    var fmt = DateFormat('dd-MMM-yyyy');
    var fmt1 = DateFormat('dd-MMM-yyyy HH:mm:ss');
    // //print(fmt.format(DateTime.now()));
    var fmtdate = fmt.format(DateTime.now().subtract(Duration(days: 1)));
    String openDate = fmtdate + ' 09:15:00';
    int exchPos = getExchPosOnCode(exch, exchCode);
    if (exchPos < 0) return ScripInfoModel();
    int scripPos = Dataconstants.exchData[exchPos]!.scripPos(exchCode);
    if (scripPos < 0) {
      var model = Dataconstants.exchData[exchPos]!.getStaticModel(exchCode);
      ScripInfoModel finalModel = ScripInfoModel();
      if (model != null) {
        int ScripPos = Dataconstants.exchData[exchPos]!.scripPos(model.exchCode!);
        if (ScripPos < 0) {
          finalModel = ScripInfoModel()..setStaticData(model);
        } else {
          finalModel = Dataconstants.exchData[exchPos]!.getModel(ScripPos);
        }
      }

      Dataconstants.exchData[exchPos]!.addModel(finalModel);
      if (getNseBseMap && (model!.exchCategory! == ExchCategory.nseEquity || model.exchCategory! == ExchCategory.bseEquity)) {
        ScripInfoModel? alternateModel = getBseNseMapModelOI(model.name!, model.exchCategory!);
        if (alternateModel != null) finalModel.addAlternateModel(alternateModel);
      }
      if (getNseBseMap && (model!.exchCategory! == ExchCategory.currenyFutures || model.exchCategory! == ExchCategory.currenyOptions)) {
        ScripInfoModel? alternateModel = getBseNseMapModelOI(model.name!, model.exchCategory!);
        if (alternateModel != null) finalModel.addAlternateModel(alternateModel);
      }
      if (getNseBseMap && (model!.exchCategory == ExchCategory.nseFuture || model.exchCategory == ExchCategory.nseOptions)) {
        ScripInfoModel? alternateModel = getBseNseMapModelOI(model.name!, model.exchCategory!);
        if (alternateModel != null) finalModel.addAlternateModel(alternateModel);
      }
      if (getNseBseMap && (model!.exchCategory == ExchCategory.bseCurrenyOptions || model.exchCategory == ExchCategory.bseCurrenyFutures)) {
        ScripInfoModel? alternateModel = getBseNseMapModelOI(model.name!, model.exchCategory!);
        if (alternateModel != null) finalModel.addAlternateModel(alternateModel);
      }
      if (getNseBseMap && (model!.exchCategory == ExchCategory.mcxFutures || model.exchCategory! == ExchCategory.mcxOptions)) {
        ScripInfoModel? alternateModel = getBseNseMapModelOI(model.name!, model.exchCategory!);
        if (alternateModel != null) finalModel.addAlternateModel(alternateModel);
      }
      if (sendReq) Dataconstants.iqsClient!.sendLTPRequest(finalModel, true);
      if (getChartDataTime > 0) Dataconstants.itsClient.getChartData(timeInterval: getChartDataTime, chartPeriod: "I", model: finalModel);
      return finalModel;
    } else {
      var result = Dataconstants.exchData[exchPos]!.getModel(scripPos);

      if (result.alternateModel == null && getNseBseMap && result.exchCategory == ExchCategory.nseEquity ||
          result.exchCategory == ExchCategory.bseEquity) {
        ScripInfoModel? alternateModel = getBseNseMapModelOI(result.name, result.exchCategory!);
        if (alternateModel != null) result.addAlternateModel(alternateModel);
      }
      if (result.alternateModel == null && getNseBseMap && result.exchCategory == ExchCategory.nseFuture ||
          result.exchCategory == ExchCategory.nseOptions) {
        ScripInfoModel? alternateModel = getBseNseMapModelOI(result.name, result.exchCategory!);
        if (alternateModel != null) result.addAlternateModel(alternateModel);
      }
      if (result.alternateModel == null && getNseBseMap && result.exchCategory == ExchCategory.currenyFutures ||
          result.exchCategory == ExchCategory.currenyOptions) {
        ScripInfoModel? alternateModel = getBseNseMapModelOI(result.name, result.exchCategory!);
        if (alternateModel != null) result.addAlternateModel(alternateModel);
      }
      if (result.alternateModel == null && getNseBseMap && result.exchCategory == ExchCategory.bseCurrenyFutures ||
          result.exchCategory == ExchCategory.bseCurrenyOptions) {
        ScripInfoModel? alternateModel = getBseNseMapModelOI(result.name, result.exchCategory!);
        if (alternateModel != null) result.addAlternateModel(alternateModel);
      }
      if (result.alternateModel == null && getNseBseMap && result.exchCategory == ExchCategory.mcxFutures ||
          result.exchCategory == ExchCategory.mcxOptions) {
        ScripInfoModel? alternateModel = getBseNseMapModelOI(result.name, result.exchCategory!);
        if (alternateModel != null) result.addAlternateModel(alternateModel);
      }
      if (sendReq) Dataconstants.iqsClient!.sendLTPRequest(result, true);
      if (getChartDataTime > 0)
        result.getChartData(
          timeInterval: getChartDataTime,
          chartPeriod: "I",
        );
      return result;
    }
  }

  static ScripInfoModel? getBseNseMapModelOI(String name, ExchCategory exchCategory) {
    if (exchCategory != ExchCategory.nseEquity && exchCategory != ExchCategory.bseEquity) return null;
    ScripInfoModel resultModel;
    ScripStaticModel? staticModel;
    if (exchCategory == ExchCategory.nseEquity)
      staticModel = Dataconstants.exchData[2]!.getStaticModelFromNameOI(name);
    else
      staticModel = Dataconstants.exchData[0]!.getStaticModelFromNameOI(name);

    resultModel = ScripInfoModel()..setStaticData(staticModel);

    int exchPos = getExchPosOnCode(resultModel.exch, resultModel.exchCode);
    if (exchPos < 0) return null;
    int scripPos = Dataconstants.exchData[exchPos]!.scripPos(resultModel.exchCode);
    if (scripPos < 0) {
      Dataconstants.exchData[exchPos]!.addModel(resultModel);
      return resultModel;
    } else
      return Dataconstants.exchData[exchPos]!.getModel(scripPos);
  }

  static void removeUserData() async {
    //bigul

    // GetStorageData.remove('username');
    GetStorageData.remove('bioMetricCoe');
    GetStorageData.remove('mpin');
  }

  static Future getMasterServerDate() async {
    try {
      var response = await post((Uri.parse(BrokerInfo.masterdate)));
      print('MasterServerDate ${response.body}');
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data["data"];
      } else {
        return null;
      }
    } on TimeoutException {
      return null;
    } catch (e) {
      //print(e);
      return null;
    }
  }

  static void setFlashTradData(stopLoss, takeProfit, quantity, timePeriod, String exch, int exchCode) async {
    //bigul flashtrade

    GetStorageData.write('stopLossFlashTrade', stopLoss);
    GetStorageData.write('takeProfitFlashTrade', takeProfit);
    GetStorageData.write('quantityFtalshTrade', quantity);
    GetStorageData.write('timePeriodTimePeriod', timePeriod);
    GetStorageData.write('scripCode', exchCode.toString());
    GetStorageData.write('exchange', exch);
  }

  static void getFlashTradData() async {
    //bigul flashtrade

    GetStorageData.read('stopLossFlashTrade');
    GetStorageData.read('takeProfitFlashTrade');
    GetStorageData.read('quantityFtalshTrade');
    GetStorageData.read('timePeriodTimePeriod');
  }

  static removeAllCharts() async {
    GetStorageData.remove("predefinedChartTime");
    GetStorageData.remove("IndicesChartTime");
    GetStorageData.remove("MarketWatchChartTime");
  }

  static changeStatusBar() {
    var overlayStyle;
    if (ThemeConstants.themeMode.value == ThemeMode.light) {
      overlayStyle = SystemUiOverlayStyle.dark;
    } else if (ThemeConstants.themeMode.value == ThemeMode.dark && ThemeConstants.amoledThemeMode.value) {
      overlayStyle = SystemUiOverlayStyle.light;
    } else {
      overlayStyle = SystemUiOverlayStyle.light;
    }
    Dataconstants.overlayStyle = overlayStyle;
  }

  static Future<bool> extract7zFile(String filePath) async {
    final bytes = await File(filePath).readAsBytes(); // Asynchronous file read
    final archive = ZipDecoder().decodeBytes(bytes);

    final outputDirPath = await getDatabasesPath();
    final dbFilePath = path.join(outputDirPath, "masters.mf");
    final dbFile = File(dbFilePath);

    if (await dbFile.exists()) {
      await dbFile.delete();
    }

    for (final file in archive) {
      final filePath = path.join(outputDirPath, file.name.toLowerCase());
      if (file.isFile) {
        final data = file.content as List<int>;
        await File(filePath).writeAsBytes(data);

        // Append the data to the masters.mf file
        await dbFile.writeAsBytes(data, mode: FileMode.append, flush: true);
      } else {
        await Directory(filePath).create(recursive: true);
      }
    }
    return true;
  }

  static Future<void> showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails('your channel id', 'your channel name', importance: Importance.max, priority: Priority.high, ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await Dataconstants.flutterLocalNotificationsPlugin!
        .show(0, message.notification!.title, message.notification!.body, platformChannelSpecifics, payload: 'item x');
  }

  static Future<String> downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final Response response = await get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  // static void showDialogInternetForAll(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return WillPopScope(
  //         onWillPop: () async => false,
  //         child: AlertDialog(
  //           title: new Text(""),
  //           content: new Text("Failed to connect to the server. This usually means there’s a network issue. If the issue persists, please try restarting the app"),
  //           actions: <Widget>[
  //             new TextButton(
  //               child: new Text(
  //                 "Retry",
  //                 style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color),
  //               ),
  //               onPressed: () async {
  //                 if (Dataconstants.scripInfoModel != null) {
  //                   Dataconstants.iqsClient!.sendMarketDepthRequest(Dataconstants.scripInfoModel!.exch, Dataconstants.scripInfoModel!.exchCode, true);
  //                 }
  //                 InternetConnectionStatus status = await Dataconstants.customInstance.connectionStatus;
  //                 switch (status) {
  //                   case InternetConnectionStatus.connected:
  //                     Navigator.of(context).pop(true);
  //
  //                     break;
  //                   case InternetConnectionStatus.disconnected:
  //                     return;
  //                     break;
  //                 }
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   ).then((value) => Dataconstants.isVisibleDialog = true);
  // }

  static void showDialogInternetForAll(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.info, color: Colors.white),
            SizedBox(width: 5),
            Text('Please check your Internet / Wifi connection.'),
          ],
        ),
        duration: Duration(days: 365),
        backgroundColor: ThemeConstants.blackColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        dismissDirection: DismissDirection.none,
      ),
    );
  }

  static aliceLogging({String? link, var payload, var headers, Duration timeoutDuration = const Duration(seconds: 10)}) async {
    var response;
    if (headers != null) {
      await post(
        Uri.parse(link!),
        headers: headers,
        body: payload,
      ).timeout(timeoutDuration).then((responses) {
        response = responses;
        // Dataconstants.alice.onHttpResponse(response);
      });
    } else {
      await post(
        Uri.parse(link!),
        body: payload,
      ).timeout(timeoutDuration).then((responses) {
        response = responses;
        // Dataconstants.alice.onHttpResponse(response);
      });
    }
    return response;
  }

  static aliceLoggingGetMethod({String? link}) async {
    var response;
    await get(Uri.parse(link!)).then((responses) {
      response = responses.body.trimLeft();
    });
    return response;
  }

  static getPredefinedChartTime() async {
    var checkKey = GetStorageData.containsKey('predefinedChartTime') ?? false;
    var actualMin = DateTime.now();
    if (!checkKey) {
      setPredefinedChartTime(actualMin);
      return true;
    } else {
      DateTime? savedDateTime =
      (GetStorageData.containsKey('predefinedChartTime') ? GetStorageData.read('predefinedChartTime') : DateTime.now()) as DateTime?;
      DateTime? tempDate = (checkKey ? new DateFormat("yyyy-MM-dd H:mm:ss").parse(savedDateTime as String) : savedDateTime);
      var finalDate = tempDate!.add(Duration(minutes: 15));

      var result = actualMin.isAfter(finalDate);
      if (result) setPredefinedChartTime(actualMin);
      return result;
    }
  }

  static getIndicesChartTime() async {
    var checkKey = GetStorageData.containsKey('IndicesChartTime') ?? false;
    var actualMin = DateTime.now();
    if (!checkKey) {
      setIndicesChartTime(actualMin);
      return true;
    } else {
      DateTime? savedDateTime =
      (GetStorageData.containsKey('IndicesChartTime') ? GetStorageData.read('IndicesChartTime') : DateTime.now()) as DateTime?;
      DateTime? tempDate = (checkKey ? new DateFormat("yyyy-MM-dd H:mm:ss").parse(savedDateTime as String) : savedDateTime);
      var finalDate = tempDate!.add(Duration(minutes: 15));

      var result = actualMin.isAfter(finalDate);
      if (result) setIndicesChartTime(actualMin);
      return result;
    }
  }

  static getMarketWatchChartTime() async {
    var checkKey = GetStorageData.containsKey('MarketWatchChartTime');
    var actualMin = DateTime.now();
    if (!checkKey) {
      setMarketWatchChartTime(actualMin);
      return true;
    } else {
      DateTime? savedDateTime =
      (GetStorageData.containsKey('MarketWatchChartTime') ? GetStorageData.read('MarketWatchChartTime') : DateTime.now()) as DateTime?;
      DateTime? tempDate = (checkKey ? new DateFormat("yyyy-MM-dd H:mm:ss").parse(savedDateTime as String) : savedDateTime);
      var finalDate = tempDate!.add(Duration(minutes: 15));

      var result = actualMin.isAfter(finalDate);
      if (result) setMarketWatchChartTime(actualMin);
      return result;
    }
  }

  static setPredefinedChartTime(actualMin) async {
    return GetStorageData.write('predefinedChartTime', actualMin.toString());
  }

  static setIndicesChartTime(actualMin) async {
    return GetStorageData.write('IndicesChartTime', actualMin.toString());
  }

  static setMarketWatchChartTime(actualMin) async {
    return GetStorageData.write('MarketWatchChartTime', actualMin.toString());
  }

  static double getMarketRate(ScripInfoModel model, bool isBuy) {
    double rate = 0.00;
    if (isBuy) {
      rate = model.offerRate1;
      if (rate < 0.05) rate = model.bidRate1;
    } else {
      rate = model.bidRate1;
      if (rate < 0.05) rate = model.offerRate1;
    }
    if (rate < 0.05) rate = model.close;
    if (rate < 0.05) rate = model.prevDayClose;
    return rate;
  }

  static double getCurrencyMarketRate(ScripInfoModel model, bool isBuy) {
    double rate = 0.0000;
    if (isBuy) {
      rate = model.offerRate1;
      if (rate < 0.0005) rate = model.bidRate1;
    } else {
      rate = model.bidRate1;
      if (rate < 0.0005) rate = model.offerRate1;
    }
    if (rate < 0.0005) rate = model.lastTickRate;
    if (rate < 0.0005) rate = model.prevDayClose;
    return rate;
  }

  static Future<String> getIp() async {
    for (var interface in await NetworkInterface.list()) {
      for (var addr in interface.addresses) {
        if (addr.type != InternetAddressType.IPv4) continue;
        return addr.address.trim();
      }
    }
    return '';
  }

  static Future<String> getEncryptedText(text) async {
    String instanceIdToken;
    try {
      var result;
      if (Platform.isAndroid) {
        result = await platform.invokeMethod('EncryptText', {"mobile_no": text});
        // print('resposne from android $result');
      } else {
        result = await platform.invokeMethod('EncryptText');
        // print('resposne from ios $result');
      }
      instanceIdToken = result;
    } on PlatformException catch (e) {
      instanceIdToken = "";
    }
    return instanceIdToken.toString().trim();
  }

  static Widget openAnAccountButtin({BuildContext? context, String? comingFrom, String? line1}) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "$line1",
            style: TextStyle(
              color: Theme.of(context!).primaryColor,
            ),
          ),
          Text(
            "open an account now it takes",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          Text(
            "only 10 minute.",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            // width: double.infinity,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fixedSize: Size.fromHeight(45),
                ),
                onPressed: () async {
                  var device;
                  if (Platform.isAndroid)
                    device = 'android';
                  else
                    device = 'iOS';

                  var utmSource = GetStorageData.read('utm_source');
                  var utmTerm = GetStorageData.read('utm_term');
                  var utmcampaign = GetStorageData.read('utm_campaign');
                  var utmadid = GetStorageData.read('utm_adid');
                  var utmmedium = GetStorageData.read('utm_medium');
                  var utmcontent = GetStorageData.read('utm_content');
                  var utmadgroup = GetStorageData.read('utm_adgroup');
                  // print("source = $utmSource & medium = $utmmedium");
                  var link = BrokerInfo.createAccountLink + '?';

                  if (utmSource != null)
                    link += 'utm_source=mktapp-gl-$utmSource';
                  else {
                    if (Platform.isIOS)
                      link += 'utm_source=mktapp-gl-ios';
                    else
                      link += 'utm_source=mktapp-gl-android-na';
                  }
                  if (utmmedium != null)
                    link += '&utm_medium=mktapp-$utmmedium';
                  else {
                    if (Platform.isIOS)
                      link += '&utm_medium=mktapp-organic';
                    else
                      link += '&utm_medium=mktapp-na';
                  }
                  if (utmcampaign != null)
                    link += '&utm_campaign=OAO';
                  else {
                    if (Platform.isIOS)
                      link += '&utm_campaign=OAO';
                    else
                      link += '&utm_campaign=na';
                  }
                  if (utmcontent != null)
                    link += '&utm_content=$device-$utmcontent';
                  else {
                    if (Platform.isIOS)
                      link += '&utm_content=na';
                    else
                      link += '&utm_content=na';
                  }
                  if (utmadgroup != null) link += '&utm_adgroup=$utmadgroup';
                  if (utmTerm != null)
                    link += '&utm_term=$utmTerm';
                  else {
                    if (Platform.isIOS)
                      link += '&utm_term=na';
                    else
                      link += '&utm_term=na';
                  }
                  if (utmadid != null) link += '&utm_adid=$utmadid';
                  // String mobileNo = GetStorageData.read('verifiedmobileno');
                  link +=
                  "&cid=${Dataconstants.uuid}&av=${Dataconstants.fileVersion}&aid=com.icicidirect.markets&dimension%2017=MarketApp&app_id=${Dataconstants.appInstanceId}";
                  String mobileNo = GetStorageData.read('verifiedmobileno')!;
                  if (Platform.isAndroid) {
                    var encryptedNo = await getEncryptedText(mobileNo);
                    // print("mobile no=> ${encryptedNo}");

                    if (encryptedNo != "") {
                      var encodedMobile = Uri.encodeComponent(encryptedNo);
                      print("encodedUrl url - $encodedMobile");
                      link += '&Mobile=$encodedMobile';
                    }
                  } else {
                    link += '&Mobile=$mobileNo';
                  }
                  Dataconstants.itsClient.guestloginScreenEvent(
                      eventAction: 'open_an_account_click', eventLabel: 'Successful', logEvent: 'open_an_account', eventCategory: comingFrom!);
                  // print("more link $link");
                  if (Platform.isIOS) link = link.replaceAll(' ', '%20');
                  // if (await canLaunch(link)) launch(link);
                  var cstatus = await Permission.camera.status;
                  var sstatus = await Permission.storage.status;
                  if (sstatus.isDenied || cstatus.isDenied || cstatus.isPermanentlyDenied || sstatus.isPermanentlyDenied) {
                    await [
                      Permission.camera,
                      Permission.storage,
                      Permission.photos,
                      Permission.microphone,
                    ].request();
                    cstatus = await Permission.camera.status;
                    sstatus = await Permission.storage.status;

                    if (sstatus.isDenied || cstatus.isDenied || cstatus.isPermanentlyDenied || sstatus.isPermanentlyDenied) {
                      await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Platform.isIOS && (cstatus.isPermanentlyDenied || sstatus.isPermanentlyDenied)
                                ? CupertinoAlertDialog(
                              title: Text(
                                'Permission Alert',
                                style: TextStyle(fontSize: 18),
                              ),

                              content: Text(
                                "Please grant permission for camera to use features under this facility",
                                style: TextStyle(fontSize: 14),
                              ),
                              //content: ChangelogScreen(),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(
                                    'OK',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  onPressed: () {
                                    openAppSettings();
                                  },
                                ),
                              ],
                            )
                                : AlertDialog(
                              contentPadding: EdgeInsets.fromLTRB(24, 20, 10, 10),
                              title: Text(
                                'Permission Alert',
                                style: TextStyle(fontSize: 18),
                              ),
                              buttonPadding: EdgeInsets.zero,
                              content: Text(
                                "Please grant permission for camera to use features under this facility",
                                style: TextStyle(fontSize: 14),
                              ),
                              //content: ChangelogScreen(),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(
                                    'OK',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  onPressed: () {
                                    openAppSettings();
                                  },
                                ),
                              ],
                            );
                          });
                    }
                  } else {
                    try {
                      // if (Platform.isAndroid) {
                      //   InAppSelection.advertisingId =
                      //   await AdvertisingId.id(true);
                      // } else {
                      //   InAppSelection.advertisingId =
                      //   await AdvertisingId.id(true);
                      //   // InAppSelection.advertisingId = '00000000-0000-0000-0000-000000000000';
                      // }
                      if (InAppSelection.advertisingId == "" || InAppSelection.advertisingId == null) {
                        InAppSelection.advertisingId = "00000000-0000-0000-0000-000000000000";
                      }
                    } catch (e) {
                      InAppSelection.advertisingId = "00000000-0000-0000-0000-000000000000";
                    }
                    if (Platform.isAndroid)
                      Navigator.push(context, MaterialPageRoute(builder: (context) => OAOWebLink("Open An Account", link)));
                    else
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChromeSafari("Open An Account", link)));
                  }
                },
                child: Text(
                  'Open an account',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static String currencyFormat(double val) => NumberFormat.currency(
    locale: "en_IN",
    symbol: '',
  ).format(val).trim();

  static Future<void> showSnackBarKey({
    required BuildContext context,
    required GlobalKey<ScaffoldMessengerState> key,
    required String text,
    Color? color,
    Duration duration = const Duration(seconds: 3),
  }) {
    Completer completer = Completer();
    FocusScope.of(context).requestFocus(FocusNode());
    key.currentState?.removeCurrentSnackBar();
    if (color == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
          ),
          duration: duration,
        ),
      )
          .closed
          .then((value) => completer.complete());
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
          ),
          backgroundColor: color,
          duration: duration,
        ),
      )
          .closed
          .then((value) => completer.complete());
    }
    return completer.future;
  }

  static Future<void> showSnackBar({
    required BuildContext context,
    required String text,
    Color? color,
    Duration duration = const Duration(seconds: 3),
  }) {
    Completer completer = Completer();
    if (color == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
          ),
          duration: duration,
        ),
      )
          .closed
          .then((value) => completer.complete());
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
          ),
          backgroundColor: color,
          duration: duration,
        ),
      )
          .closed
          .then((value) => completer.complete());
    }
    return completer.future;
  }

  static void showBasicToast(String message, [int seconds = 1]) {
    if (message.toString().toUpperCase().contains("PEAK MARGIN")) return;
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: seconds,
        backgroundColor: Colors.grey,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  static void showBasicKycToast(String message, [int seconds = 5]) {
    if (message.toString().toUpperCase().contains("PEAK MARGIN")) return;
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: seconds,
        backgroundColor: Colors.grey,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  static void showLoader(BuildContext context, String str) {
    showDialog(context: context, barrierDismissible: false, builder: (_) => Loader(msg: str));
  }

  static Future<String> getVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    Dataconstants.version = packageInfo.version;
    return packageInfo.version;
  }

  static void dismissLoader(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  static String converToTitleCase(String s) {
    String value = s;
    return '${value[0].toUpperCase()}${value.substring(1)}';
  }

  static String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  static int? getExchPosForAlgo(String exch, String exchType) {
    if (exch == 'N' && exchType == 'C') {
      return 0;
    }
    if (exch == 'N' && exchType == 'D') {
      return 1;
    }
    if (exch == 'B' && exchType == 'C') {
      return 2;
    }
    if (exch == 'C' && exchType == 'D') {
      return 3;
    }
    if (exch == 'E' && exchType == 'D') {
      return 4;
    }
    if (exch == 'M' && exchType == 'D') {
      return 5;
    }
  }

  static int getExchPosISec(String exch) {
    switch (exch) {
      case 'NSE':
        return 0;
        break;
      case 'BSE':
        return 2;
        break;
      case 'NFO':
        return 1;
        break;
      case 'NDX':
        return 3;
        break;
      case 'MCO':
        return 5;
        break;

      default:
        return 0;
        break;
    }
  }

  static int getExchPosOnCode(String exch, int exchCode) {
    if (exch == 'C')
      return 3;
    else if (exch == 'M')
      return 5;
    else if (exch == 'B')
      return 2;
    else if (exch == 'E')
      return 4;
    else if (isEquity(exchCode))
      return 0;
    else
      return 1;
  }

  static ScripInfoModel getScripDataModelFastForIQS({
    required int exchPos,
    required int exchCode,
  }) {
    if (exchPos < 0) return ScripInfoModel();
    var model = Dataconstants.exchData[exchPos]!.getStaticModel(exchCode);
    if (model == null) return ScripInfoModel();
    ScripInfoModel finalModel = ScripInfoModel()..setStaticData(model);
    Dataconstants.exchData[exchPos]!.addModel(finalModel);
    return finalModel;
  }

  static ScripInfoModel getScripDataModelForUnderlyingCurr(ScripInfoModel underlyingModel) {
    int exchPos;
    if (underlyingModel.exchCategory == ExchCategory.currenyFutures || underlyingModel.exchCategory == ExchCategory.currenyOptions)
      exchPos = 3;
    else
      exchPos = 4;
    var model = Dataconstants.exchData[exchPos]!.getStaticModelForCurr(underlyingModel.ulToken, underlyingModel.expiry);
    if (model == null) return ScripInfoModel();
    ScripInfoModel finalModel = ScripInfoModel()..setStaticData(model);

    Dataconstants.exchData[exchPos]!.addModel(finalModel);

    Dataconstants.iqsClient!.sendLTPRequest(finalModel, true);
    return finalModel;
  }

  static ScripInfoModel getScripDataModelForUnderlyingMcx(ScripInfoModel underlyingModel) {
    var model = Dataconstants.exchData[5]!.getStaticModelForMcx(underlyingModel.ulToken, underlyingModel.expiry);
    if (model == null) return ScripInfoModel();
    ScripInfoModel finalModel = ScripInfoModel()..setStaticData(model);

    Dataconstants.exchData[5]!.addModel(finalModel);

    Dataconstants.iqsClient!.sendLTPRequest(finalModel, true);
    return finalModel;
  }

  static ScripInfoModel getScripDataModelForCommoFromIsecName(
      {required String exch,
        required String isecName,
        required String expiryDate,
        required bool isOption,
        double? strikePrice,
        bool? isCE,
        String? ulToken,
        bool sendReq = true,
        bool getNseBseMap = false,
        String ltp = '0.00'}) {
    int exchPos = getExchPosISec(exch);
    int intDateFromExpiryDate = DateUtil.getMcxformattedDateFromIsec(expiryDate);
    print("int date => $intDateFromExpiryDate");
    if (exchPos < 0) return ScripInfoModel();
    var model = Dataconstants.exchData[exchPos]!.getStaticCommModelForIsec(
      isecName: isecName,
      expiryDate: intDateFromExpiryDate,
      strikePrice: strikePrice,
      isCall: isCE,
    );

    if (model == null) {
      return ScripInfoModel()
        ..setApiData(
            isecApiName: isecName,
            exchApi: exch,
            exchCategory: isOption ? ExchCategory.mcxOptions : ExchCategory.mcxFutures,
            expiryDate: intDateFromExpiryDate,
            isOPtion: isOption,
            cptype: isCE! ? 3 : 4,
            strikePrice: strikePrice,
            ltp: ltp);
    }
    int scPos = Dataconstants.exchData[exchPos]!.scripPos(model.exchCode!);
    ScripInfoModel finalModel;
    if (scPos < 0) {
      finalModel = ScripInfoModel()..setStaticData(model);
      Dataconstants.exchData[exchPos]!.addModel(finalModel);
      if (getNseBseMap && (model.exchCategory == ExchCategory.nseEquity || model.exchCategory == ExchCategory.bseEquity)) {
        ScripInfoModel? alternateModel = getBseNseMapModel(model.isecName, model.name!, model.exchCategory!);
        if (alternateModel != null) finalModel.addAlternateModel(alternateModel);
      }
    } else {
      finalModel = Dataconstants.exchData[exchPos]!.getModel(scPos);
      if (getNseBseMap && (model.exchCategory == ExchCategory.nseEquity || model.exchCategory == ExchCategory.bseEquity)) {
        ScripInfoModel? alternateModel = getBseNseMapModel(model.isecName, model.name!, model.exchCategory!);
        if (alternateModel != null) finalModel.addAlternateModel(alternateModel);
      }
    }
    if (sendReq) Dataconstants.iqsClient!.sendLTPRequest(finalModel, true);
    return finalModel;
  }

  static ScripInfoModel getScripDataModelForCurrPositionFromIsecName(
      {required String exch,
        required String isecName,
        required String expiryDate,
        required bool isOption,
        double? strikePrice,
        bool? isCE,
        bool? sendReq = true,
        bool? getNseBseMap = false,
        String ltp = '0.00',
        String fromPage = "portfolio"}) {
    // print("exch fro curr ->$exch");
    int exchPos = getExchPosISec(exch);
    // print("exchpos fro curr ->$exchPos");
    if (exchPos < 0) return ScripInfoModel();
    var model = Dataconstants.exchData[exchPos]!.getStaticCurrModelfromIsec(
      isecName: isecName,
      expiryDate: expiryDate.length > 5 ? DateUtil.getIntFromDate(expiryDate) : 0,
      strikePrice: strikePrice,
      isCall: isCE,
    );

    // var model = Dataconstants.exchData[3].getStaticModelForCurrFno(isecName);

    var newIsecName = "";
    if (fromPage == "portfolio" && isOption) {
      // strikePrice = strikePrice / 10000000;
      newIsecName = isecName;
    } else {
      if (isecName.contains("CE") || isecName.contains("PE")) {
        strikePrice = strikePrice! / 10000000;
        newIsecName = isecName;
      } else {
        var replacedDate = expiryDate.replaceAll("-", " ");
        newIsecName = isecName.replaceAll(replacedDate, "").trim();
      }
    }

    if (model == null) {
      // print("-----------");
      // print(
      //     "this is exch  code from currency from isec api  and expiry date  => $exch $expiryDate ${DateUtil.getIntFromDate(expiryDate).toString()}");
      // print('this is currency strike pice => $strikePrice $isOption $isCE');
      // print("-----------");
      if (isOption) {
        strikePrice = strikePrice! / 10000000;
      }
      return ScripInfoModel()
        ..setApiData(
            isecApiName: newIsecName,
            exchApi: exch,
            exchCategory: isOption ? ExchCategory.currenyOptions : ExchCategory.currenyFutures,
            // exchCategory: isCE
            //     ? ExchCategory.currenyOptions
            //     : ExchCategory.currenyFutures,
            expiryDate: expiryDate.length > 5 ? DateUtil.getIntFromDate(expiryDate) : 0,
            isOPtion: isOption,
            cptype: isCE! ? 3 : 0,
            strikePrice: strikePrice,
            ltp: ltp);
    }
    int scPos = Dataconstants.exchData[exchPos]!.scripPos(model.exchCode!);
    ScripInfoModel finalModel;
    if (scPos < 0) {
      finalModel = ScripInfoModel()..setStaticData(model);
      Dataconstants.exchData[exchPos]!.addModel(finalModel);
      if (getNseBseMap! && (model.exchCategory == ExchCategory.nseEquity || model.exchCategory == ExchCategory.bseEquity)) {
        ScripInfoModel? alternateModel = getBseNseMapModel(model.isecName, model.name!, model.exchCategory!);
        if (alternateModel != null) finalModel.addAlternateModel(alternateModel);
      }
    } else {
      // var newIsecName = "";
      // if (isecName.contains("CE") || isecName.contains("PE")) {
      //   strikePrice = strikePrice / 10000000;
      //   newIsecName = isecName;
      // } else {
      //   var replacedDate = expiryDate.replaceAll("-", " ");
      //   newIsecName = isecName.replaceAll(replacedDate, "").trim();
      // }

      finalModel = Dataconstants.exchData[exchPos]!.getModel(scPos);
      if (getNseBseMap! && (model.exchCategory == ExchCategory.nseEquity || model.exchCategory == ExchCategory.bseEquity)) {
        ScripInfoModel? alternateModel = getBseNseMapModel(model.isecName, model.name!, model.exchCategory!);
        if (alternateModel != null) finalModel.addAlternateModel(alternateModel);
      }
    }
    if (sendReq!) Dataconstants.iqsClient!.sendLTPRequest(finalModel, true);
    return finalModel;
  }

  static ScripInfoModel getDefaltScripDataModelForFlashTarde(
      {required String exch,
        required String isecName,
        // @required String expiryDate,
        // @required bool isOption,
        // double strikePrice,
        bool? isCE,
        bool sendReq = true,
        bool getNseBseMap = false,
        String ltp = '0.00'}) {
    int exchPos = getExchPosISec(exch);
    if (exchPos < 0) return ScripInfoModel();
    var model = Dataconstants.exchData[exchPos]!.getStaticFOModelForFlashTrade(
      // des:des,
      isecName: isecName,
      // expiryDate: DateUtil.getIntFromDate(expiryDate),
      // expiryDate2:expiryDate2,
      // strikePrice: strikePrice,
      // isCall: isCE,
    );
    if (model == null) {
      // print("this is exch code from api => $exch");
      // print('this is fno strike pice => $strikePrice $isOption $isCE');
      return ScripInfoModel()
        ..setFlashTradeData(
            isecApiName: isecName,
            exchApi: exch,
            exchCategory: ExchCategory.nseFuture,
            // expiryDate: DateUtil.getIntFromDate(expiryDate),
            isOPtion: false,
            cptype: 0,
            // strikePrice: strikePrice,
            ltp: ltp);
    }
    int scPos = Dataconstants.exchData[exchPos]!.scripPos(model.exchCode!);
    ScripInfoModel finalModel;
    if (scPos < 0) {
      finalModel = ScripInfoModel()..setStaticData(model);
      Dataconstants.exchData[exchPos]!.addModel(finalModel);
      if (getNseBseMap && (model.exchCategory == ExchCategory.nseEquity || model.exchCategory == ExchCategory.bseEquity)) {
        ScripInfoModel? alternateModel = getBseNseMapModelForFlashTrade(model.name!, model.name!, model.exchCategory!);
        if (alternateModel != null) finalModel.addAlternateModel(alternateModel);
      }
    } else {
      finalModel = Dataconstants.exchData[exchPos]!.getModel(scPos);
      if (getNseBseMap && (model.exchCategory == ExchCategory.nseEquity || model.exchCategory == ExchCategory.bseEquity)) {
        ScripInfoModel? alternateModel = getBseNseMapModelForFlashTrade(model.name!, model.name!, model.exchCategory!);
        if (alternateModel != null) finalModel.addAlternateModel(alternateModel);
      }
    }
    if (sendReq) Dataconstants.iqsClient!.sendLTPRequest(finalModel, true);
    return finalModel;
  }

  static ScripInfoModel getScripDataModelForFnoFromIsecName(
      {required String exch,
        required String isecName,
        required String expiryDate,
        required bool isOption,
        double? strikePrice,
        bool? isCE,
        bool sendReq = true,
        bool getNseBseMap = false,
        String ltp = '0.00',
        String? des,
        String? expiryDate2}) {
    int exchPos = getExchPosISec(exch);
    if (exchPos < 0) return ScripInfoModel();
    var model = Dataconstants.exchData[exchPos]!.getStaticFOModelForIsec(
      des: des,
      isecName: isecName,
      expiryDate: DateUtil.getIntFromDate(expiryDate),
      expiryDate2: expiryDate2!,
      strikePrice: strikePrice,
      isCall: isCE,
    );
    if (model == null) {
      // print("this is exch code from api => $exch");
      // print('this is fno strike pice => $strikePrice $isOption $isCE');
      return ScripInfoModel()
        ..setApiData(
            isecApiName: isecName,
            exchApi: exch,
            exchCategory: isOption ? ExchCategory.nseOptions : ExchCategory.nseFuture,
            expiryDate: DateUtil.getIntFromDate(expiryDate),
            isOPtion: isOption,
            cptype: isCE! ? 3 : 4,
            strikePrice: strikePrice,
            ltp: ltp);
    }
    int scPos = Dataconstants.exchData[exchPos]!.scripPos(model.exchCode!);
    ScripInfoModel finalModel;
    if (scPos < 0) {
      finalModel = ScripInfoModel()..setStaticData(model);
      Dataconstants.exchData[exchPos]!.addModel(finalModel);
      if (getNseBseMap && (model.exchCategory == ExchCategory.nseEquity || model.exchCategory == ExchCategory.bseEquity)) {
        ScripInfoModel? alternateModel = getBseNseMapModel(model.isecName, model.name!, model.exchCategory!);
        if (alternateModel != null) finalModel.addAlternateModel(alternateModel);
      }
    } else {
      finalModel = Dataconstants.exchData[exchPos]!.getModel(scPos);
      if (getNseBseMap && (model.exchCategory == ExchCategory.nseEquity || model.exchCategory == ExchCategory.bseEquity)) {
        ScripInfoModel? alternateModel = getBseNseMapModel(model.isecName, model.name!, model.exchCategory!);
        if (alternateModel != null) finalModel.addAlternateModel(alternateModel);
      }
    }
    if (sendReq) Dataconstants.iqsClient!.sendLTPRequest(finalModel, true);
    return finalModel;
  }

  static ScripInfoModel getScripDataModelForCurrFromIsecName(
      {required String exch,
        required String isecName,
        required String expiryDate,
        required bool isOption,
        double? strikePrice,
        bool? isCE,
        bool sendReq = true,
        bool getNseBseMap = false,
        String ltp = '0.00',
        String? underlying,
        String? fromPage}) {
    // print("exch fro curr ->$exch");
    int exchPos = getExchPosISec(exch);
    // print("exchpos fro curr ->$exchPos");
    if (exchPos < 0) return ScripInfoModel();
    var model;
    if (fromPage == "openposition") {
      if (isOption) {
        strikePrice = strikePrice! / 10000000;
      }
      // model = Dataconstants.exchData[3].getStaticModelForCurrFno(isecName);
      model = Dataconstants.exchData[exchPos]!.getStaticCurrModelfromIsec(
        isecName: isecName,
        expiryDate: expiryDate.length > 5 ? DateUtil.getIntFromDate(expiryDate) : 0,
        strikePrice: strikePrice,
        isCall: isCE,
      );
    } else if (fromPage == "research") {
      // if (isOption) {
      //   strikePrice = strikePrice / 10000000;
      // }

      model = Dataconstants.exchData[exchPos]!.getStaticCurrModelfromIsec(
        isecName: underlying!,
        expiryDate: expiryDate.length > 5 ? DateUtil.getIntFromDate(expiryDate) : 0,
        strikePrice: strikePrice,
        isCall: isCE,
      );
    } else {
      if (isOption) {
        strikePrice = strikePrice! / 10000000;
      }

      model = Dataconstants.exchData[exchPos]!.getStaticCurrModelfromIsec(
        isecName: underlying!,
        expiryDate: expiryDate.length > 5 ? DateUtil.getIntFromDate(expiryDate) : 0,
        strikePrice: strikePrice,
        isCall: isCE,
      );
    }
    // model = Dataconstants.exchData[3].getStaticModelForCurrFno(isecName);

    if (model == null) {
      // print("-----------");
      // print(
      //     "this is exch  code from currency from isec api  and expiry date  => $exch $expiryDate ${DateUtil.getIntFromDate(expiryDate).toString()}");
      // print('this is currency strike pice => $strikePrice $isOption $isCE');
      // print("-----------");
      var newIsecName = "";
      if (fromPage == "openposition" && isOption) {
        // strikePrice = strikePrice / 10000000;
        newIsecName = isecName;
      } else {
        if (isecName.contains("CE") || isecName.contains("PE")) {
          strikePrice = strikePrice! / 10000000;
          newIsecName = underlying!;
        } else {
          var replacedDate = expiryDate.replaceAll("-", " ");
          newIsecName = isecName.replaceAll(replacedDate, "").trim();
        }
      }

      return ScripInfoModel()
        ..setApiData(
            isecApiName: newIsecName,
            exchApi: exch,
            exchCategory: isCE! ? ExchCategory.currenyOptions : ExchCategory.currenyFutures,
            // exchCategory: isOption
            //     ? ExchCategory.currenyOptions
            //     : ExchCategory.currenyFutures,
            expiryDate: expiryDate.length > 5 ? DateUtil.getIntFromDate(expiryDate) : 0,
            isOPtion: isOption,
            cptype: isCE! ? 3 : 0,
            strikePrice: strikePrice,
            ltp: ltp);
    }
    int scPos = Dataconstants.exchData[exchPos]!.scripPos(model.exchCode);
    ScripInfoModel finalModel;
    if (scPos < 0) {
      finalModel = ScripInfoModel()..setStaticData(model);
      Dataconstants.exchData[exchPos]!.addModel(finalModel);
      if (getNseBseMap && (model.exchCategory == ExchCategory.nseEquity || model.exchCategory == ExchCategory.bseEquity)) {
        ScripInfoModel? alternateModel = getBseNseMapModel(model.isecName, model.name, model.exchCategory);
        if (alternateModel != null) finalModel.addAlternateModel(alternateModel);
      }
    } else {
      finalModel = Dataconstants.exchData[exchPos]!.getModel(scPos);
      if (getNseBseMap && (model.exchCategory == ExchCategory.nseEquity || model.exchCategory == ExchCategory.bseEquity)) {
        ScripInfoModel? alternateModel = getBseNseMapModel(model.isecName, model.name, model.exchCategory);
        if (alternateModel != null) finalModel.addAlternateModel(alternateModel);
      } else {
        ScripInfoModel? alternateModel = getBseNseMapModel(model.isecName, model.name, model.exchCategory);
        if (alternateModel != null) finalModel.addAlternateModel(alternateModel);
      }
    }
    if (sendReq) Dataconstants.iqsClient!.sendLTPRequest(finalModel, true);
    return finalModel;
  }

  static ScripInfoModel getScripDataModelFromIsecName(
      {required String exch,
        required String isecName,
        required String expiryDate,
        bool sendReq = true,
        bool getNseBseMap = false,
        String ltp = '0.00'}) {
    int exchPos = getExchPosISec(exch);
    if (exchPos < 0) return ScripInfoModel();
    int scripPos = Dataconstants.exchData[exchPos]!.scripPosForIsec(isecName) ?? -1;
    if (scripPos < 0) {
      var model = Dataconstants.exchData[exchPos]!.getStaticModelForIsec(isecName);
      if (model == null) {
        return ScripInfoModel()
          ..setApiData(
              isecApiName: isecName,
              exchApi: '',
              isOPtion: false,
              expiryDate: DateUtil.getIntFromDate(DateFormat('dd-MMM-yyyy').format(DateTime.now())),
              cptype: null,
              strikePrice: null,
              ltp: ltp,
              exchCategory: null!);
      }
      ScripInfoModel finalModel = ScripInfoModel()..setStaticData(model);

      Dataconstants.exchData[exchPos]!.addModel(finalModel);
      if (getNseBseMap && (model.exchCategory == ExchCategory.nseEquity || model.exchCategory == ExchCategory.bseEquity)) {
        ScripInfoModel? alternateModel = getBseNseMapModel(model.isecName, model.name!, model.exchCategory!);
        if (alternateModel != null) finalModel.addAlternateModel(alternateModel);
      }
      if (sendReq) Dataconstants.iqsClient!.sendLTPRequest(finalModel, true);
      return finalModel;
    } else {
      var result = Dataconstants.exchData[exchPos]!.getModel(scripPos);

      if (result.alternateModel == null && getNseBseMap && result.exchCategory == ExchCategory.nseEquity ||
          result.exchCategory == ExchCategory.bseEquity) {
        ScripInfoModel? alternateModel = getBseNseMapModel(result.isecName, result.name, result.exchCategory!);
        if (alternateModel != null) result.addAlternateModel(alternateModel);
      }
      if (sendReq) Dataconstants.iqsClient!.sendLTPRequest(result, true);
      return result;
    }
  }

  static ScripInfoModel getAlgoScripDataModelFromIsecName({
    required String exch,
    required String isecName,
    required int exchCode,
    required String exchType,
    bool sendReq = true,
    bool getNseBseMap = false,
  }) {
    // int exchPos = getExchPosISec(exch);
    int exchPos = getExchPosForAlgo(exch, exchType)!;
    if (exchPos < 0) return ScripInfoModel();
    int scripPos = Dataconstants.exchData[exchPos]!.scripPos(exchCode) ?? -1;
    if (scripPos < 0) {
      var model = Dataconstants.exchData[exchPos]!.getStaticModel(exchCode);
      if (model == null) {
        // print("this is exch code from api => $exch");
        return ScripInfoModel()
          ..setApiData(
            isecApiName: isecName,
            exchApi: '',
            isOPtion: false,
            expiryDate: DateUtil.getIntFromDate(DateFormat('dd-MMM-yyyy').format(DateTime.now())),
            cptype: null,
            strikePrice: null,
            exchCategory: null!,
          );
      }
      ScripInfoModel finalModel = ScripInfoModel()..setStaticData(model);

      Dataconstants.exchData[exchPos]!.addModel(finalModel);
      if (getNseBseMap && (model.exchCategory == ExchCategory.nseEquity || model.exchCategory == ExchCategory.bseEquity)) {
        ScripInfoModel? alternateModel = getBseNseMapModel(model.isecName, model.name!, model.exchCategory!);
        if (alternateModel != null) finalModel.addAlternateModel(alternateModel);
      }
      if (sendReq) Dataconstants.iqsClient!.sendLTPRequest(finalModel, true);
      return finalModel;
    } else {
      var result = Dataconstants.exchData[exchPos]!.getModel(scripPos);

      if (result.alternateModel == null && getNseBseMap && result.exchCategory == ExchCategory.nseEquity ||
          result.exchCategory == ExchCategory.bseEquity) {
        ScripInfoModel? alternateModel = getBseNseMapModel(result.isecName, result.name, result.exchCategory!);
        if (alternateModel != null) result.addAlternateModel(alternateModel);
      }
      if (sendReq) Dataconstants.iqsClient!.sendLTPRequest(result, true);
      // log("Algo running model => $result");
      return result;
    }
  }

  static void getOICalculation() async {
    try {
      Dataconstants.Derivlist.clear();
      var members = await CommonFunction.getMembers("P", "P0001");
      List<ScripInfoModel> scripListDerivatives = [];
      ScripInfoModel underlyingModel;
      List<ScripInfoModel> futures;
      for (var i = 0; i < members.length; i++) {
        scripListDerivatives.add(CommonFunction.getScripDataModel(exch: "N", exchCode: members[i].exchCode!, sendReq: false)!);
      }
      for (int i = 0; i < scripListDerivatives.length; i++) {
        if (scripListDerivatives[i].exchCategory == ExchCategory.nseFuture)
          underlyingModel = scripListDerivatives[i];
        else
          underlyingModel =
          CommonFunction.getScripDataModel(exch: scripListDerivatives[i].exch, exchCode: scripListDerivatives[i].exchCode, sendReq: false)!;
        futures = Dataconstants.exchData[1]!.getFutureModels(underlyingModel);
        Dataconstants.optionDates = Dataconstants.exchData[1]!.getDatesForOptions(underlyingModel);
        Dataconstants.iqsClient!.sendLTPRequest(futures[0], true);
        Dataconstants.Derivlist.add(ScannerDeriv(model: underlyingModel, futures: futures, optionDates: Dataconstants.optionDates!));
      }

      for (int i = 0; i < Dataconstants.Derivlist.length; i++) {
        Dataconstants.optionDatesTemp =
        await Dataconstants.Derivlist[i].optionDates!.map((e) => DateUtil.getDateWithFormat(e, 'dd MMM yyyy')).toList();
      }
    } catch (e, s) {
      print(e);
    }
  }

  static ScripInfoModel? getScripDataModel({
    required String exch,
    required int exchCode,
    bool sendReq = true,
    bool getNseBseMap = false,
    int getChartDataTime = 0,
  }) {
    int counter = 0;
    var fmt = DateFormat('dd-MMM-yyyy');
    var fmt1 = DateFormat('dd-MMM-yyyy HH:mm:ss');
    // print(fmt.format(DateTime.now()));
    var fmtdate = fmt.format(DateTime.now().subtract(Duration(days: 1)));
    String openDate = fmtdate + ' 09:15:00';
    int exchPos = getExchPosOnCode(exch, exchCode);
    if (exchPos < 0) return ScripInfoModel();
    int scripPos = Dataconstants.exchData[exchPos]!.scripPos(exchCode);
    if (scripPos < 0) {
      var model = Dataconstants.exchData[exchPos]!.getStaticModel(exchCode);
      if (model == null) return ScripInfoModel();
      ScripInfoModel finalModel = ScripInfoModel()..setStaticData(model);

      Dataconstants.exchData[exchPos]!.addModel(finalModel);
      if (getNseBseMap && (model.exchCategory == ExchCategory.nseEquity || model.exchCategory == ExchCategory.bseEquity)) {
        ScripInfoModel? alternateModel = getBseNseMapModel(model.isecName, model.name!, model.exchCategory!);
        if (alternateModel != null) finalModel.addAlternateModel(alternateModel);
      }
      if (sendReq) Dataconstants.iqsClient!.sendLTPRequest(finalModel, true);
      if (getChartDataTime > 0) Dataconstants.itsClient.getChartData(timeInterval: getChartDataTime, chartPeriod: "I", model: finalModel);
      return finalModel;
    } else {
      var result = Dataconstants.exchData[exchPos]!.getModel(scripPos);

      if (result.alternateModel == null && getNseBseMap && result.exchCategory == ExchCategory.nseEquity ||
          result.exchCategory == ExchCategory.bseEquity) {
        ScripInfoModel? alternateModel = getBseNseMapModel(result.isecName, result.name, result.exchCategory!);
        if (alternateModel != null) result.addAlternateModel(alternateModel);
      }
      if (sendReq) Dataconstants.iqsClient!.sendLTPRequest(result, true);
      if (getChartDataTime > 0)
        result.getChartData(
          timeInterval: getChartDataTime,
          chartPeriod: "I",
        );
      return result;
    }
  }

  static ScripInfoModel? getBseNseMapModel(String isecName, String name, ExchCategory exchCategory) {
    if (exchCategory != ExchCategory.nseEquity && exchCategory != ExchCategory.bseEquity) return null;
    ScripInfoModel? resultModel;
    ScripStaticModel? staticModel;
    if (exchCategory == ExchCategory.nseEquity)
      staticModel = Dataconstants.exchData[2]!.getStaticModelFromName(name, exchCategory, isecName);
    else
      staticModel = Dataconstants.exchData[0]!.getStaticModelFromName(name, exchCategory, isecName);
    if (staticModel == null) return null;
    resultModel = ScripInfoModel()..setStaticData(staticModel);

    int exchPos = getExchPosOnCode(resultModel.exch, resultModel.exchCode);
    if (exchPos < 0) return null;
    int scripPos = Dataconstants.exchData[exchPos]!.scripPos(resultModel.exchCode);
    if (scripPos < 0) {
      Dataconstants.exchData[exchPos]!.addModel(resultModel);
      return resultModel;
    } else
      return Dataconstants.exchData[exchPos]!.getModel(scripPos);
  }

  static ScripInfoModel? getBseNseMapModelForFlashTrade(String isecName, String name, ExchCategory exchCategory) {
    // if (exchCategory != ExchCategory.nseEquity &&
    //     exchCategory != ExchCategory.bseEquity) return null;
    ScripInfoModel resultModel;
    ScripStaticModel? staticModel;
    if (exchCategory == ExchCategory.nseEquity)
      staticModel = Dataconstants.exchData[2]!.getStaticModelFromName(name, exchCategory, isecName)!;
    else
      staticModel = Dataconstants.exchData[1]!.getStaticModelFromNameForFlashTrade(name, exchCategory, isecName);
    if (staticModel == null) return null;
    resultModel = ScripInfoModel()..setStaticData(staticModel);

    int exchPos = getExchPosOnCode(resultModel.exch, resultModel.exchCode);
    if (exchPos < 0) return null;
    int scripPos = Dataconstants.exchData[exchPos]!.scripPos(resultModel.exchCode);
    if (scripPos < 0) {
      Dataconstants.exchData[exchPos]!.addModel(resultModel);
      return resultModel;
    } else
      return Dataconstants.exchData[exchPos]!.getModel(scripPos);
  }

  static String makeDerivDesc(dynamic reply, String exch) {
    String result;
    if (exch == 'M')
      result =
      '${reply.scripName.getValue().substring(0, reply.scripNameLength.getValue())} ${DateUtil.getAnyFormattedExchDateMCX(reply.expiryDate.getValue(), "dd MMM yyyy")}';
    else
      result =
      '${reply.scripName.getValue().substring(0, reply.scripNameLength.getValue())} ${DateUtil.getAnyFormattedExchDate(reply.expiryDate.getValue(), "dd MMM yyyy")}';
    if (reply.cpType.getValue() > 0) {
      if (exch == 'C')
        result += ' ${Dataconstants.array_option_type[reply.cpType.getValue()]} ${reply.strikePrice.getValue().toStringAsFixed(4)}';
      else
        result += ' ${Dataconstants.array_option_type[reply.cpType.getValue()]} ${reply.strikePrice.getValue().toStringAsFixed(2)}';
    }
    return result;
  }

  static bool isIndicesScrip(String exch, int exchCode) {
    if ((exch == 'N' && exchCode >= Dataconstants.nseCashIndexCodeStart && exchCode <= Dataconstants.nseCashIndexCodeEnd) ||
        (exch == 'B' && exchCode >= Dataconstants.bseCashIndexCodeStart && exchCode <= Dataconstants.bseCashIndexCodeEnd))
      return true;
    else
      return false;
  }

  static bool rateWithin(double low, double high, double check) {
    int high1, low1, check1;
    bool result = false;

    low1 = (low * 100).round();
    high1 = (high * 100).round();
    check1 = (check * 100).round();
    result = false;
    if ((low1 <= check1) && (check1 <= high1)) result = true;
    return result;
  }

  static List<ScripInfoModel> getIndices({
    required int indicesMode,
    String searchText = '',
    bool sendRequest = true,
    int getChartDataTime = 0,
  }) {
    //0-all,1-nse,2-bse
    List<ScripInfoModel> finalNseList = [], finalBseList = [];
    if (indicesMode == 0 || indicesMode == 1) {
      finalNseList = Dataconstants.exchData[0]!.getNseIndices(searchText).map((e) {
        int pos = Dataconstants.exchData[0]!.scripPos(e.exchCode!);
        if (pos < 0) {
          ScripInfoModel finalModel = ScripInfoModel()..setStaticData(e);
          Dataconstants.exchData[0]!.addModel(finalModel);
          if (sendRequest) Dataconstants.iqsClient!.sendLTPRequest(finalModel, true);
          if (getChartDataTime > 0) Dataconstants.itsClient.getChartData(timeInterval: getChartDataTime, chartPeriod: "I", model: finalModel);
          return finalModel;
        } else {
          var model = Dataconstants.exchData[0]!.getModel(pos);
          if (sendRequest) Dataconstants.iqsClient!.sendLTPRequest(model, true);
          if (getChartDataTime > 0) Dataconstants.itsClient.getChartData(timeInterval: getChartDataTime, chartPeriod: "I", model: model);
          return model;
        }
      }).toList();
    }
    if (indicesMode == 0 || indicesMode == 2) {
      finalBseList = Dataconstants.exchData[2]!.getBseIndices(searchText).map((e) {
        int pos = Dataconstants.exchData[2]!.scripPos(e.exchCode!);
        if (pos < 0) {
          ScripInfoModel finalModel = ScripInfoModel()..setStaticData(e);
          Dataconstants.exchData[2]!.addModel(finalModel);
          if (sendRequest) Dataconstants.iqsClient!.sendLTPRequest(finalModel, true);
          if (getChartDataTime > 0) Dataconstants.itsClient.getChartData(timeInterval: getChartDataTime, chartPeriod: "I", model: finalModel);
          return finalModel;
        } else {
          var model = Dataconstants.exchData[2]!.getModel(pos);
          if (sendRequest) Dataconstants.iqsClient!.sendLTPRequest(model, true);
          if (getChartDataTime > 0) Dataconstants.itsClient.getChartData(timeInterval: getChartDataTime, chartPeriod: "I", model: model);
          return model;
        }
      }).toList();
    }
    return finalNseList + finalBseList;
  }

  static List<ScripInfoModel> getMutualFund({
    String searchText = '',
  }) {
    //0-all,1-nse,2-bse
    List<ScripInfoModel> mutualfundlist = [];
    mutualfundlist = Dataconstants.exchData[8]!.getMutualFund(searchText).map((e) {
      ScripInfoModel finalModel = ScripInfoModel()..setStaticDataMF(e);
      Dataconstants.exchData[8]!.addMFModel(finalModel);
      return finalModel;
    }).toList();
    return mutualfundlist;
  }

  static List<GroupData> getGroup(String grType, String searchText) {
    if (searchText.isEmpty)
      return Dataconstants.groupData.where((element) => element.grType == grType).toList();
    else
      return Dataconstants.groupData.where((element) => element.grType == grType && element.grName!.toLowerCase().contains(searchText)).toList();
  }

  static List<MemberData> getMembers(String grType, String grCode) =>
      Dataconstants.memberData.where((element) => element.grType == grType && element.grCode == grCode).toList();

  static String getGroupName(String grType, String grCode) =>
      Dataconstants.groupData.firstWhere((element) => element.grType == grType && element.grCode == grCode).grName!;

  static ExchCategory getExchCategory(String exch, int exchCode, [int cpType = 0]) {
    try {
      if (exch == 'C') {
        if (cpType == 0)
          return ExchCategory.currenyFutures;
        else
          return ExchCategory.currenyOptions;
      } else if (exch == 'M') {
        if (cpType == 0)
          return ExchCategory.mcxFutures;
        else
          return ExchCategory.mcxOptions;
      } else if (exch == 'E') {
        if (cpType == 0)
          return ExchCategory.bseCurrenyFutures;
        else
          return ExchCategory.bseCurrenyOptions;
      } else if (exch == 'B')
        return ExchCategory.bseEquity;
      else if (isEquity(exchCode))
        return ExchCategory.nseEquity;
      else if (cpType == 0)
        return ExchCategory.nseFuture;
      else
        return ExchCategory.nseOptions;
    } catch (e) {
      // print(e);
    }
    return ExchCategory.nseEquity;
  }

  static bool isEquity(int exchCode) {
    if ((exchCode > 0 && exchCode < 34999) || (exchCode >= 888801 && exchCode < 888820)) return true;
    return false;
  }

  static void reconnect() {
    try {
      Dataconstants.iqsClient!.disconnect();
      Dataconstants.newsClient!.disconnect();
      Dataconstants.iqsClient!.iqsReconnect = true;
      Dataconstants.iqsClient!.connect();
      Dataconstants.newsClient!.connect();
    } catch (e) {
      // print(e);
    }
  }

  static void saveRecentSearchData() async {
    if (Dataconstants.recentSearchQueries.length > 0) {
      GetStorageData.write('recentSearchQueries', Dataconstants.recentSearchQueries);
    }
    if (Dataconstants.recentViewedScrips.length > 0) {
      await GetStorageData.write(
        'recentSearchScripsExch',
        Dataconstants.recentViewedScrips.map((e) => e.exch).toList(),
      );
      await GetStorageData.write(
        'recentSearchScripsCode',
        Dataconstants.recentViewedScrips.map((e) => e.exchCode.toString()).toList(),
      );
    }
  }

  static bool isTradingAllowed(ExchCategory category) {
    if (!Dataconstants.accountInfo[Dataconstants.currentSelectedAccount].allowTrading!) {
      CommonFunction.showBasicToast('Trading is disabled for this account.');
      return false;
    }
    switch (category) {
      case ExchCategory.nseEquity:
      case ExchCategory.bseEquity:
        if (!Dataconstants.accountInfo[Dataconstants.currentSelectedAccount].allowNseCash!) {
          CommonFunction.showBasicToast('Trading in Equity segment is disabled for this account.');
          return false;
        }
        break;
      case ExchCategory.nseFuture:
      case ExchCategory.nseOptions:
        if (!Dataconstants.accountInfo[Dataconstants.currentSelectedAccount].allowNseDeriv!) {
          CommonFunction.showBasicToast('Trading in F&O segment is disabled for this account.');
          return false;
        }
        break;
      case ExchCategory.currenyFutures:
      case ExchCategory.currenyOptions:
      case ExchCategory.bseCurrenyFutures:
      case ExchCategory.bseCurrenyOptions:
        if (!Dataconstants.accountInfo[Dataconstants.currentSelectedAccount].allowNseCurr!) {
          CommonFunction.showBasicToast('Trading in Currency segment is disabled for this account.');
          return false;
        }
        break;
      case ExchCategory.mcxFutures:
      case ExchCategory.mcxOptions:
        return true;
      default:
        return true;
    }
    return true;
  }

  static void startupTasks() async {
    if (Dataconstants.indicesListener != null) Dataconstants.indicesListener = IndicesListener();
    Dataconstants.indicesListener!.getIndicesFromPref();
    for (var list in Dataconstants.marketWatchListeners) list.loadMarketwatchListener();
    Dataconstants.predefinedMarketWatchListener.loadMarketwatchListener();
    Dataconstants.indicesMarketWatchListener.loadMarketwatchListener();
    Dataconstants.summaryMarketWatchListener.loadMarketwatchListener();
    Dataconstants.mutualFundsMarketWatchListener.loadMarketwatchListener();

    var searchQueries = GetStorageData.read('recentSearchQueries');
    if (searchQueries != null) Dataconstants.recentSearchQueries = searchQueries;
    var recentSearchScripsExch = GetStorageData.read('recentSearchScripsExch');
    var recentSearchScripsCode = GetStorageData.read('recentSearchScripsCode');
    if (recentSearchScripsExch != null && recentSearchScripsCode != null) {
      for (int i = 0; i < recentSearchScripsCode.length; i++) {
        int? scripCode = int.tryParse(recentSearchScripsCode[i]);
        if (scripCode != null)
          Dataconstants.recentViewedScrips.add(
            CommonFunction.getScripDataModel(
              exch: recentSearchScripsExch[i],
              exchCode: scripCode,
              sendReq: false,
            )!,
          );
      }
    }
  }

  static void firebaseCrash(e, s) {
    try {
      FirebaseCrashlytics.instance.recordError(e, s);
    } catch (e, s) {}
  }

  static void logOut(bool sessionTimedOut, bool isManualLoggedOut) async {
    try {
      BrokerInfo.isManuallyLogout = true;

      for (int i = 0; i < Dataconstants.marketWatchListeners.length; i++) {
        Dataconstants.marketWatchListeners[i].removeBulkFromWatchList();
      }

      Dataconstants.iqsFreshConnection = true;
      Dataconstants.itsFreshConnection = true;
      Dataconstants.eodFreshConnection = true;
      Dataconstants.newsFreshConnection = true;
      BrokerInfo.encryption = '';
      Dataconstants.iqsClient!.disconnect();

      Dataconstants.newsClient!.disconnect();
      Dataconstants.loginMode = 2;
      Dataconstants.navigatorKey.currentState!.pushReplacement(
        //NewLogin
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => NewLogin(),
          // pageBuilder: (_, __, ___) => LoginPage(),
          transitionDuration: Duration(seconds: 0),
        ),
      );
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
    }
  }

  static Future<bool?> showAlert(BuildContext context, String title, String msg, [String buttonText = 'OK', bool dismissible = true]) {
    return showDialog<bool>(
        barrierDismissible: dismissible,
        context: context,
        builder: (BuildContext context) {
          var theme = Theme.of(context);
          return Platform.isIOS
              ? CupertinoAlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: Text(msg, style: TextStyle(fontSize: 18), textAlign: TextAlign.left),
            ),
            //content: ChangelogScreen(),
            actions: <Widget>[
              TextButton(
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: theme.primaryColor,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          )
              : AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: Text(
                msg,
                style: TextStyle(fontSize: 18),
              ),
            ),
            //content: ChangelogScreen(),
            actions: <Widget>[
              TextButton(
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: theme.primaryColor,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
  }

  static Map<String, List<ScripStaticModel>> globalSearch(String scrip) {
    Map<String, List<ScripStaticModel>> stockItems = {'All': [], 'Cash': [], 'FO': [], 'Currency': [], 'Commodity': []};
    var tempQuery = scrip.split(' ');
    String specialSearch = '';

    for (int i = tempQuery.length - 1; i >= 0; i--) {
      if (tempQuery[i].length == 0) continue;
      if (tempQuery[i].toLowerCase() == "fut" || tempQuery[i].toLowerCase() == "future" || tempQuery[i].toLowerCase() == "futures") {
        specialSearch = "fut";
        tempQuery.removeAt(i);
        break;
      }
      if (tempQuery[i].toLowerCase() == "futidx") {
        specialSearch = "futidx";
        tempQuery.removeAt(i);
        break;
      }
      if (tempQuery[i].toLowerCase() == "futstk") {
        specialSearch = "futstk";
        tempQuery.removeAt(i);
        break;
      } else if (tempQuery[i].toLowerCase() == "option" || tempQuery[i].toLowerCase() == "opt" || tempQuery[i].toLowerCase() == "options") {
        specialSearch = "opt";
        tempQuery.removeAt(i);
        break;
      } else if (tempQuery[i].toLowerCase() == "curr" || tempQuery[i].toLowerCase() == "currency") {
        specialSearch = "curr";
        tempQuery.removeAt(i);
        break;
      } else if (tempQuery[i].toLowerCase() == "optstk") {
        specialSearch = "optstk";
        tempQuery.removeAt(i);
        break;
      } else if (tempQuery[i].toLowerCase() == "optidx") {
        specialSearch = "optidx";
        tempQuery.removeAt(i);
        break;
      } else if (tempQuery[i].toLowerCase() == "eq" || tempQuery[i].toLowerCase() == "equity") {
        specialSearch = "eq";
        tempQuery.removeAt(i);
        break;
      } else if (tempQuery[i].toLowerCase() == "nse") {
        specialSearch = "nse";
        tempQuery.removeAt(i);
        break;
      } else if (tempQuery[i].toLowerCase() == "bse") {
        specialSearch = "bse";
        tempQuery.removeAt(i);
        break;
      } else if (tempQuery[i].toLowerCase() == "mcx") {
        specialSearch = "mcx";
        tempQuery.removeAt(i);
        break;
      }
    }
    if (specialSearch == "") {
      specialSearch = "all";
    }
    switch (specialSearch) {
      case 'all':
        var resultsNse = Dataconstants.exchData[0]!.findModelsForSearchNse(tempQuery, scrip);
        var resultsBse = Dataconstants.exchData[2]!.findModelsForSearchBse(tempQuery, scrip);
        var eqCombined;
        if (!Dataconstants.isFromAlgo) {
          if (Dataconstants.isFromBasketOrder) {
            // eqCombined = resultsNse['NseEq'];

            eqCombined = zip(
              resultsNse['NseEq']!,
              resultsBse['BseEq']!,
            ).toList();

            List<dynamic> tempList = eqCombined;
            for (int i = 0; i < tempList.length; i++) {
              if (tempList[i].exch == 'N' &&
                  tempList[i].exchCode >= Dataconstants.nseCashIndexCodeStart &&
                  tempList[i].exchCode <= Dataconstants.nseCashIndexCodeEnd) {
                // print("indices condition");
                stockItems['Cash']!.clear();
                stockItems['All']!.clear();
                stockItems['FO']!.clear();
                stockItems['Currency']!.clear();
              }
            }

            stockItems['Cash']!.addAll(eqCombined);
            stockItems['All']!.addAll(eqCombined);
          } else {
            eqCombined = zip(
              resultsNse['NseEq']!,
              resultsBse['BseEq']!,
            ).toList();
            stockItems['Cash']!.addAll(eqCombined);
            stockItems['All']!.addAll(eqCombined);
          }
        }
        // else
        //   // eqCombined = resultsNse['NseEq'];
        //   if (Dataconstants.isFromBasketOrder) {
        //     // eqCombined = resultsNse['NseEq'];
        //
        //     eqCombined = zip(
        //       resultsNse['NseEq'],
        //       resultsBse['BseEq'],
        //     ).toList();
        //
        //     List<dynamic> tempList = eqCombined;
        //     for (int i = 0; i < tempList.length; i++) {
        //       if (tempList[i].exch == 'N' &&
        //           tempList[i].exchCode >= Dataconstants.nseCashIndexCodeStart &&
        //           tempList[i].exchCode <= Dataconstants.nseCashIndexCodeEnd) {
        //         // print("indices condition");
        //         stockItems['Cash'].clear();
        //         stockItems['All'].clear();
        //         stockItems['FO'].clear();
        //         stockItems['Currency'].clear();
        //       } else {
        //         stockItems['Cash'].addAll(eqCombined);
        //         stockItems['All'].addAll(eqCombined);
        //       }
        //     }
        //
        //
        //     // stockItems['Cash'].addAll(eqCombined);
        //     // stockItems['All'].addAll(eqCombined);
        //
        //   }

        else if (Dataconstants.isFromSIP) {
          eqCombined = resultsNse['NseEq'];
          eqCombined = resultsNse['BseEq'];
          List<dynamic> tempList = eqCombined;
          for (int i = 0; i < tempList.length; i++) {
            if (tempList[i].exch == 'N' &&
                tempList[i].exchCode >= Dataconstants.nseCashIndexCodeStart &&
                tempList[i].exchCode <= Dataconstants.nseCashIndexCodeEnd) {
              // print("indices condition");
              stockItems['Cash']!.clear();
              stockItems['All']!.clear();
              stockItems['FO']!.clear();
              stockItems['Currency']!.clear();
            } else if (tempList[i].exch == 'B' &&
                tempList[i].exchCode >= Dataconstants.bseCashIndexCodeStart &&
                tempList[i].exchCode <= Dataconstants.bseCashIndexCodeEnd) {
              // print("indices condition");
              stockItems['Cash']!.clear();
              stockItems['All']!.clear();
              stockItems['FO']!.clear();
              stockItems['Currency']!.clear();
            } else {
              stockItems['Cash']!.addAll(eqCombined);
              stockItems['All']!.addAll(eqCombined);
            }
          }
        } else {
          eqCombined = resultsNse['NseEq'];
          List<dynamic> tempList = eqCombined;
          for (int i = 0; i < tempList.length; i++) {
            if (tempList[i].exch == 'N' &&
                tempList[i].exchCode >= Dataconstants.nseCashIndexCodeStart &&
                tempList[i].exchCode <= Dataconstants.nseCashIndexCodeEnd) {
              // print("indices condition");
              stockItems['Cash']!.clear();
              stockItems['All']!.clear();
              stockItems['FO']!.clear();
              stockItems['Currency']!.clear();
            } else {
              stockItems['Cash']!.addAll(eqCombined);
              stockItems['All']!.addAll(eqCombined);
            }
          }
        }

        var eqRestCombined;
        if (!Dataconstants.isFromAlgo) {
          eqRestCombined = zip(
            resultsNse['NseRest']!,
            resultsBse['BseRest']!,
          ).toList();
        } else if (Dataconstants.isFromSIP) {
          eqRestCombined = resultsNse['NseRest'];
          eqRestCombined = resultsNse['BseRest'];

          List<dynamic> tempList = eqCombined;
          for (int i = 0; i < tempList.length; i++) {
            if (tempList[i].exch == 'N' &&
                tempList[i].exchCode < Dataconstants.nseCashIndexCodeStart &&
                tempList[i].exchCode > Dataconstants.nseCashIndexCodeEnd) {
              // print("indices condition");
              stockItems['Cash']!.clear();
              stockItems['All']!.clear();
              stockItems['FO']!.clear();
              stockItems['Currency']!.clear();
            }
            if (tempList[i].exch == 'B' &&
                tempList[i].exchCode >= Dataconstants.bseCashIndexCodeStart &&
                tempList[i].exchCode <= Dataconstants.bseCashIndexCodeEnd) {
              // print("indices condition");
              stockItems['Cash']!.clear();
              stockItems['All']!.clear();
              stockItems['FO']!.clear();
              stockItems['Currency']!.clear();
            } else {
              // stockItems['Cash'].addAll(eqRestCombined);
              // stockItems['All'].addAll(eqRestCombined);
            }
          }
        } else {
          eqRestCombined = resultsNse['NseRest'];
          List<dynamic> tempList = eqCombined;
          for (int i = 0; i < tempList.length; i++) {
            if (tempList[i].exch == 'N' &&
                tempList[i].exchCode >= Dataconstants.nseCashIndexCodeStart &&
                tempList[i].exchCode <= Dataconstants.nseCashIndexCodeEnd) {
              // print("indices condition");
              stockItems['Cash']!.clear();
              stockItems['All']!.clear();
              stockItems['FO']!.clear();
              stockItems['Currency']!.clear();
            } else {
              stockItems['Cash']!.addAll(eqRestCombined);
              stockItems['All']!.addAll(eqRestCombined);
            }
          }
        }
        // stockItems['Cash'].addAll(eqRestCombined);
        // stockItems['All'].addAll(eqRestCombined);
        if (Dataconstants.isFromSIP) break;

        try {
          var resultsFO = Dataconstants.exchData[1]!.findModelsForSearchFO(tempQuery);
          if (resultsFO['FutIdx']!.length > 0) {
            stockItems['All']!.addAll(resultsFO['FutIdx']!);
            stockItems['FO']!.addAll(resultsFO['FutIdx']!);
          }
          if (resultsFO['FutStx']!.length > 0) {
            stockItems['All']!.addAll(resultsFO['FutStx']!);
            stockItems['FO']!.addAll(resultsFO['FutStx']!);
          }
          if (resultsFO['OptIdx']!.length > 0) {
            stockItems['All']!.addAll(resultsFO['OptIdx']!);
            stockItems['FO']!.addAll(resultsFO['OptIdx']!);
          }
          if (resultsFO['OptStx']!.length > 0) {
            stockItems['FO']!.addAll(resultsFO['OptStx']!);
            stockItems['All']!.addAll(resultsFO['OptStx']!);
          }
        } catch (e) {}

        try {
          var resultsFOBse = Dataconstants.exchData[6]!.findModelsForSearchFO(tempQuery);
          if (resultsFOBse['FutIdx']!.length > 0) {
            stockItems['All']!.addAll(resultsFOBse['FutIdx']!);
            stockItems['FO']!.addAll(resultsFOBse['FutIdx']!);
          }
          if (resultsFOBse['FutStx']!.length > 0) {
            stockItems['All']!.addAll(resultsFOBse['FutStx']!);
            stockItems['FO']!.addAll(resultsFOBse['FutStx']!);
          }
          if (resultsFOBse['OptIdx']!.length > 0) {
            stockItems['All']!.addAll(resultsFOBse['OptIdx']!);
            stockItems['FO']!.addAll(resultsFOBse['OptIdx']!);
          }
          if (resultsFOBse['OptStx']!.length > 0) {
            stockItems['FO']!.addAll(resultsFOBse['OptStx']!);
            stockItems['All']!.addAll(resultsFOBse['OptStx']!);
          }
        } catch (e) {}

        if (Dataconstants.isFromAlgo) break;
        if (Dataconstants.isFromSIP) break;
        var resultsCurr = Dataconstants.exchData[3]!.findModelsForSearchCurrencyFO(tempQuery);
        if (Dataconstants.isFromSIP) break;
        var resultsBseCurr = Dataconstants.exchData[4]!.findModelsForSearchCurrencyFO(tempQuery);
        var currCombined;
        if (Dataconstants.isFromSIP) break;
        if (!Dataconstants.isFromAlgo) {
          currCombined = zip(
            resultsCurr['CurrFut']!,
            resultsBseCurr['CurrFut']!,
          ).toList();
        } else
          currCombined = resultsCurr['CurrFut'];
        stockItems['Currency']!.addAll(currCombined);
        stockItems['All']!.addAll(currCombined);

        var currOptCombined;
        if (Dataconstants.isFromSIP) break;
        if (!Dataconstants.isFromAlgo) {
          currOptCombined = zip(
            resultsCurr['CurrOpt']!,
            resultsBseCurr['CurrOpt']!,
          ).toList();
        } else if (Dataconstants.isFromSIP) break;
        currOptCombined = resultsCurr['CurrOpt'];
        stockItems['Currency']!.addAll(currOptCombined);
        stockItems['All']!.addAll(currOptCombined);
        // if (!Dataconstants.isFromSIP) {
        //   var resultsMCX = Dataconstants.exchData[5].findModelsForSearch(tempQuery);
        //   if (resultsMCX.length > 0) {
        //     stockItems['All'].addAll(resultsMCX);
        //     stockItems['Commodity'].addAll(resultsMCX);
        //   }
        // }
        break;
      case 'eq':
        if (Dataconstants.isFromBasketOrder) break;
        var resultsNse = Dataconstants.exchData[0]!.findModelsForSearchNse(tempQuery, scrip);
        var resultsBse = Dataconstants.exchData[2]!.findModelsForSearchBse(tempQuery, scrip);
        var eqCombined;
        if (!Dataconstants.isFromAlgo) {
          if (Dataconstants.isFromBasketOrder) {
            eqCombined = zip(
              resultsNse['NseEq']!,
              resultsBse['BseEq']!,
            ).toList();
            List<dynamic> tempList = eqCombined;
            for (int i = 0; i < tempList.length; i++) {
              if (tempList[i].exch == 'N' &&
                  tempList[i].exchCode >= Dataconstants.nseCashIndexCodeStart &&
                  tempList[i].exchCode <= Dataconstants.nseCashIndexCodeEnd) {
                stockItems['Cash']!.clear();
                stockItems['All']!.clear();
                stockItems['FO']!.clear();
                stockItems['Currency']!.clear();
              }
            }
          } else {
            eqCombined = zip(
              resultsNse['NseEq']!,
              resultsBse['BseEq']!,
            ).toList();
            stockItems['Cash']!.addAll(eqCombined);
            stockItems['All']!.addAll(eqCombined);
          }
        } else if (Dataconstants.isFromSIP) {
          eqCombined = resultsNse['NseEq'];
          eqCombined = resultsNse['BseEq'];
          List<dynamic> tempList = eqCombined;
          for (int i = 0; i < tempList.length; i++) {
            if (tempList[i].exch == 'N' &&
                tempList[i].exchCode >= Dataconstants.nseCashIndexCodeStart &&
                tempList[i].exchCode <= Dataconstants.nseCashIndexCodeEnd) {
              stockItems['Cash']!.clear();
              stockItems['All']!.clear();
              stockItems['FO']!.clear();
              stockItems['Currency']!.clear();
            }
            if (tempList[i].exch == 'B' &&
                tempList[i].exchCode >= Dataconstants.bseCashIndexCodeStart &&
                tempList[i].exchCode <= Dataconstants.bseCashIndexCodeEnd) {
              stockItems['Cash']!.clear();
              stockItems['All']!.clear();
              stockItems['FO']!.clear();
              stockItems['Currency']!.clear();
            } else {
              // stockItems['Cash'].addAll(eqCombined);
              // stockItems['All'].addAll(eqCombined);
            }
          }
        } else {
          eqCombined = resultsNse['NseEq'];
          List<dynamic> tempList = eqCombined;
          for (int i = 0; i < tempList.length; i++) {
            if (tempList[i].exch == 'N' &&
                tempList[i].exchCode >= Dataconstants.nseCashIndexCodeStart &&
                tempList[i].exchCode <= Dataconstants.nseCashIndexCodeEnd) {
              stockItems['Cash']!.clear();
              stockItems['All']!.clear();
              stockItems['FO']!.clear();
              stockItems['Currency']!.clear();
            } else {
              // stockItems['Cash'].addAll(eqCombined);
              // stockItems['All'].addAll(eqCombined);
            }
          }
        }
        // else
        //   eqCombined = resultsNse['NseEq'];
        // stockItems['Cash'].addAll(eqCombined);
        // stockItems['All'].addAll(eqCombined);

        var eqRestCombined;
        if (!Dataconstants.isFromAlgo) {
          if (Dataconstants.isFromBasketOrder) {
            eqRestCombined = zip(
              resultsNse['NseRest']!,
              resultsBse['BseRest']!,
            ).toList();
            List<dynamic> tempList = eqCombined;
            for (int i = 0; i < tempList.length; i++) {
              if (tempList[i].exch == 'N' &&
                  tempList[i].exchCode >= Dataconstants.nseCashIndexCodeStart &&
                  tempList[i].exchCode <= Dataconstants.nseCashIndexCodeEnd) {
                print("indices condition");
                stockItems['Cash']!.clear();
                stockItems['All']!.clear();
                stockItems['FO']!.clear();
                stockItems['Currency']!.clear();
              }
            }
          } else {
            eqRestCombined = zip(
              resultsNse['NseRest']!,
              resultsBse['BseRest']!,
            ).toList();
            stockItems['Cash']!.addAll(eqRestCombined);
            stockItems['All']!.addAll(eqRestCombined);
          }
        } else if (Dataconstants.isFromSIP) {
          eqRestCombined = resultsNse['NseRest'];
          eqRestCombined = resultsNse['BseRest'];
          List<dynamic> tempList = eqCombined;
          for (int i = 0; i < tempList.length; i++) {
            if (tempList[i].exch == 'N' &&
                tempList[i].exchCode >= Dataconstants.nseCashIndexCodeStart &&
                tempList[i].exchCode <= Dataconstants.nseCashIndexCodeEnd) {
              print("indices condition");
              stockItems['Cash']!.clear();
              stockItems['All']!.clear();
              stockItems['FO']!.clear();
              stockItems['Currency']!.clear();
            }
            if (tempList[i].exch == 'B' &&
                tempList[i].exchCode >= Dataconstants.bseCashIndexCodeStart &&
                tempList[i].exchCode <= Dataconstants.bseCashIndexCodeEnd) {
              print("indices condition");
              stockItems['Cash']!.clear();
              stockItems['All']!.clear();
              stockItems['FO']!.clear();
              stockItems['Currency']!.clear();
            } else {
              // stockItems['Cash'].addAll(eqRestCombined);
              // stockItems['All'].addAll(eqRestCombined);
            }
          }
        } else {
          eqRestCombined = resultsNse['NseRest'];
          List<dynamic> tempList = eqCombined;
          for (int i = 0; i < tempList.length; i++) {
            if (tempList[i].exch == 'N' &&
                tempList[i].exchCode >= Dataconstants.nseCashIndexCodeStart &&
                tempList[i].exchCode <= Dataconstants.nseCashIndexCodeEnd) {
              print("indices condition");
              stockItems['Cash']!.clear();
              stockItems['All']!.clear();
              stockItems['FO']!.clear();
              stockItems['Currency']!.clear();
            } else {
              // stockItems['Cash'].addAll(eqRestCombined);
              // stockItems['All'].addAll(eqRestCombined);
            }
          }
        }

        // else
        //   eqRestCombined = resultsNse['NseRest'];
        // stockItems['Cash'].addAll(eqRestCombined);
        // stockItems['All'].addAll(eqRestCombined);
        break;
      case 'nse eq':
        if (Dataconstants.isFromBasketOrder) break;
        var resultsNse = Dataconstants.exchData[0]!.findModelsForSearchNse(tempQuery, scrip);
        if (resultsNse['NseEq']!.length > 0) {
          // stockItems['All'].addAll(resultsNse['NseEq']);
          // stockItems['Cash'].addAll(resultsNse['NseEq']);

          var eqRestCombined;

          if (!Dataconstants.isFromAlgo) {
            if (resultsNse['NseEq']!.length > 0) {
              stockItems['All']!.addAll(resultsNse['NseEq']!);
              stockItems['Cash']!.addAll(resultsNse['NseEq']!);
            }
          } else {
            eqRestCombined = resultsNse['NseEq'];
            List<dynamic> tempList = eqRestCombined;
            for (int i = 0; i < tempList.length; i++) {
              if (tempList[i].exch == 'N' &&
                  tempList[i].exchCode >= Dataconstants.nseCashIndexCodeStart &&
                  tempList[i].exchCode <= Dataconstants.nseCashIndexCodeEnd) {
                stockItems['Cash']!.clear();
                stockItems['All']!.clear();
              } else {
                // stockItems['Cash'].addAll(eqRestCombined);
                // stockItems['All'].addAll(eqRestCombined);
              }
            }
          }
        }
        if (resultsNse['NseRest']!.length > 0) {
          // stockItems['Cash'].addAll(resultsNse['NseRest']);
          // stockItems['All'].addAll(resultsNse['NseRest']);

          var eqRestCombined;
          if (!Dataconstants.isFromAlgo) {
            if (resultsNse['NseRest']!.length > 0) {
              stockItems['All']!.addAll(resultsNse['NseRest']!);
              stockItems['Cash']!.addAll(resultsNse['NseRest']!);
            }
          } else {
            eqRestCombined = resultsNse['NseRest'];
            List<dynamic> tempList = eqRestCombined;
            for (int i = 0; i < tempList.length; i++) {
              if (tempList[i].exch == 'N' &&
                  tempList[i].exchCode >= Dataconstants.nseCashIndexCodeStart &&
                  tempList[i].exchCode <= Dataconstants.nseCashIndexCodeEnd) {
                stockItems['Cash']!.clear();
                stockItems['All']!.clear();
              } else {
                // stockItems['Cash'].addAll(eqRestCombined);
                // stockItems['All'].addAll(eqRestCombined);
              }
            }
          }
        }
        break;
      case 'bse':
      case 'bse eq':
        if (Dataconstants.isFromAlgo) break;
        if (Dataconstants.isFromBasketOrder) break;
        var resultsBse = Dataconstants.exchData[2]!.findModelsForSearchBse(tempQuery, scrip);
        if (resultsBse['BseEq']!.length > 0) {
          stockItems['All']!.addAll(resultsBse['BseEq']!);
          stockItems['Cash']!.addAll(resultsBse['BseEq']!);
        }
        if (resultsBse['BseRest']!.length > 0) {
          stockItems['Cash']!.addAll(resultsBse['BseRest']!);
          stockItems['All']!.addAll(resultsBse['BseRest']!);
        }
        break;
      case 'nse':
        if (Dataconstants.isFromBasketOrder) break;
        var resultsNse = Dataconstants.exchData[0]!.findModelsForSearchNse(tempQuery, scrip);
        if (resultsNse['NseEq']!.length > 0) {
          if (!Dataconstants.isFromAlgo) {
            // if (resultsNse['NseEq'].length > 0) {
            stockItems['All']!.addAll(resultsNse['NseEq']!);
            stockItems['Cash']!.addAll(resultsNse['NseEq']!);
            // }
          } else {
            var eqRestCombined;
            eqRestCombined = resultsNse['NseEq'];
            List<dynamic> tempList = eqRestCombined;
            for (int i = 0; i < tempList.length; i++) {
              if (tempList[i].exch == 'N' &&
                  tempList[i].exchCode >= Dataconstants.nseCashIndexCodeStart &&
                  tempList[i].exchCode <= Dataconstants.nseCashIndexCodeEnd) {
                stockItems['Cash']!.clear();
                stockItems['All']!.clear();
              } else {
                // stockItems['Cash'].addAll(eqRestCombined);
                // stockItems['All'].addAll(eqRestCombined);
              }
            }
          }
        }
        if (resultsNse['NseRest']!.length > 0) {
          // stockItems['All'].addAll(resultsNse['NseRest']);
          // stockItems['Cash'].addAll(resultsNse['NseRest']);

          if (!Dataconstants.isFromAlgo) {
            // if (resultsNse['NseRest'].length > 0) {
            stockItems['All']!.addAll(resultsNse['NseRest']!);
            stockItems['Cash']!.addAll(resultsNse['NseRest']!);
            // }
          } else {
            var eqRestCombined;
            eqRestCombined = resultsNse['NseRest'];
            List<dynamic> tempList = eqRestCombined;
            for (int i = 0; i < tempList.length; i++) {
              if (tempList[i].exch == 'N' &&
                  tempList[i].exchCode >= Dataconstants.nseCashIndexCodeStart &&
                  tempList[i].exchCode <= Dataconstants.nseCashIndexCodeEnd) {
                stockItems['Cash']!.clear();
                stockItems['All']!.clear();
              }
              // else {
              // stockItems['Cash'].addAll(eqRestCombined);
              // stockItems['All'].addAll(eqRestCombined);
              // }
            }
          }
        }
        if (Dataconstants.isFromSIP) break;
        var resultsFO = Dataconstants.exchData[1]!.findModelsForSearchFO(tempQuery);
        if (resultsFO['FutIdx']!.length > 0) {
          stockItems['All']!.addAll(resultsFO['FutIdx']!);
          stockItems['FO']!.addAll(resultsFO['FutIdx']!);
        }
        if (resultsFO['FutStx']!.length > 0) {
          stockItems['All']!.addAll(resultsFO['FutStx']!);
          stockItems['FO']!.addAll(resultsFO['FutStx']!);
        }
        if (resultsFO['OptIdx']!.length > 0) {
          stockItems['FO']!.addAll(resultsFO['OptIdx']!);
          stockItems['All']!.addAll(resultsFO['OptIdx']!);
        }
        if (resultsFO['OptStx']!.length > 0) {
          stockItems['All']!.addAll(resultsFO['OptStx']!);
          stockItems['FO']!.addAll(resultsFO['OptStx']!);
        }

        // try {
        //   var resultsFOBse = Dataconstants.exchData[6].findModelsForSearchFO(tempQuery);
        //   if (resultsFOBse['FutIdx'].length > 0) {
        //     stockItems['All'].addAll(resultsFOBse['FutIdx']);
        //     stockItems['FO'].addAll(resultsFOBse['FutIdx']);
        //   }
        //   if (resultsFOBse['FutStx'].length > 0) {
        //     stockItems['All'].addAll(resultsFOBse['FutStx']);
        //     stockItems['FO'].addAll(resultsFOBse['FutStx']);
        //   }
        //   if (resultsFOBse['OptIdx'].length > 0) {
        //     stockItems['All'].addAll(resultsFOBse['OptIdx']);
        //     stockItems['FO'].addAll(resultsFOBse['OptIdx']);
        //   }
        //   if (resultsFOBse['OptStx'].length > 0) {
        //     stockItems['FO'].addAll(resultsFOBse['OptStx']);
        //     stockItems['All'].addAll(resultsFOBse['OptStx']);
        //   }
        // } catch (e) {}

        if (Dataconstants.isFromAlgo) break;
        if (Dataconstants.isFromSIP) break;

        var resultsCurr = Dataconstants.exchData[3]!.findModelsForSearchCurrencyFO(tempQuery);
        if (resultsCurr['CurrFut']!.length > 0) {
          stockItems['All']!.addAll(resultsCurr['CurrFut']!);
          stockItems['Currency']!.addAll(resultsCurr['CurrFut']!);
        }
        if (resultsCurr['CurrOpt']!.length > 0) {
          stockItems['All']!.addAll(resultsCurr['CurrOpt']!);
          stockItems['Currency']!.addAll(resultsCurr['CurrOpt']!);
        }
        break;
      case 'fut':
        if (Dataconstants.isFromSIP) break;
        var resultsFO = Dataconstants.exchData[1]!.findModelsForSearchFO(tempQuery);
        if (resultsFO['FutIdx']!.length > 0) {
          stockItems['All']!.addAll(resultsFO['FutIdx']!);
          stockItems['FO']!.addAll(resultsFO['FutIdx']!);
        }
        if (resultsFO['FutStx']!.length > 0) {
          stockItems['All']!.addAll(resultsFO['FutStx']!);
          stockItems['FO']!.addAll(resultsFO['FutStx']!);
        }
        if (Dataconstants.isFromSIP) break;
        var resultsCurr = Dataconstants.exchData[3]!.findModelsForSearchCurrencyFO(tempQuery);
        var resultsBseCurr = Dataconstants.exchData[4]!.findModelsForSearchCurrencyFO(tempQuery);
        final currCombined = zip(
          resultsCurr['CurrFut']!,
          resultsBseCurr['CurrFut']!,
        ).toList();
        stockItems['Currency']!.addAll(currCombined!);
        stockItems['All']!.addAll(currCombined!);
        break;
      case 'futidx':
        if (Dataconstants.isFromSIP) break;
        var resultsFO = Dataconstants.exchData[1]!.findModelsForSearchFO(tempQuery);
        if (resultsFO['FutIdx']!.length > 0) {
          stockItems['All']!.addAll(resultsFO['FutIdx']!);
          stockItems['FO']!.addAll(resultsFO['FutIdx']!);
        }

        break;
      case 'futstx':
        if (Dataconstants.isFromSIP) break;
        var resultsFO = Dataconstants.exchData[1]!.findModelsForSearchFO(tempQuery);
        if (resultsFO['FutStx']!.length > 0) {
          stockItems['All']!.addAll(resultsFO['FutStx']!);
          stockItems['FO']!.addAll(resultsFO['FutStx']!);
        }

        break;
      case 'opt':
        if (Dataconstants.isFromSIP) break;
        var resultsFO = Dataconstants.exchData[1]!.findModelsForSearchFO(tempQuery);
        if (resultsFO['OptIdx']!.length > 0) {
          stockItems['All']!.addAll(resultsFO['OptIdx']!);
          stockItems['FO']!.addAll(resultsFO['OptIdx']!);
        }
        if (resultsFO['OptStx']!.length > 0) {
          stockItems['All']!.addAll(resultsFO['OptStx']!);
          stockItems['FO']!.addAll(resultsFO['OptStx']!);
        }
        if (Dataconstants.isFromAlgo) break;
        if (Dataconstants.isFromSIP) break;
        var resultsCurr = Dataconstants.exchData[3]!.findModelsForSearchCurrencyFO(tempQuery);
        if (Dataconstants.isFromSIP) break;
        var resultsBseCurr = Dataconstants.exchData[4]!.findModelsForSearchCurrencyFO(tempQuery);
        var currOptCombined;
        if (!Dataconstants.isFromAlgo) {
          currOptCombined = zip(
            resultsCurr['CurrOpt']!,
            resultsBseCurr['CurrOpt']!,
          ).toList();
        } else
          currOptCombined = resultsCurr['CurrOpt'];
        stockItems['Currency']!.addAll(currOptCombined);
        stockItems['All']!.addAll(currOptCombined);

        break;
      case 'optidx':
        if (Dataconstants.isFromSIP) break;
        var resultsFO = Dataconstants.exchData[1]!.findModelsForSearchFO(tempQuery);
        if (resultsFO['OptIdx']!.length > 0) {
          stockItems['All']!.addAll(resultsFO['OptIdx']!);
          stockItems['FO']!.addAll(resultsFO['OptIdx']!);
        }

        break;
      case 'optstx':
        if (Dataconstants.isFromSIP) break;
        var resultsFO = Dataconstants.exchData[1]!.findModelsForSearchFO(tempQuery);
        if (resultsFO['OptStx']!.length > 0) {
          stockItems['All']!.addAll(resultsFO['OptStx']!);
          stockItems['FO']!.addAll(resultsFO['OptStx']!);
        }

        break;
      case 'curr':
        if (Dataconstants.isFromSIP) break;
        if (Dataconstants.isFromAlgo) break;
        if (Dataconstants.isFromBasketOrder) break;
        var resultsCurr = Dataconstants.exchData[3]!.findModelsForSearchCurrencyFO(tempQuery);
        var resultsBseCurr = Dataconstants.exchData[4]!.findModelsForSearchCurrencyFO(tempQuery);

        var currCombined;
        if (!Dataconstants.isFromAlgo) {
          currCombined = zip(
            resultsCurr['CurrFut']!,
            resultsBseCurr['CurrFut']!,
          ).toList();
        } else
          currCombined = resultsCurr['CurrFut'];
        stockItems['Currency']!.addAll(currCombined);
        stockItems['All']!.addAll(currCombined);

        var currOptCombined;
        if (!Dataconstants.isFromAlgo) {
          currOptCombined = zip(
            resultsCurr['CurrOpt']!,
            resultsBseCurr['CurrOpt']!,
          ).toList();
        } else
          currOptCombined = resultsCurr['CurrOpt'];
        stockItems['Currency']!.addAll(currOptCombined);
        stockItems['All']!.addAll(currOptCombined);
        break;
        // case 'mcx':
        //   if (Dataconstants.isFromSIP) break;
        //   if (Dataconstants.isFromAlgo) break;
        //   if (Dataconstants.isFromBasketOrder) break;
        //   var resultsFO = Dataconstants.exchData[5].findModelsForSearch(tempQuery);
        //   if (resultsFO.length > 0) {
        //     stockItems['All'].addAll(resultsFO);
        //     stockItems['Commodity'].addAll(resultsFO);
        //   }

        break;
    }

    String dateNow = DateTime.now().day.toString() + "-" + DateTime.now().month.toString() + "-" + DateTime.now().year.toString();
    var dateepoc = DateUtil.getIntFromDate2(dateNow);
    if (!stockItems.isEmpty) {
      stockItems['All']!.removeWhere((element) => element.expiry != 0 && element.expiry! < dateepoc);
      stockItems['FO']!.removeWhere((element) => element.expiry != 0 && element.expiry! < dateepoc);
    }

    return stockItems;
  }

  static tatvikFireBaseEventLogging(screen_name_value) async {
    var parameters = {
      'screen_name_value': screen_name_value,
      'tvc_client_id': Dataconstants.uuid ?? "",
      'Cust_ID': Dataconstants.systemCustId ?? '',
      'app_id': Dataconstants.appInstanceId ?? ''
    };
    // print("Tatvic params $parameters");
    // FirebaseAnalytics.instance.logEvent(name: 'screenview_manual', parameters: parameters);
    try {
      // var bools = await InAppSelection.appsflyerSdk
      //     .logEvent('screenview_manual', parameters);
    } catch (e) {
      print(e);
    }
  }

  static fireBaseEventLogging(eventCategory, event_action, event_lable) {
    var parameters = {
      'eventCategory': eventCategory,
      'eventAction': event_action,
      'eventLabel': event_lable,
      'client_id': Dataconstants.uuid ?? "",
      'Cust_ID': Dataconstants.systemCustId ?? '',
      'AppName': 'ICICIdirect Markets',
      'app_id': Dataconstants.appInstanceId ?? ''
    };
    // print("FireBase params $parameters");
    // FirebaseAnalytics.instance.logEvent(name: 'accountdetails_subcategory_click', parameters: parameters);
  }

  // #region icici login

  static String get timeStamp => DateFormat('dd-MMM-yyyy H:mm:ss').format(DateTime.now());

  static String istTime() {
    tz.initializeTimeZones();
    var location = tz.getLocation('Asia/Kolkata');
    var m = tz.TZDateTime.from(DateTime.now(), location);
    final df = new DateFormat('dd-MMM-yyyy H:mm:ss');
    // print(df.format(m));
    var time = df.format(m);
    return time;
  }

  static String get date => DateFormat('dd-MMM-yyyy').format(DateTime.now());

  static String checksum(String data) => sha256.convert(utf8.encode(data)).toString();

  // #endregion
  static String getDateTimeFromInt(int value, ExchCategory exchCategory) {
    if (value <= 0) return '--';
    if (exchCategory == ExchCategory.mcxFutures || exchCategory == ExchCategory.mcxOptions)
      return DateUtil.getMcxDateWithFormat(value, 'dd MMM yyyy');
    else
      return DateUtil.getDateWithFormat(value, 'dd MMM yyyy');
  }

  static Future checkIfFirstInstall(bool reset) async {
    if (reset) {
      // Dataconstants.deviceID = null;
      Dataconstants.loginMode = 0;
    } else {
      InAppSelection.bioMetricData = await isBiometricAvailable();
      // Dataconstants.deviceID = sp.getString('deviceID');
    }
  }

  static getRandomIp() {
    Random random = new Random();
    int randomNumber = random.nextInt(3);
    // print("randomNumber $randomNumber");
    // print("randomIP ${BrokerInfo.servers[randomNumber]}");
    return BrokerInfo.servers![randomNumber];
  }

  // static void checkInternet() async {
  //   try {
  //     final Connectivity _connectivity = Connectivity();
  //     ConnectivityResult result;
  //     result = await _connectivity.checkConnectivity();
  //   } catch (e) {
  //     CommonFunction.showDialogInternetForAll(Dataconstants.context);
  //   }
  //   // print("check internet -> re");
  // }

  static void showDialogGestLogin({BuildContext? context, String? comingFrom, String? title1}) {
    // TextEditingController _guestEmailAddController = TextEditingController();
    // final theme = Theme.of(context);
    showDialog(
      barrierDismissible: false,
      context: context!,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.all(10),
            content: Container(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        iconSize: 15,
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                  Column(
                    children: [
                      Text("$title1", style: TextStyle()),
                      Text(
                        "open an account now it takes",
                        style: TextStyle(),
                      ),
                      Text(
                        "only 10 minute.",
                        style: TextStyle(),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    // width: double.infinity,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fixedSize: Size.fromHeight(45),
                        ),
                        onPressed: () async {
                          var device;
                          if (Platform.isAndroid)
                            device = 'android';
                          else
                            device = 'iOS';
                          //           SharedPreferences prefs =
                          //     await SharedPreferences.getInstance();
                          // var utmSource = GetStorageData.read('utm_source');
                          // var utmTerm = GetStorageData.read('utm_term');
                          // var utmcampaign = GetStorageData.read('utm_campaign');
                          // var utmadid = GetStorageData.read('utm_adid');
                          // var utmmedium = GetStorageData.read('utm_medium');
                          // var utmcontent = GetStorageData.read('utm_content');
                          // var utmadgroup = GetStorageData.read('utm_adgroup');
                          // print("source = $utmSource & medium = $utmmedium");
                          // var link = BrokerInfo.createAccountLink + '?';

                          // if (utmSource != null)
                          //   link += 'utm_source=mktapp-gl-$utmSource';
                          // if (utmmedium != null)
                          //   link += '&utm_medium=mktapp-$utmmedium';
                          // if (utmTerm != null) link += '&utm_term=$utmTerm';
                          // if (utmcampaign != null) link += '&utm_campaign=$utmcampaign';
                          // if (utmadid != null) link += '&utm_adid=$utmadid';
                          // if (utmcontent != null) link += '&utm_content=$utmcontent';
                          // if (utmadgroup != null) link += '&utm_adgroup=$utmadgroup';

                          // link +=
                          //     "&cid=${Dataconstants.uuid}&av=${Dataconstants.fileVersion}&aid=com.icicidirect.markets&dimension%2017=MarketApp";
                          // String mobileNo = GetStorageData.read('verifiedmobileno');
                          // print("mobile no=> $mobileNo");
                          // if (mobileNo.isNotEmpty || mobileNo != null)
                          //   link += '&Mobile=$mobileNo';

                          var utmSource = GetStorageData.read('utm_source');
                          var utmTerm = GetStorageData.read('utm_term');
                          var utmcampaign = GetStorageData.read('utm_campaign');
                          var utmadid = GetStorageData.read('utm_adid');
                          var utmmedium = GetStorageData.read('utm_medium');
                          var utmcontent = GetStorageData.read('utm_content');
                          var utmadgroup = GetStorageData.read('utm_adgroup');
                          // print("source = $utmSource & medium = $utmmedium");
                          var link = BrokerInfo.createAccountLink + '?';
                          if (utmSource != null)
                            link += 'utm_source=mktapp-gl-android-$utmSource';
                          else {
                            if (Platform.isIOS)
                              link += 'utm_source=mktapp-gl-ios';
                            else
                              link += 'utm_source=mktapp-gl-android-na';
                          }
                          if (utmmedium != null)
                            link += '&utm_medium=mktapp-$utmmedium';
                          else {
                            if (Platform.isIOS)
                              link += '&utm_medium=mktapp-organic';
                            else
                              link += '&utm_medium=mktapp-na';
                          }
                          if (utmcampaign != null)
                            link += '&utm_campaign=$utmcampaign';
                          else {
                            if (Platform.isIOS)
                              link += '&utm_campaign=OAO';
                            else
                              link += '&utm_campaign=na';
                          }
                          if (utmcontent != null)
                            link += '&utm_content=$device-$utmcontent';
                          else {
                            if (Platform.isIOS)
                              link += '&utm_content=na';
                            else
                              link += '&utm_content=na';
                          }
                          if (utmadgroup != null) link += '&utm_adgroup=$utmadgroup';
                          if (utmTerm != null)
                            link += '&utm_term=$utmTerm';
                          else {
                            if (Platform.isIOS)
                              link += '&utm_term=na';
                            else
                              link += '&utm_term=na';
                          }
                          //
                          // if (utmSource != null)
                          //   link += 'utm_source=mktapp-gl-$utmSource';
                          // if (utmmedium != null)
                          //   link += '&utm_medium=mktapp-$utmmedium';
                          //
                          // if (utmcampaign != null) link += '&utm_campaign=OAO';
                          // if (utmcontent != null)
                          //   link += '&utm_content=$device-$utmcontent';
                          // if (utmadgroup != null)
                          //   link += '&utm_adgroup=$utmadgroup';
                          // if (utmTerm != null) link += '&utm_term=$utmTerm';
                          if (utmadid != null) link += '&utm_adid=$utmadid';
                          String mobileNo = GetStorageData.read('verifiedmobileno')!;
                          link +=
                          "&cid=${Dataconstants.uuid}&av=${Dataconstants.fileVersion}&aid=com.icicidirect.markets&dimension%2017=MarketApp&app_id=${Dataconstants.appInstanceId}";

                          if (Platform.isAndroid) {
                            var encryptedNo = await getEncryptedText(mobileNo);

                            if (encryptedNo != "") {
                              var encodedMobile = Uri.encodeComponent(encryptedNo);
                              print("encodedUrl url - $encodedMobile");
                              link += '&Mobile=$encodedMobile';
                            }
                          } else {
                            link += '&Mobile=$mobileNo';
                          }
                          Dataconstants.itsClient.guestloginScreenEvent(
                              eventAction: 'open_an_account_click',
                              eventLabel: 'Successful',
                              logEvent: 'open_an_account',
                              eventCategory: comingFrom!);

                          if (Platform.isIOS) link = link.replaceAll(' ', '%20');
                          // if (await canLaunch(link)) launch(link);
                          var cstatus = await Permission.camera.status;
                          var sstatus = await Permission.storage.status;
                          if (sstatus.isDenied || cstatus.isDenied || cstatus.isPermanentlyDenied || sstatus.isPermanentlyDenied) {
                            await [
                              Permission.camera,
                              Permission.storage,
                              Permission.photos,
                              Permission.microphone,
                            ].request();
                            cstatus = await Permission.camera.status;
                            sstatus = await Permission.storage.status;

                            if (sstatus.isDenied || cstatus.isDenied || cstatus.isPermanentlyDenied || sstatus.isPermanentlyDenied) {
                              await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Platform.isIOS && (cstatus.isPermanentlyDenied || sstatus.isPermanentlyDenied)
                                        ? CupertinoAlertDialog(
                                      title: Text(
                                        'Permission Alert',
                                        style: TextStyle(fontSize: 18),
                                      ),

                                      content: Text(
                                        "Please grant permission for camera to use features under this facility",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      //content: ChangelogScreen(),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text(
                                            'OK',
                                            style: TextStyle(
                                              color: Theme.of(context).primaryColor,
                                            ),
                                          ),
                                          onPressed: () {
                                            openAppSettings();
                                          },
                                        ),
                                      ],
                                    )
                                        : AlertDialog(
                                      contentPadding: EdgeInsets.fromLTRB(24, 20, 10, 10),
                                      title: Text(
                                        'Permission Alert',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      buttonPadding: EdgeInsets.zero,
                                      content: Text(
                                        "Please grant permission for camera to use features under this facility",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      //content: ChangelogScreen(),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text(
                                            'OK',
                                            style: TextStyle(
                                              color: Theme.of(context).primaryColor,
                                            ),
                                          ),
                                          onPressed: () {
                                            openAppSettings();
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            }
                          } else {
                            try {
                              // if (Platform.isAndroid) {
                              //   InAppSelection.advertisingId =
                              //   await AdvertisingId.id(true);
                              // } else {
                              //   InAppSelection.advertisingId =
                              //   await AdvertisingId.id(true);
                              //   // InAppSelection.advertisingId = '00000000-0000-0000-0000-000000000000';
                              // }
                              if (InAppSelection.advertisingId == "" || InAppSelection.advertisingId == null) {
                                InAppSelection.advertisingId = "00000000-0000-0000-0000-000000000000";
                              } // InAppSelection.advertisingId =
                              //     await AdvertisingId.id(true);
                            } catch (e) {
                              InAppSelection.advertisingId = "00000000-0000-0000-0000-000000000000";
                            }
                            if (Platform.isAndroid)
                              Navigator.push(context, MaterialPageRoute(builder: (context) => OAOWebLink("Open An Account", link)));
                            else
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ChromeSafari("Open An Account", link)));

                            //
                            // if (Platform.isIOS)
                            //   link = link.replaceAll(' ', '%20');
                            // // if (await canLaunch(link)) launch(link);
                            // var cstatus = await Permission.camera.status;
                            // var sstatus = await Permission.storage.status;
                            // if (sstatus.isDenied ||
                            //     cstatus.isDenied ||
                            //     cstatus.isPermanentlyDenied ||
                            //     sstatus.isPermanentlyDenied) {
                            //   await [
                            //     Permission.camera,
                            //     Permission.storage,
                            //     Permission.photos
                            //   ].request();
                            // } else {
                            // try {
                            //   InAppSelection.advertisingId =
                            //       await AdvertisingId.id(true);
                            // } on PlatformException {
                            //   InAppSelection.advertisingId = '0';
                            // }
                            //   Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) =>
                            //               OAOWebLink("Open An Account")));
                            // }
                          }
                        },
                        child: Text(
                          'Open an account',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                        ),
                      ),
                    ),
                  ),
                  // Container(
                  //   margin: EdgeInsets.only(left: 10, right: 10),
                  //   child: TextFieldWidget(
                  //     textInputAction: TextInputAction.next,
                  //     // focusNode: myFocusNodeUserIDLogin,
                  //     controller: _guestEmailAddController,
                  //     inputFormatters: [
                  //       FilteringTextInputFormatter.allow(
                  //           RegExp("^[0-9a-zA-Z- @.\-_#]+\$")),
                  //     ],
                  //     hintText: 'Enter email ID',
                  //     obscureText: false,
                  //     prefixIconData: Icons.person_outline,
                  //     fillColor: theme.cardColor,

                  //     onEditingComplete: () => {},
                  //   ),
                  // ),
                  // SizedBox(height: 20),
                  // ButtonTheme(
                  //   child: Container(
                  //     width: MediaQuery.of(context).size.width * 0.8,
                  //     child: TextButton(
                  //       color: Theme.of(context).primaryColor,
                  //       textColor: Colors.white,
                  //       onPressed: () async {
                  //         // FirebaseAnalytics().logEvent(name: 'Test_isec', parameters: {
                  //         //   'eventCategory': 'Test_isec',
                  //         //   'eventAction': 'Test_isec_marketapp'
                  //         // });
                  //       },
                  //       child: Text(
                  //         'Submit',
                  //         style: TextStyle(
                  //             fontSize: 15,
                  //             fontWeight: FontWeight.bold,
                  //             letterSpacing: 1.2),
                  //       ),
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(10),
                  //       ),
                  //       height: 45,
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 20),
                ],
              ),
            ));
      },
    );
  }

  static Future<bool> showTnc(BuildContext context, ExchCategory category) async {
    String text, productCode;
    if (category == ExchCategory.nseEquity || category == ExchCategory.bseEquity) {
      text = Dataconstants.eqTncText!;
      productCode = 'EQ';
    } else if (category == ExchCategory.mcxOptions || category == ExchCategory.mcxFutures) {
      text = Dataconstants.commTncText!;
      productCode = 'CMD';
    } else if (category == ExchCategory.currenyOptions || category == ExchCategory.currenyFutures) {
      text = Dataconstants.currTncText!;
      productCode = 'CDX';
    } else {
      text = Dataconstants.foTncText!;
      productCode = 'FNO';
    }
    var result = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          var theme = Theme.of(context);
          return TNCDialog(productCode);
        });

    if (result == null) result = false;
    if (result) {
      var tncResult = await Dataconstants.itsClient.setTnc(productCode);
      if (tncResult['success']) {
        if (category == ExchCategory.nseEquity || category == ExchCategory.bseEquity) {
          Dataconstants.eqTncFlag = 'Y';
        } else if (category == ExchCategory.mcxFutures || category == ExchCategory.mcxOptions) {
          Dataconstants.commTncFlag = 'Y';
        } else if (category == ExchCategory.currenyFutures || category == ExchCategory.currenyOptions) {
          Dataconstants.currTncFlag = 'Y';
        } else
          Dataconstants.foTncFlag = 'Y';
      } else
        showBasicToast(tncResult['message']);
    }
    return result;
  }

  static Future<List<BiometricType>> isBiometricAvailable() async {
    List<BiometricType> data = [];
    var _localAuthentication = LocalAuthentication();
    try {
      if (await _localAuthentication.canCheckBiometrics) data = await _localAuthentication.getAvailableBiometrics();
    } on PlatformException catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
    }
    return data;
  }

  static bool isValidTickSize(
      String value,
      ScripInfoModel model,
      ) {
    List<String> val = value.split('.');
    if (val.length <= 1 || model.tickSize == 1) return true;
    var lastCharacter = val[1].substring(val.length - 1);
    if (model.exch == 'NDX' || model.exch == 'C') {
      if (val[1].length == 4) return true;
    }
    if (lastCharacter == '0' || lastCharacter == model.tickSize.toString()) return true;

    return false;
  }

  static Future<void> changePasswordPopUp(BuildContext context, String text) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          var theme = Theme.of(context);
          return AlertDialog(
            title: Text('Change Password'),
            content: Text(text),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: theme.primaryColor,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(
                  'Change',
                  style: TextStyle(
                    color: theme.primaryColor,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(
                    ChangePasswordScreen.routeName,
                  );
                },
              ),
            ],
          );
        });
  }

  static void logOutConfirmation(BuildContext context) {
    var theme = Theme.of(context);
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('LOGOUT'),
          content: Text(
            'Are you sure you want to logout?',
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'CANCEL',
                style: TextStyle(
                  color: theme.primaryColor,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text(
                'LOGOUT',
                style: TextStyle(
                  color: theme.primaryColor,
                ),
              ),
              onPressed: () {
                Dataconstants.mainScreenIndex == 0;
                Navigator.of(context).pop(true);
                // Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(builder: (context) => NewLogin()));
                // PageRouteBuilder(
                //   pageBuilder: (_, __, ___) => NewLogin(),
                // transitionDuration: Duration(seconds: 0),
                // );  isLogoutClick
                Dataconstants.isLogoutClick = true;
                logOut(true, true);
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      // print('Could not launch $url');
    }
  }

  static Iterable<T> zip<T>(Iterable<T> a, Iterable<T> b) sync* {
    final ita = a.iterator;
    final itb = b.iterator;
    bool hasa, hasb;
    while ((hasa = ita.moveNext()) | (hasb = itb.moveNext())) {
      if (hasa) yield ita.current;
      if (hasb) yield itb.current;
    }
  }

  static Map<String, int> countChars(String value) {
    String s1;
    var alpha = [
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M',
      'N',
      'O',
      'P',
      'Q',
      'R',
      'S',
      'T',
      'U',
      'V',
      'W',
      'X',
      'Y',
      'Z',
    ];
    var number = [
      '0',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
    ];
    var special = [
      '!',
      '@',
      '#',
      '\$',
      '%',
      '^',
      '&',
      '*',
      '(',
      ')',
    ];
    var alphaCount = 0;
    var numericCount = 0;
    var otherCount = 0;
    var specialCount = 0;
    s1 = value.trim().toUpperCase();
    for (int i = 0; i < s1.length; i++) {
      if (alpha.contains(s1[i]))
        alphaCount++;
      else if (number.contains(s1[i]))
        numericCount++;
      else if (special.contains(s1[i]))
        specialCount++;
      else
        otherCount++;
    }
    return {
      'alpha': alphaCount,
      'number': numericCount,
      'special': specialCount,
      'other': otherCount,
    };
  }

  static tPlusDialog(isAndroid, context) {
    showDialog(
      context: context,
      builder: (context) => isAndroid
          ? AlertDialog(
        title: Row(
          children: [
            Text('Stock Settlement'),
            Spacer(),
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.clear,
                  size: 20,
                ))
          ],
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                'Please note from 25th February 2022, NSE and BSE have started migrating stocks to T+1 settlement cycle in phased manner. Hence, the settlement type i.e T+1 and T+2 is displayed against each stocks.'),
          ],
        ),
      )
          : CupertinoAlertDialog(
        title: Text('Stock Settlement'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                'Please note from 25th February 2022, NSE and BSE have started migrating stocks to T+1 settlement cycle in phased manner. Hence, the settlement type i.e T+1 and T+2 is displayed against each stocks.'),
          ],
        ),
        actions: [
          TextButton(
            child: Text(
              'Close',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  // bakset Order

  static void quickSortTradeArray(List<TTradeRecord> ArrayTradeData, int Start, int Stop) //chart tick by tick
  {
    int? Left, Right, Mid;
    int? Pivot;
    TTradeRecord? temp;

    Left = Start;
    Right = Stop;
    Mid = int.parse(((Start + Stop) / 2).toString());

    Pivot = ArrayTradeData[Mid].dtTm!;

    do {
      while ((ArrayTradeData[Left!].dtTm! < Pivot) && Left < Stop) Left++;
      while ((Pivot < ArrayTradeData[Right!].dtTm!) && Right > Start) Right--;

      if (Left <= Right) {
        temp = ArrayTradeData[Left];
        ArrayTradeData[Left] = ArrayTradeData[Right];
        ArrayTradeData[Right] = temp;
        Left++;
        Right--;
      }
    } while (Left <= Right);
    if (Start < Right) quickSortTradeArray(ArrayTradeData, Start, Right);
    if (Left < Stop) quickSortTradeArray(ArrayTradeData, Left, Stop);
  }

  static updateChartTickByTick(int? recType, ScripInfoModel? model) {
    //chart tick by tick
    // return;
    var list2 = model!.historyTrades.length;
    ChartStudies chartStudies;
    KLineEntity d;
    switch (recType) {
      case 116:
        {
          Dataconstants.datas = [];
          for (int i = 0; i < model.historyTrades.length; i++) {
            d = KLineEntity.fromCustom(
                open: model.historyTrades[i].rate,
                close: model.historyTrades[i].rate,
                high: model.historyTrades[i].rate,
                low: model.historyTrades[i].rate,
                vol: double.parse(model.historyTrades[i].qty.toString()),
                time: model.historyTrades[i].dtTm);
            Dataconstants.datas.add(d);
          }
          Dataconstants.datas.reversed.toList().cast<KLineEntity>();
          // DataUtil.calculate(Dataconstants.datas, chartStudies.studyList);
          Dataconstants.chartPageController.add(true);
          // DataUtil.calculate(Dataconstants.datas, chartStudies.studyList);
          print(Dataconstants.datas);
        }
        break;
      case 65:
        {
          // if (Dataconstants.exchData[0].exchangeStatus == ExchangeStatus.nesOpen)  //guard clauses
          //   return Dataconstants.datas;
          // }
          {
            d = KLineEntity.fromCustom(
                open: model.close,
                close: model.close,
                high: model.close,
                low: model.close,
                vol: double.parse(model.lastTickQty.toString()),
                time: model.lastRecTime);
            Dataconstants.datas.add(d);
            // DataUtil.calculate(Dataconstants.datas, chartStudies.studyList);
            Dataconstants.chartPageController.add(true);
            var first = Dataconstants.datas.first;
            var last = Dataconstants.datas.last;
            // print();
            // DataUtil.calculate(Dataconstants.datas, chartStudies.studyList);
            Dataconstants.buySellButtonTickByTick2 = false;
            return Dataconstants.datas;
          }
          break;
        }
    }
  }

  static alertDiealougeForChart(
      ThemeData theme,
      int productType,
      TextEditingController limitController,
      int limitOrder,
      TextEditingController qtyContoller,
      BuildContext context,
      double yPixel,
      ScripInfoModel model,
      bool buy,
      GlobalKey<ScaffoldMessengerState> scaffoldKey,
      TextEditingController triggerController) {
    // limitController.text = ((double.parse(yPixel.toStringAsFixed(2))*20)/20).toStringAsFixed(2) ;
    limitController.text = yPixel.ceilToDouble().toStringAsFixed(2);
    // limitController.text = yPixel.toStringAsFixed(2);
    triggerController.text = yPixel.toStringAsFixed(2);
    return AlertDialog(
      title: Text(buy == true ? '  Buy Order' : "  Sell Order"),
      content: StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'PRODUCT',
                  style: TextStyle(fontSize: 14),
                ),
                CupertinoSlidingSegmentedControl<int>(
                  //thumbColor: theme.colorScheme.secondary,
                    children: {
                      0: Container(
                        height: 12,
                        width: 50,
                        child: Center(
                          child: Text(
                            'INTRADAY',
                            style: TextStyle(
                              fontSize: 10,
                              color: productType == 0 ? theme.primaryColor : theme.textTheme.bodyLarge!.color,
                            ),
                          ),
                        ),
                      ),
                      1: Container(
                        height: 12,
                        width: 50,
                        child: Center(
                          child: Text(
                            'DELIVERY',
                            style: TextStyle(
                              fontSize: 10,
                              color: productType == 1 ? theme.primaryColor : theme.textTheme.bodyLarge!.color,
                            ),
                          ),
                        ),
                      ),
                    },
                    groupValue: productType,
                    onValueChanged: (newValue) {
                      setState(() {
                        productType = newValue!;
                        print("product Type :$productType");
                      });
                    }),
              ],
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'QUANTITY',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 10),
                NumberField(
                  defaultValue: 1,
                  maxLength: 10,
                  numberController: qtyContoller,
                  increment: 1,
                  hint: 'Quantity',
                  isInteger: true,
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ORDER TYPE',
                  style: TextStyle(fontSize: 14),
                ),
                CupertinoSlidingSegmentedControl<int>(
                  //thumbColor: theme.colorScheme.secondary,
                    children: {
                      0: Container(
                        height: 12,
                        width: 45,
                        child: Center(
                          child: Text(
                            'MARKET',
                            style: TextStyle(
                              fontSize: 10,
                              color: limitOrder == 0 ? theme.primaryColor : theme.textTheme.bodyLarge!.color,
                            ),
                          ),
                        ),
                      ),
                      1: Container(
                        height: 12,
                        width: 45,
                        child: Center(
                          child: Text(
                            'LIMIT',
                            style: TextStyle(
                              fontSize: 10,
                              color: limitOrder == 1 ? theme.primaryColor : theme.textTheme.bodyLarge!.color,
                            ),
                          ),
                        ),
                      ),
                    },
                    groupValue: limitOrder,
                    onValueChanged: (newValue) {
                      setState(() {
                        limitOrder = newValue!;
                        print("order type Type :$limitOrder");
                      });
                    }),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            AnimatedSwitcher(
              transitionBuilder: (Widget child, Animation<double> animation) {
                final offsetAnimation = Tween<Offset>(begin: Offset(0.0, -1.0), end: Offset(0.0, 0.0)).animate(animation);
                return ClipRect(
                  child: SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  ),
                );
              },
              duration: const Duration(milliseconds: 250),
              child: limitOrder == 1
                  ? NumberField(
                doubleDefaultValue: double.parse(yPixel.ceilToDouble().toStringAsFixed(2)) ?? 0.00,
                doubleIncrement: model.incrementTicksize(),
                maxLength: 10,
                numberController: limitController,
                hint: 'Limit',
              )
                  : SizedBox.shrink(),
            ),
          ],
        );
      }),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Cancel');
          },
          child: Text(
            'Cancel',
            style: TextStyle(color: Color(0xFF5367FC)),
          ),
        ),
        TextButton(
          onPressed: () async {
            ///-----------order API--------------------
            ///
            var jsons = {
              "variety": Dataconstants.exchData[0]!.exchangeStatus == ExchangeStatus.nesClosed ? "AMO" : "NORMAL",
              "tradingsymbol": model.tradingSymbol,
              "symboltoken": model.exchCode.toString(),
              "transactiontype": buy == true ? "BUY" : "SELL",
              "exchange": model.exch == "N" ? "NSE" : "BSE",
              "ordertype": InAppSelection.buyFromChartOrderSL && limitOrder == 0
                  ? "STOPLOSS_MARKET"
                  : InAppSelection.buyFromChartOrderSL && limitOrder == 1
                  ? "STOPLOSS_LIMIT"
                  : limitOrder == 0
                  ? "MARKET"
                  : "LIMIT",
              "producttype": productType == 1 ? "DELIVERY" : "INTRADAY",
              "duration": 'DAY',
              "price": limitOrder == 1 ? limitController.text : "0",
              "quantity": qtyContoller.text,
              "disclosedquantity": "0",
              "triggerprice": InAppSelection.buyFromChartOrderSL ? triggerController.text : '0',
            };

            ///------------ Api end------------

            print("buy / sell order request body $jsons");
            var response = await CommonFunction.placeOrder(jsons);

            var responseJson = json.decode(response.toString());
            // print("response $responseJson");
            if (responseJson["status"] == false) {
              CommonFunction.showBasicToast(responseJson["emsg"].toString());
              return;
            }
            // var status = Dataconstants.responseForChart["Status"];
            // var success = Dataconstants.responseForChart["Success"];
            // var indicator = success["Indicator"];
            // var message = success["Message"];
            // Dataconstants.indicatorChart = indicator;
            // if (indicator == "0") {
            if (responseJson["status"] == true) {
              Dataconstants.y1.add(Dataconstants.ltpTickByTick!);
              Dataconstants.timerChart.add(DateTime.now().millisecondsSinceEpoch);
              Dataconstants.createdFromFlashTrade.add(false);
              buy == true ? Dataconstants.isBuyColorFlashTrade.add(true) : Dataconstants.isBuyColorFlashTrade.add(false);
              // buy==true?   Dataconstants.placedOrderLineTickByTick.add(true)
              //     :Dataconstants.placedOrderLineTickByTick.add(false);
              print(DateTime.now().millisecondsSinceEpoch);
              Dataconstants.defaultBuySellChartSetting = true;

              Navigator.pop(context);
              Dataconstants.drawLineOnBuySell.add(true);
              Dataconstants.mainScreenIndex = 1;
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return MainScreen();
                  },
                ),
              );
              CommonFunction.showBasicToast(responseJson["message"].toString());
            }
          },
          child: const Text(
            'Confirm',
            style: TextStyle(color: Color(0xFF5367FC)),
          ),
        ),
      ],
    );
  }

  static void showBasicToastForChar(String message, int seconds) {
    // chart Tick By Tick
    if (message.toString().toUpperCase().contains("PEAK MARGIN")) return;
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        //Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: seconds,
        backgroundColor: Colors.grey,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  //#################################################->Bigul<-###################################

  // static Future startKycWorkflow({kId, name, gwtId}) async {
  //   var workflowResult;
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   // We also handle the message potentially returning null.
  //   try {
  //     // var digioConfig = DigioConfig();
  //     digioConfig.theme.primaryColor = "#32a83a";
  //     digioConfig.logo = "https://www.gstatic.com/mobilesdk/160503_mobilesdk/logo/2x/firebase_28dp.png";
  //     // digioConfig.environment = Environment.SANDBOX;
  //     // final _kycWorkflowPlugin = KycWorkflow(digioConfig);
  //
  //     // String docwork = "documentId : KID230314153412192TDQE771O9577RH, message: Success, code: 1001, permissions: null";
  //
  //     workflowResult = await _kycWorkflowPlugin.start("$kId", "$name", "$gwtId", null);
  //
  //     print(workflowResult);
  //
  //     var docWorkflow = workflowResult.toString().trim();
  //     var docid = docWorkflow.toString().split(":")[1].split(",")[0].trim();
  //     // Map data = (workflowResult);
  //     // io.log('workflowResult : ' + (workflowResult).toString());
  //
  //     var kycDigiLockerResponse = await Dataconstants.panController.kycDigilockerRequest(documentId: docid);
  //
  //     return true;
  //   } on PlatformException {
  //     workflowResult = 'Failed to get platform version.';
  //   }
  //
  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   // if (!mounted) return;
  //   //
  //   // setState(() {
  //   //   _workflowResult = workflowResult.toString();
  //   // });
  // }

  static floatingButton() async {
    switch (InAppSelection.algoOrderReportScreenTabIndex) {
      case 0:
        {
          // await Dataconstants.awaitingController.fetchReportAwaitingAlgo();
          return false;
        }
        break;
      case 1:
        {
          await Dataconstants.runningController.fetchReportRunningAlgo();
          return RunningController.reportRunningAlgoLists!.isEmpty;
        }
        break;
      case 2:
        {
          await Dataconstants.finishedController.fetchReportFinishedAlgo();
          return FinishedController.reportFinishedAlgoLists!.isEmpty;
        }
        break;
      case 3:
        {
          await Dataconstants.finishedController.fetchReportFinishedAlgo();
          return FinishedController.reportFinishedAlgoLists!.isEmpty;
        }
        break;
    }
  }

  static firebaselogEvent(bool trackEvent, eventCategory, eventAction, eventLabel) {
    if (trackEvent) {
      var parameters = {
        'eventCategory': eventCategory,
        'eventAction': eventAction,
        'eventLabel': eventLabel,
        'client_id': Dataconstants.feUserID,
        'AppName': 'Bigul Trading',
        'device_id': Dataconstants.feDeviceID // "12",
      };
      // Dataconstants.firebaseAnalytics.logEvent(name: eventLabel, parameters: parameters);
      print("logEvents $parameters");
    } else {
      print("event tracking off");
    }
  }

  static getProfile(requestJson) async {
    http.Response response =
    await Dataconstants.itsClient.httpPostWithHeader(BrokerInfo.mainUrl + "GetProfile", requestJson, Dataconstants.loginData!.data!.jwtToken);
    var resp = jsonDecode(response.body);
    print(" Get profile API :$resp");
    return response.body.toString();
  }

  static void disconnectAndConnectIQSClient() {
    Dataconstants.internalFeUserID = Dataconstants.feUserID;
    Dataconstants.iqsClient!.createHeaderRecord(Dataconstants.internalFeUserID);
    Dataconstants.iqsClient!.disconnect();
    Dataconstants.iqsClient!.connect();

    Dataconstants.newsClient = NewsClient.getInstance();
    Dataconstants.newsClient!.connect();
  }

  static getLimits() async {
    var requestJson = {"Segment": "ALL"};
    http.Response response =
    await Dataconstants.itsClient.httpPostWithHeader(BrokerInfo.mainUrl + "Limits", requestJson, Dataconstants.loginData!.data!.jwtToken);
    io.log("get Limit response - ${response.body.toString()}");
    var responseBody = jsonDecode(response.body.toString());
    Dataconstants.limitResponse = responseBody;
    return response.body.toString();
  }

  static placeOrder(requestJson) async {
    // Dataconstants.orderPlaced = false;

    http.Response response = await Dataconstants.itsClient.httpPostWithHeader(
        BrokerInfo.mainUrl + "PlaceOrder",
        requestJson,
        // requestJson,
        Dataconstants.loginData!.data!.jwtToken);
    // Dataconstants.orderPlaced = true;
    print("placeOrder easy option ${requestJson}");
    print("response ${response.body}");
    return response.body.toString();
  }

  static modifyOrder(requestJson) async {
    http.Response response =
    await Dataconstants.itsClient.httpPostWithHeader(BrokerInfo.mainUrl + "ModifyOrder", requestJson, Dataconstants.loginData!.data!.jwtToken);
    return response.body.toString();
  }

  static cancelOrder(requestJson) async {
    http.Response response =
    await Dataconstants.itsClient.httpPostWithHeader(BrokerInfo.mainUrl + "CancelOrder", requestJson, Dataconstants.loginData!.data!.jwtToken);
    return response.body.toString();
  }

  static exitOrderCoverOrderFromOrderBook(requestJson) async {
    http.Response response =
    await Dataconstants.itsClient.httpPostWithHeader(BrokerInfo.mainUrl + "ExitCoverOrder", requestJson, Dataconstants.loginData!.data!.jwtToken);
    return response.body.toString();
  }

  static squareOff(requestJson) async {
    http.Response response = await Dataconstants.itsClient
        .httpPostWithHeader(BrokerInfo.mainUrl + "Squareofposition", requestJson, Dataconstants.loginData!.data!.jwtToken);
    return response.body.toString();
  }

  static pconvertPositions(requestJson) async {
    print("vfkjjghghghggh ${requestJson}");
    http.Response response = await Dataconstants.itsClient
        .httpPostWithHeader(BrokerInfo.mainUrl + "PartialConvertPosition", requestJson, Dataconstants.loginData!.data!.jwtToken);
    return response.body.toString();
  }

  static squareOffFlass(requestJson) async {
    http.Response response = await Dataconstants.itsClient.httpPost(BrokerInfo.flashTradeLink + "Exit", requestJson);
    return response.body.toString();
  }

  static exitCoverOrder(requestJson) async {
    http.Response response = await Dataconstants.itsClient.httpPost(BrokerInfo.flashTradeLink + "ExitCoverOrder", requestJson);
    return response.body.toString();
  }

  //ValidateDate
  static bool isValidDate(String dateStr) {
    try {
      // Parse the input string into a DateTime object
      // dateStr = dateStr.replaceAll("/","");
      int day = int.parse(dateStr.split("/")[0]);
      int month = int.parse(dateStr.split("/")[1]);
      int year = int.parse(dateStr.split("/")[2]);

      // DateTime date = DateTime.parse(dateStr);

      // Check if the year, month, and day are valid
      if (year >= 0 && month >= 1 && month <= 12 && day >= 1 && day <= getDaysInMonth(year, month)) {
        return true; // The date is valid
      } else {
        return false; // The date is invalid
      }
    } catch (e) {
      return false; // The date is invalid
    }
  }

  static int getDaysInMonth(int year, int month) {
    var date = DateTime(year, month, 1);
    var daysInMonth = 0;
    while (date.month == month) {
      daysInMonth++;
      date = date.add(Duration(days: 1));
    }
    return daysInMonth;
  }

  //Validate Date

  static easyOptionRequiredMargins(result) async {
    try {
      Dataconstants.reqMargins.clear();
      Dataconstants.copiedRequiredMargin.clear();
      for (var i = 0; i < result.scrips.length; i++) {
        ScripInfoModel? tempModel = CommonFunction.getScripDataModel(exchCode: result.scrips[i].scripCode, exch: "N");

        var requestBody = {
          "exchange": ["NFO"],
          "tradingsymbol": [result.scrips[i].scripCode],
          "netquantity": ["0"],
          "buyquantity": [result.scrips[i].buySell == BuySell.BUY ? tempModel!.minimumLotQty : "0"],
          "sellquantity": [result.scrips[i].buySell == BuySell.BUY ? "0" : tempModel!.minimumLotQty]
        };

        await Dataconstants.spanCalculator.getSpanCalculator(requestBody, false);

        Dataconstants.reqMargins.add(SpanCalculatorController.requiredMargin.value.toString());
      }
      Dataconstants.copiedRequiredMargin = List.from(Dataconstants.reqMargins);
    } catch (e, s) {
      print(e);
    }
  }

  static refreshToken(requestJson) async {
    http.Response response = await Dataconstants.itsClient
        .httpPostWithHeaderContentType(BrokerInfo.mainUrl + BrokerInfo.ApiVersion + "refresh-token", json.encode(requestJson));
    // //log("verify OTP response - ${response.body.toString()}");
    return response.body.toString();
  }
}