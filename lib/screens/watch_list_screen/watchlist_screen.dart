import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intellect_mutual_fund/screens/common_screens/common_screens.dart';
import '../../my_app_exports.dart';

class WatchListScreen extends StatefulWidget {
  const WatchListScreen({super.key});

  @override
  State<WatchListScreen> createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> with SingleTickerProviderStateMixin {
  List<bool>? _isSaved;
  Timer? _timer; // For example, a Timer
  int _counter = 0;

  List<String> watchListData = [];

  @override
  void initState() {
    super.initState();
    DataConstants.watchListController.fetchWatchList(userId: '1234');

    DataConstants.watchListController.watchList.listen((watchListData) {
      if (watchListData.data != null && watchListData.data!.isNotEmpty) {}
    });
  }

  void _handleSave(int index) {
    setState(() {
      _isSaved![index] = !_isSaved![index];
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("CLIENT CODE >>>>>>  ${DataConstants.globalController.clientCode}");
    debugPrint("Fund List COUNT >>>>>>  ${DataConstants.exploreFundsController.exploreFundList.length}");
    debugPrint("Fund List COUNT >>>>>>  ${DataConstants.exploreFundsController.exploreFundList.length}");

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CommonAppBar(
        isBackButton: true,
        title: AppString.myWatchList,
        leadingAction: () {
          DataConstants.globalController.navigatorKey?.currentState?.pop();
        },
        action: [
          IconButton(
            onPressed: () {
              UtilsMethod().navigateTo(context, AppRoute.searchScreen);
            },
            icon: Icon(
              Icons.search,
              color: UtilsMethod().getColorBasedOnTheme(context),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppDimens.appVPadding,
              horizontal: AppDimens.appHPadding,
            ),
            child: Obx(() {
              if (DataConstants.watchListController.filteredFundList == null) {
                return Center(child: CircularProgressIndicator.adaptive());
              }
              if (DataConstants.watchListController.errorGetWatchlist.value.isNotEmpty) {
                return Center(
                  child: Text(
                    DataConstants.watchListController.errorGetWatchlist.value,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                );
              }
              if (DataConstants.watchListController.filteredFundList.isEmpty) {
                return NoDataScreen();
              }

              _isSaved ??=
                  List.generate(DataConstants.watchListController.filteredFundList.length, (index) => true); // update bool list for save toggle
              return ListView.separated(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                separatorBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.symmetric(vertical: AppDimens.appSpacing10),
                ),
                itemBuilder: (context, index) {
                  return _fundsCard(size: size, index: index);
                },
                itemCount: DataConstants.watchListController.filteredFundList.length,
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _fundsCard({Size? size, required int index}) {
    var data = DataConstants.watchListController.filteredFundList[index];
    return GestureDetector(
      onTap: () {
        // UtilsMethod().navigateTo(context, AppRoute.fundDetailScreen, args: FundDetailScreenArgs("item.schemeCode.toString()"));
        UtilsMethod().navigateTo(context, AppRoute.fundDetailScreen, args: FundDetailScreenArgs(data.schemeCode.toString()));
      },
      child: Container(
        width: size!.width * 0.90,
        // padding: const EdgeInsets.symmetric(horizontal: AppDimens.appSpacing15, vertical: AppDimens.appSpacing15),
        // decoration:
        //     BoxDecoration(border: Border.all(color: AppColor.greyLightest, width: 0.8), borderRadius: BorderRadius.circular(AppDimens.appRadius12)),
        child: CommonOutLinedContainer(
          bgColor: Colors.transparent,
          borderColor: AppColor.greyLightest,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        CustomImageCard(
                          image: data.amcIcon ?? "",
                          height: size.height * 0.080,
                          width: size.width * 0.17,
                        ),
                        SizedBox(
                          width: size.height * 0.010,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AutoSizeText(
                                data.schemeName ?? 'N/A',
                                style: AppTextStyles.regular15(),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                                maxLines: 2,
                              ),
                              AutoSizeText(
                                data.riskCategory ?? "N/A",
                                style: AppTextStyles.regular13(),
                                maxLines: 1,
                              ),
                              FittedBox(
                                child: Row(
                                  children: [
                                    CustomChip(
                                      label: data.assetClass ?? 'N/A',
                                    ),
                                    SizedBox(
                                      width: AppDimens.appSpacing10,
                                    ),
                                    CustomChip(
                                      label: data.schemeCategory ?? 'N/A',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CommonIconButton(
                        onTap: () async {
                          _handleSave(index);
                          await DataConstants.watchListController.deleteWatchListRecord(id: data.id ?? 0, context: context);
                          await DataConstants.watchListController.fetchWatchList(userId: '1234');
                        },
                        isSvg: false,
                        // icon: _isSaved![index] ? Icons.bookmark : Icons.bookmark_border_outlined,
                        icon: Icons.highlight_remove,
                        toolTip: "Remove",
                        pictureIcon: AppImage.all,

                        iconColor: AppColor.red,
                      ),
                      ShowRatingWidget(
                        rating: data.rating.toString() ?? '0',
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: AppDimens.appSpacing10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TitleAndValueWidget(
                    isHorizontal: true,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    title: 'AUM',
                    value: "${data.aum.toString()} Cr" ?? 'N/A',
                  ),
                  TitleAndValueWidget(
                    isHorizontal: true,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    title: '1 Y Returns',
                    value: '${data.oneYear}%',
                    valueColor: Colors.green,
                  ),
                ],
              ),
              const SizedBox(height: AppDimens.appSpacing10),
              //row end
              CommonOutlinedButton(
                height: size.height * 0.030,
                fgColor: AppColor.black,
                onTap: () {
                  debugPrint("Bottom Sheet");
                },
                btnText: AppString.invest,
              ),
            ],
          ),
        ),
      ),
    );
  }

// void addToWatchList(int index, AddToWatchLisModel model) {
//   var data = AddToWatchLisModel(
//     userId: globalController.clientCode.toString(),
//     schemeCodes: watchListData,
//   );
//
//   controller.addToWatchlist(data);
// }
}
