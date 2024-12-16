import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../my_app_exports.dart';

class InvestmentScreen extends StatefulWidget {
  const InvestmentScreen({super.key});

  @override
  State<InvestmentScreen> createState() => _InvestmentScreenState();
}

class _InvestmentScreenState extends State<InvestmentScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppDimens.appVPadding,
          horizontal: AppDimens.appHPadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonHeader(
              title: AppString.myInvestments,
              actionLabel: "Sort",
              labelColor: AppColor.greyLightest,
              isTrailingIcon: true,
              labelOnTap: () {},
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return _fundsCard(index: index);
              },
              separatorBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.symmetric(
                vertical: AppDimens.appSpacing10,
              )),
              itemCount: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _fundsCard({int? index}) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        debugPrint("");
        UtilsMethod().navigateTo(context, AppRoute.fundDetailScreen, args: FundDetailScreenArgs("item.schemeCode.toString()"));
      },
      child: CommonOutLinedContainer(
        borderColor: AppColor.greyLightest,
        bgColor: AppColor.white,
        borderRadius: AppDimens.appRadius6,
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
                      width: size.width * 0.15,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColor.greyLight.withOpacity(0.5),
                          ),
                          borderRadius: BorderRadius.circular(AppDimens.appRadius6)),
                    ),
                    const SizedBox(
                      width: AppDimens.appSpacing10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AutoSizeText(
                          'LIC MF Infrastructure Fund',
                          style: AppTextStyles.regular15(
                            color: AppColor.greyLight,
                          ),
                          maxLines: 1,
                        ),
                        const SizedBox(
                          height: AppDimens.appSpacing10,
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
                  title: AppString.minAmount,
                  value: '10,000',
                ),
                TitleAndValueWidget(
                  isHorizontal: true,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  title: AppString.returns,
                  value: '71.76%',
                  valueColor: Colors.green,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
