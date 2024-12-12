import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../my_app_exports.dart';

class ClosedFundScreen extends StatefulWidget {
  const ClosedFundScreen({super.key});

  @override
  State<ClosedFundScreen> createState() => _ClosedFundScreenState();
}

class _ClosedFundScreenState extends State<ClosedFundScreen> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppDimens.appVPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListView.separated(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                separatorBuilder: (context, index) => const Padding(
                        padding: EdgeInsets.symmetric(
                      vertical: AppDimens.appSpacing10,
                    )),
                itemBuilder: (context, index) {
                  return _fundsCard(index: index);
                },
                itemCount: 5),
          ],
        ),
      ),
    );
  }

  Widget _fundsCard({int? index}) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoute.fundDetailScreen, arguments: FundDetailScreenArgs("item.schemeCode.toString()"));
      },
      child: Container(
        width: size.width * 0.76,
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.appSpacing15, vertical: AppDimens.appSpacing15),
        decoration:
            BoxDecoration(border: Border.all(color: AppColor.greyLightest, width: 0.8), borderRadius: BorderRadius.circular(AppDimens.appRadius12)),
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
                Row(
                  children: [
                    Container(
                      height: size.height * 0.080,
                      width: size.width * 0.16,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColor.greyLightest.withOpacity(0.5),
                          ),
                          borderRadius: BorderRadius.circular(AppDimens.appRadius6)),
                    ),
                    SizedBox(
                      width: size.height * 0.010,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'LIC MF Infrastructure Fund',
                          style: AppTextStyles.regular15(),
                        ),
                        Text(
                          '- Growth Plan',
                          style: AppTextStyles.regular13(),
                        ),
                        Row(
                          // mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: const [
                                CustomChip(
                                  label: 'Equity',
                                ),
                                SizedBox(
                                  width: AppDimens.appSpacing10,
                                ),
                                CustomChip(
                                  label: 'Mid Cap',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
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
              children: const [
                TitleAndValueWidget(
                  isHorizontal: true,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  title: 'Min Amount',
                  value: '10,000',
                ),
                TitleAndValueWidget(
                  isHorizontal: true,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  title: '1 Y Returns',
                  value: '71.76%',
                  valueColor: Colors.green,
                ),
              ],
            ),
            const SizedBox(height: AppDimens.appSpacing10),
            //row end
            CommonOutlinedButton(
              height: size.height * 0.030,
              onTap: () {
                debugPrint("Bottom Sheet");
                // _showBottomSheet();
              },
              btnText: AppString.clone,
            )
          ],
        ),
      ),
    );
  }
}
