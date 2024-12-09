// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intellect_mutual_fund/utils/broker_info.dart';
// import 'package:intellect_mutual_fund/utils/dataConstants.dart';
// import 'package:path_provider/path_provider.dart' as path;
//
// import '../my_app_exports.dart';
//
// class DatabaseHelperCSV extends GetxController {
//   static int masterDateDB = 0;
//   static var docpath;
//
//   @override
//   onInit() {
//     super.onInit();
//   }
//
//   static getPath() async {
//     docpath = await path.getApplicationSupportDirectory();
//   }
//
//   static List<Map<String, dynamic>> dbReading({
//     required String fileContents,
//     bool isDeriv = false,
//   }) {
//     // Helper function to process the data
//     List<Map<String, dynamic>> _processLines(List<String> lines, bool isDeriv) {
//       List<Map<String, dynamic>> dataList = [];
//
//       // Split the headers once and trim them
//       List<String> headers = lines[0].split(',').map((header) => header.trim()).toList();
//       int dateTime = DateUtil.getIntFromDate1Chart(DateTime.now().toString());
//
//       for (int i = 1; i < lines.length; i++) {
//         List<String> dataRow = lines[i].split(',').map((value) => value.trim()).toList();
//
//         Map<String, dynamic> mappedData = {for (int j = 0; j < headers.length; j++) headers[j]: _convertValue(dataRow[j])};
//
//         if (!isDeriv || mappedData["ExpiryDate"] == 0 || mappedData["ExpiryDate"] == -1) {
//           dataList.add(mappedData);
//         } else {
//           // Process only if expiry date is valid
//           var instructionDate = DateUtil.getAnyFormattedExchDate(mappedData["ExpiryDate"], "dd-MMM-yyyy hh:mm:ss");
//           var dbExpiryDate = DateUtil.getIntFromDate1(instructionDate);
//
//           if (dbExpiryDate >= dateTime) {
//             dataList.add(mappedData);
//           }
//         }
//       }
//
//       return dataList;
//     }
//
//     // Error handling with crash reporting
//     try {
//       // Split file contents into lines and trim leading/trailing spaces
//       List<String> lines = fileContents.trim().split('\n');
//
//       // Process the lines and return the result
//       return _processLines(lines, isDeriv);
//     } catch (e, s) {
//       // Log error to Firebase Crashlytics (or any other error reporting system)
//       // print("$e, $s");
//
//       // Return an empty list in case of an error
//       return [];
//     }
//   }
//
//   // Helper function to convert string to number if possible
//   static dynamic _convertValue(String value) {
//     if (value.isEmpty) return null;
//     if (value.contains('.') && double.tryParse(value) != null) {
//       return double.parse(value);
//     } else if (int.tryParse(value) != null) {
//       return int.parse(value);
//     }
//     return value;
//   }
//
//   static void checkMasters() async {
//     try {
//       String? masterDateServer;
//       if (masterDateDB != 0) {
//         masterDateServer = await CommonFunction.getMasterServerDate();
//       }
//
//       if (masterDateDB == 0 || masterDateDB == 0 || masterDateServer == null || masterDateServer.isEmpty) {
//         //TODO : Cleanup the existing sql
//         loadFreshMasters();
//         return;
//       }
//
//       int dateTimeServer = DateUtil.getIntFromDate2Chart(masterDateServer);
//       if (masterDateDB < dateTimeServer) {
//         loadFreshMasters();
//       } else {}
//     } catch (e, s) {
//       // print("$e, $s");
//       print("$e, $s");
//     } finally {}
//   }
//
//   static Future<Response> downloadMasters() async {
//     try {
//       var response = await DataConstants.dio
//           .get(
//             BrokerInfo.masterUrl,
//             onReceiveProgress: showDownloadProgress,
//             // options: Options(
//             //   responseType: ResponseType.bytes,
//             //   followRedirects: false,
//             //   validateStatus: (status) => status != null && status < 500,
//             //   headers: {
//             //     "User-Agent":
//             //         "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36"
//             //   },
//             // ),
//           )
//           .onError((error, stackTrace) => onError(error, stackTrace));
//
//       return response;
//     } catch (e, s) {
//       // print("$e, $s");
//       print("$e, $s");
//       // Re-throw the error after logging
//       rethrow;
//     } finally {}
//   }
//
//   static Future<bool> loadFreshMasters() async {
//     try {
//       final response = await downloadMasters();
//       bool extractionSuccess = await extract7zFile(response.data);
//
//       if (extractionSuccess) {
//         await getAllScripDetailFromMemory(sendProgressResponse, true);
//         GetStorageData.write("isMasterDownloaded", true);
//         return true;
//       } else {
//         CommonFunction.showBasicToast('Extraction failed');
//       }
//       return false;
//     } catch (e, s) {
//       print("$e, $s");
//       print("$e, $s");
//       return false;
//     } finally {}
//   }
//
//   static Future<void> getMutualFunds() async {
//     try {
//       final filePath = path.join(docpath.path, "MFMasterDetails.csv");
//       // Read the file
//       final file = File(filePath);
//       if (await file.exists()) {
//         // Read the contents of the file as a string
//         String fileContents = await file.readAsString();
//         List<Map<String, dynamic>> dataList = dbReading(fileContents: fileContents);
//         DataConstants.exchData[8]!.addAllMFData(dataList);
//       } else {
//         debugPrint('File not found: $filePath');
//         GetStorageData.write("isMasterDownloaded", false);
//       }
//     } catch (e, s) {
//       print("$e, $s");
//     }
//   }
//
//   static bool getAllScripDetailFromMemory(sendProgressResponse, bool isMasterDownload) {
//     try {
//       // DatabaseHelperCSV.getMasterDate();
//       // DatabaseHelperCSV.getMemberData();
//       // DatabaseHelperCSV.getGroupData();
//       // DatabaseHelperCSV.getNseEquityData();
//       // DatabaseHelperCSV.getBseEquityData();
//       // DatabaseHelperCSV.getNseDerivData();
//       // DatabaseHelperCSV.getNseCurrData();
//       // DatabaseHelperCSV.getBseCurrData();
//       // DatabaseHelperCSV.getGlobalIndices();
//       DatabaseHelperCSV.getMutualFunds();
//       // DatabaseHelperCSV.getMCXDerivData();
//     } catch (e, s) {
//       // print("$e, $s");
//       print("$e, $s");
//     }
//     return true;
//   }
//
//   static Future<bool> extract7zFile(List<int> bytes) async {
//     try {
//       final archive = ZipDecoder().decodeBytes(bytes);
//       final dbFile = File(path.join(docpath.path, "mastercsv.zip"));
//
//       if (await dbFile.exists()) {
//         await dbFile.delete();
//       }
//
//       for (final file in archive) {
//         final filePath = path.join(docpath.path, file.name);
//
//         if (file.isFile) {
//           // Ensure the directory exists
//           //File: '/data/user/0/com.axis.login/files/mastercsv/Members.csv'
//           await Directory(path.dirname(filePath)).create(recursive: true);
//           final isthere = File(filePath);
//           if (await isthere.exists()) {
//             await isthere.delete();
//           }
//           // Write the file content
//           final data = file.content as List<int>;
//           await File(filePath).writeAsBytes(data);
//         } else {
//           // Create the directory if it's not a file
//           await Directory(filePath).create(recursive: true);
//         }
//       }
//       return true;
//     } catch (e, s) {
//       print("$e, $s");
//       return false;
//     }
//   }
//
//   static void showDownloadProgress(int received, int total) {
//     // try {
//     //   if (total != -1) {
//     //     setState(() {
//     //       Dataconstants.progressvalue = received / total;
//     //     });
//     //   }
//     // } catch (e) {}
//     // Implement progress handling as needed
//     // This method is called during the download progress
//   }
//
//   static void sendProgressResponse(double v) {
//     // try {
//     //   setState(() {
//     //     Dataconstants.progressvalue = v;
//     //   });
//     // } catch (e) {}
//   }
// }
//
// class Options {}
