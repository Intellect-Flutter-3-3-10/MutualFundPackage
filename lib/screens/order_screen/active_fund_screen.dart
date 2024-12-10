import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../my_app_exports.dart';

class ActiveFundScreen extends StatefulWidget {
  const ActiveFundScreen({super.key});

  @override
  State<ActiveFundScreen> createState() => _ActiveFundScreenState();
}

class _ActiveFundScreenState extends State<ActiveFundScreen> {
  OrdersController ordersController = Get.put(OrdersController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ordersController.getActiveOrders('G000001');
  }

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
            Obx(
              () {
                if (ordersController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }

                if (ordersController.errorMessage.value.isNotEmpty) {
                  return Center(child: Text(ordersController.errorMessage.value));
                }
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => const Padding(
                      padding: EdgeInsets.symmetric(
                    vertical: AppDimens.appSpacing10,
                  )),
                  itemBuilder: (context, index) {
                    return _fundsCard(index: index);
                  },
                  itemCount: ordersController.activeOrderList.length,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _fundsCard({int? index}) {
    var item = ordersController.activeOrderList[index!];
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoute.fundDetailScreen);
      },
      child: Container(
        width: size.width * 0.76,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.appSpacing15,
          vertical: AppDimens.appSpacing15,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.greyLightest, width: 0.8),
          borderRadius: BorderRadius.circular(
            AppDimens.appRadius12,
          ),
        ),
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
                        AutoSizeText(
                          'LIC MF Infrastructure Fund',
                          style: AppTextStyles.regular15(),
                          maxLines: 1,
                        ),
                        AutoSizeText(
                          '- Growth Plan',
                          style: AppTextStyles.regular13(),
                          maxLines: 1,
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
            FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TitleAndValueWidget(
                    isHorizontal: true,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    title: AppString.oneYearReturn,
                    value: '52.4(11.95%)',
                    titleSize: 10,
                    valueSize: 11.5,
                    titleStyle: AppTextStyles.semiBold13(),
                    valueStyle: AppTextStyles.regular14(color: AppColor.green),
                    isLeadingIcon: true,
                    icon: Icons.arrow_upward,
                    valueColor: AppColor.green,
                    iconColor: AppColor.green,
                    iconSize: 18,
                  ),
                  SizedBox(
                    width: size.width * 0.015,
                  ),
                  TitleAndValueWidget(
                    isHorizontal: true,
                    isLeadingIcon: false,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    title: AppString.amount,
                    titleStyle: AppTextStyles.semiBold13(),
                    valueStyle: AppTextStyles.regular14(/*color: AppColor.red*/),
                    value: '${AppString.rupees} 1000',
                    titleSize: 12,
                    valueSize: 12.5,
                    icon: Icons.arrow_downward,
                    // iconColor: AppColor.red,
                    iconSize: 18,
                  ),
                ],
              ),
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
