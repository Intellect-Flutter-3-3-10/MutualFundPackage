import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intellect_mutual_fund/screens/common_screens/common_screens.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../my_app_exports.dart';

class BestPerformingScreen extends StatefulWidget {
  const BestPerformingScreen({super.key});

  @override
  State<BestPerformingScreen> createState() => _BestPerformingScreenState();
}

class _BestPerformingScreenState extends State<BestPerformingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // DataConstants.exploreFundsController.fetchExploreFunds();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CommonAppBar(
        title: AppString.bestPerformingFund,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppDimens.appVPadding,
              horizontal: AppDimens.appHPadding,
            ),
            child: Obx(
              () {
                if (DataConstants.exploreFundsController.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                if (DataConstants.exploreFundsController.exploreFundList.isEmpty) {
                  return NoDataScreen();
                }
                if (DataConstants.exploreFundsController.errorMessage.value.isNotEmpty) {
                  return NoDataScreen(
                    title: "Error",
                    message: DataConstants.exploreFundsController.errorMessage.value,
                  );
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      separatorBuilder: (context, index) => const Padding(
                          padding: EdgeInsets.symmetric(
                        vertical: AppDimens.appSpacing10,
                      )),
                      itemBuilder: (context, index) {
                        return _bestPerformingFund(size, index);
                      },
                      itemCount: DataConstants.exploreFundsController.exploreFundList.length,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _bestPerformingFund(Size size, int index) {
    // var isLoading = exploreFundController.isLoading.value;
    var item = DataConstants.exploreFundsController.exploreFundList[index];
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoute.fundDetailScreen, arguments: FundDetailScreenArgs(item.schemeCode.toString()));
      },
      child: Container(
        width: size.width * 0.90,
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.04, // Adjust padding based on screen width
          vertical: size.height * 0.02, // Adjust padding based on screen height
        ),
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.greyLightest, width: 0.8),
          borderRadius: BorderRadius.circular(AppDimens.appRadius12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Container(
                //   height: size.height * 0.080, // Use a smaller fraction for smaller devices
                //   width: size.width * 0.15,
                //   decoration: BoxDecoration(
                //     border: Border.all(
                //       color: UtilsMethod().getColorBasedOnTheme(context).withOpacity(0.5),
                //     ),
                //     borderRadius: BorderRadius.circular(AppDimens.appRadius6),
                //   ),
                // ),

                CustomImageCard(
                  image: item.amcIcon ?? '',
                  height: size.height * 0.080,
                  width: size.width * 0.15,
                ),
                SizedBox(width: size.width * 0.025), // Dynamic spacing based on width
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        item.schemeName ?? "N/A",
                        style: AppTextStyles.regular15(
                          color: UtilsMethod().getColorBasedOnTheme(context),
                        ),
                        maxLines: 1, // Limit lines to prevent overflow
                      ),
                      AutoSizeText(
                        item.riskCategory ?? 'N/A',
                        style: AppTextStyles.regular12(
                          color: UtilsMethod().getColorBasedOnTheme(context),
                        ),
                        maxLines: 1,
                      ),
                      SizedBox(height: AppDimens.appSpacing5),
                      FittedBox(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Skeletonizer(
                              enabled: DataConstants.exploreFundsController.isLoading.value,
                              child: CustomChip(label: item.assetClass ?? 'N/A'),
                            ),
                            SizedBox(width: size.width * 0.02),
                            Skeletonizer(
                              enabled: DataConstants.exploreFundsController.isLoading.value,
                              child: CustomChip(label: item.schemeCategory ?? "N/A"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                ShowRatingWidget(rating: item.rating.toString()),
              ],
            ),
            SizedBox(height: AppDimens.appSpacing10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleAndValueWidget(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  isLoading: DataConstants.exploreFundsController.isLoading.value,
                  title: 'Min Amount',
                  value: item.aum.toString(),
                  valueColor: UtilsMethod().getColorBasedOnTheme(context),
                ),
                TitleAndValueWidget(
                  isLoading: DataConstants.exploreFundsController.isLoading.value,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  title: '1 Y Returns',
                  value: '${item.oneYear}%',
                  valueColor: Colors.green,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
