import 'package:http/http.dart';

enum Broker {
  ajmera,
  // icici,
}

class BrokerInfo {
  static Broker? client;
  static String? brokerName, appName;
  static List<String>? servers;
  static String forgotPasswordLink = '';
  static String loadBalancerLink = '';
  static String _fundsPayInLink = '';
  static String _fundsPayOutLink = '';
  static String hotKeyLink = '';
  static String homeLink = '';
  static String pledgeLink = '';
  static String unPledgeLink = '';
  static String successLink = '';
  static String helpUs = '';
  static String createAccountLink = '';
  static String createAccountLink2 = '';
  static String userguideLink = '';
  static String videoguideLink = '';
  static String backOfficeLink = '';
  static String privacyPolicyLink = '';
  static String disclaimerLink = '';
  static String faqLink = '';
  static String nseLink = '';
  static String bseLink = '';
  static String unlockAccountLink = '';
  static String mcxLink = '';
  static String sebiLink = '';
  static String address = '';
  static String address1 = '';
  static String address2 = '';
  static String address3 = '';
  static String phone = '';
  static String email = '';
  static String forgotLoginLink = '';
  static String linkLabel1 = '';
  static String website = '';
  static String linkLabel2 = '';
  static String productName = '';
  static String productName1 = '';
  static String productName2 = '';
  static String productName3 = '';
  static String smsLINK = '';
  static String encryption = '';
  static String onBoardingFrom = "";
  static String moneyUrlScheme = 'https://icicimoney.page.link/dashboard';

  // static String masterUrl  = "https://bigul.s3.ap-south-1.amazonaws.com/mastercsv.zip";
  static String masterUrl = "https://bigul.s3.ap-south-1.amazonaws.com/CSVFormat/mastercsv.zip";
  static String iLearnApp = 'https://icicieducation.page.link/zRx8';
  static String commoditiesLink = '';
  static String moneyAppPlaystoreLink = 'https://play.google.com/store/apps/details?id=com.icici.direct&hl=en_IN&gl=US';
  static String moneyAppAppstoreLink = 'https://apps.apple.com/in/app/icicidirect-money/id1544266409';
  static String contactUsEscalationLink = 'https://www.icicidirect.com/mailimages/Escalation_Matrix.pdf';
  static String home = 'https://www.icicidirect.com/fno-execution';
  static String tWAPOrderSlicing = 'https://www.icicidirect.com/twap-order-slicing';
  static String tWAPriceBand = 'https://www.icicidirect.com/twap-price-band';
  static String averaging = 'https://www.icicidirect.com/fno-execution-averaging';
  static String smallchart = "https://bigulint.bigul.co/chart/api/chart/symbol15minchartdata";

  //static String normalchart = "https://bigulint.bigul.co/chart/api/chart/symbolhistoricaldata/";
  static String normalchart = "http://103.174.106.31/chart2/api/chart/symbolhistoricaldata/";
  static String mutualFundsLink = '', referEarnLink = '';
  static bool isManuallyLogout = false;
  static const timeoutDuration = const Duration(seconds: 20);
  static int algoVersion = 3;
  static String masterdate = "https://bigulint.bigul.co/read-masters/api/MasterDate";

  // static String spanMarginurl = "http://180.149.242.215:82/SpanMargincal/Spanapi/EasyOptionSpanMarginCal";
  static String spanMarginurl = "https://trade.ajmeraxchange.co.in/RequiredMarginAPI/Spanapi/EasyOptionSpanMarginCal";
  static String basketMarginurl = "https://trade.ajmeraxchange.co.in/RequiredMarginAPI/Spanapi/SpanBasketMarginCal";

  static String riskdisclosures =
      'https://www.sebi.gov.in/reports-and-statistics/research/jan-2023/study-analysis-of-profit-and-loss-of-individual-traders-dealing-in-equity-fando-segment_67525.html';
  static String notificationLink = "";
  static String edisLink = "";
  static String smartodrlink = '';
  static bool isAlice = false;
  static String ApiVersion = "api/v2/";
  static String Addfundsurl = "https://trade.ajmeraxchange.co.in/OnlinePayment/Payment/GenerateQR";

  // static String algoUrl = "https://bigulint.bigul.app/algo";
  // static String sipMainUrlBase = "https://bigulint.bigul.app/";
  //https://bigulint.bigul.co/middleware
  // static String termscondition = "https://bigul.co/en/index.php/terms-and-conditions/kyc-terms-and-conditions/";
  // static String flashTradeLink = "https://bigulint.bigul.app/tools/Instruction/api/flash/";
  // static String flashTradeReportLink = "https://bigulint.bigul.app/tools/Report/api/flash/";

  //####################### Global ##########################################

  static String LiveURL = "https://trade.ajmeraxchange.co.in/middleware/api/v2/";

  // static String UATURL = "https://bigulint.bigul.app/middleware/api/v2/";
  static String UATURL = "http://120.138.100.202:9190/middleware/api/v2/";
  static String baseUrlUAT = "https://trade.ajmeraxchange.co.in/";
  static String baseUrlLive = "https://trade.ajmeraxchange.co.in/";
  static String notificationurllive = "https://trade.ajmeraxchange.co.in/";
  static String baseUrl = baseUrlLive;

  //################## Live URL ########################################

  static String mainUrl = LiveURL;
  static String algoUrl = "https://trade.ajmeraxchange.co.in/algo";
  static String sipMainUrlBase = "https://trade.ajmeraxchange.co.in/";
  static String flashTradeReportLink = "https://trade.ajmeraxchange.co.in/tools/Report/api/flash/";
  static String flashTradeLink = "https://trade.ajmeraxchange.co.in/tools/Instruction/api/flash/";

  // static String paymentGetway = "https://trade.ajmeraxchange.co.in/PaymentGateway/PaymentRequest_mobile.aspx?UID=${Dataconstants.feUserID}";
  static String edisUrl = "https://trade.ajmeraxchange.co.in/clientEdis";
  static String termscondition = "https://trade.ajmeraxchange.co.in/en/index.php/terms-and-conditions/kyc-terms-and-conditions/";
  static String eKycBrowserLink = "https://trade.ajmeraxchange.co.in/open-account/?utm_source=mobileapp1&utm_medium=newmobileapp";
  static String pledge = '';

  // "https://trade.ajmeraxchange.co.in/pledge-details?client_code=${Dataconstants.feUserID}&key=mEnpsshIYXIp1JXQlsKwRivtyCykdpzH11+/0/dAvAs";
  // static String ipoLink = "https://trade.ajmeraxchange.co.in/IPO/IPO/IPOLIST?ClientCode=${Dataconstants.feUserID}";
  // static String payOut = "https://trade.ajmeraxchange.co.in/PaymentGateway/PaymentRequest_mobile.aspx?UID=";
  // static String bigulWebLink = "https://trade.ajmeraxchange.co.in";
  //####################################### UAT Url #########################################//
  // //
  // static String mainUrl = UATURL;
  // static String algoUrl = "http://120.138.100.202/algo";
  // static String sipMainUrlBase = "http://120.138.100.202/";
  // static String flashTradeReportLink = "http://120.138.100.202/tools/Report/api/flash/";
  // static String flashTradeLink = "http://120.138.100.202/tools/Instruction/api/flash/";
  // static String paymentGetway = "https://trade.ajmeraxchange.co.in/PaymentGateway/PaymentRequest_mobile.aspx?UID=";
  // static String edisUrl = "https://trading.bigul.app/clientEdis";
  // static String termscondition = "https://bigul.app/en/index.php/terms-and-conditions/kyc-terms-and-conditions/";
  // static String eKycBrowserLink = "https://bigul.app/open-account/?utm_source=mobileapp1&utm_medium=newmobileapp";
  // static String pledge =   "https://bigul.APP/pledge-details?client_code=${Dataconstants.feUserID}&key=mEnpsshIYXIp1JXQlsKwRivtyCykdpzH11+/0/dAvAs";
  // static String ipoLink = "https://bigulint.bigul.app/IPO/IPO/IPOLIST?ClientCode=${Dataconstants.feUserID}";
  // static String payOut = "https://trade.ajmeraxchange.co.in/PaymentGateway/PaymentRequest_mobile.aspx?UID=";
  ///old in bigul
  static String bigulWebLink = "https://www.bigul.co";

  static void setClientInfo(Broker selectedClient) async {
    client = selectedClient;
    switch (client) {
      case Broker.ajmera:
        brokerName = 'Ajmera';
        appName = 'Ajmera x-change';
        servers = [
          "trade.ajmeraxchange.co.in",
        ];
        notificationurllive = 'https://trade.ajmeraxchange.co.in/SNNotification/api/Test/FetchUserNotificationByTypeId';
        notificationLink = 'https://trade.ajmeraxchange.co.in/SNNotification/api/Test/FetchUserNotificationByTypeId';
        privacyPolicyLink = 'https://www.ajmeraxchange.co.in/privacypolicy';
        createAccountLink = 'https://www.ajmeraxchange.co.in/#login';
        mutualFundsLink = 'https://www.ajmeraxchange.co.in/services/mutualfund-distribution/mutualfund';
        commoditiesLink = 'https://www.ajmeraxchange.co.in/services/commoditybroking';
        pledgeLink = 'https://trade.ajmeraxchange.co.in/MPI_CDSL/OrderRequest/OrderRequest?UID=';
        unPledgeLink = 'https://trade.ajmeraxchange.co.in/MPI_CDSL/Unpledge/Unpledge?UID=';
        successLink = 'https://trade.ajmeraxchange.co.in/MPI_CDSL/Transactiondetails/Transactiondetails?UID=';
        edisLink = 'https://trade.ajmeraxchange.co.in/eDIS/Live/Live?UID=';
        smartodrlink = "https://smartodr.in/login";
        forgotPasswordLink = 'https://trade.ajmeraxchange.co.in/forgotpassword/';
        _fundsPayInLink = 'https://trade.ajmeraxchange.co.in/PaymentGateway/PaymentRequest_mobile.aspx?UID=';
        _fundsPayOutLink = 'https://trade.ajmeraxchange.co.in/PaymentGateway/PaymentRequest_mobile.aspx?UID=';
        homeLink = 'https://www.ajmeraxchange.co.in/';
        // ipoLink = 'https://www.ajmeraxchange.co.in/EIPO/online-ipo';
        break;
      case null:
      // TODO: Handle this case.
    }
    // Dataconstants.eodIP = servers![0];
    // Dataconstants.iqsIP = servers![0];
  }

  /* static Future<bool> fetchEncryption() async {
    setClientInfo(client!);
    String? request, requestPayIn, requestBackoffice;
    switch (client) {
      case Broker.ajmera:
        request = 'https://trade.ajmeraxchange.co.in/encryption/Handler.ashx/EncryptUserIdForEDIS?UserId=${Dataconstants.feUserID}';
        requestBackoffice = 'https://trade.ajmeraxchange.co.in/Backoffice/handler.ashx/GetBOLink?Clientcode=${Dataconstants.feUserID}';
        break;

      default:
        request = 'http://180.149.242.215:81/Handler.ashx/EncryptUserIdForEDIS?UserId=${Dataconstants.feUserID}';
    }
    if (request != null) {
      var response = await get(Uri.parse(request));
      if (response.statusCode == 200) {
        encryption = response.body;
        switch (client) {
          case Broker.ajmera:
            edisLink += '$encryption';
            pledgeLink += '$encryption';
            unPledgeLink += '$encryption';
            successLink += '$encryption';
            break;
          default:
        }
      } else {
        print('Failed to load encryption');
      }
    }
    if (requestBackoffice != null) {
      var response = await get(Uri.parse(requestBackoffice));
      if (response.statusCode == 200) {
        encryption = response.body;
        switch (client) {
          case Broker.ajmera:
            backOfficeLink = encryption;
            break;
          default:
        }
      } else {
        print('Failed to load encryption');
      }
    }

    if (requestPayIn != null) {
      var response = await get(Uri.parse(requestPayIn));
      if (response.statusCode == 200) {
        encryption = response.body;
        switch (client) {
          case Broker.ajmera:
            _fundsPayInLink += '$encryption';
            _fundsPayOutLink += '$encryption';
            break;
          default:
        }
      } else {
        print('Failed to load encryption');
      }
    }

    return true;
  }*/

  static String get primaryLogo => 'assets/images/logo/ajmera.png';
}
