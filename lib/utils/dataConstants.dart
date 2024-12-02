import 'package:dio/dio.dart';

class DataConstants {

  static var dio = Dio();
  static DateTime exchStartDate = new DateTime(1980, 1, 1, 0, 0, 0);
  static DateTime exchStartDateMCX = new DateTime(1970, 1, 1, 0, 0, 0);

  static Map<int, ExchData> exchData = {
    0: ExchData(exch: 'N', exchTypeShort: 'C'), //Nse Cash
    1: ExchData(exch: 'N', exchTypeShort: 'D'), //Nse Deriv
    2: ExchData(exch: 'B', exchTypeShort: 'C'), //Bse Cash
    3: ExchData(exch: 'C', exchTypeShort: 'D'), //Nse Currency
    4: ExchData(exch: 'E', exchTypeShort: 'D'), //Bse Curreny
    5: ExchData(exch: 'M', exchTypeShort: 'D'), //Mcx
    6: ExchData(exch: 'F', exchTypeShort: 'D'), //BSE Deriv
    7: ExchData(exch: 'G', exchTypeShort: 'C'), //Global Indices
    8: ExchData(exch: 'B', exchTypeShort: 'C'), //MutualFunds
  };
}