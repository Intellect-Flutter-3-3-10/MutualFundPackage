import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../my_app_exports.dart';


class HybridScreen extends StatefulWidget {
  const HybridScreen({super.key});

  @override
  State<HybridScreen> createState() => _HybridScreenState();
}

class _HybridScreenState extends State<HybridScreen> {
  List<bool>? _isSaved;
  bool isSipSelected = false;

  @override
  void initState() {
    super.initState();
    _isSaved = List.generate(5, (index) => false);
  }

  void _handleSave(int index) {
    setState(() {
      _isSaved![index] = !_isSaved![index];
    });
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.appHPadding, vertical: AppDimens.appVPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonHeader(
              title: 'Funds',
              actionLabel: '<1Y> Return',
              labelOnTap: () {},
              labelColor: UtilsMethod().getColorBasedOnTheme(context),
            ),
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
              itemCount: 5,
            ),
          ],
        ),
      ),
    );
  }

  Widget _fundsCard({int? index}) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.90,
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
                    width: size.width * 0.15,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: UtilsMethod().getColorBasedOnTheme(context).withOpacity(0.5),
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
                        style: AppTextStyles.regular15(
                          // color: AppColor.greyLight,
                        ),
                        maxLines: 1,
                      ),
                      AutoSizeText(
                        '- Growth Plan',
                        style: AppTextStyles.regular13(
                          // color: AppColor.greyLight,
                        ),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CommonIconButton(
                    onTap: () {
                      _handleSave(index);
                    },
                    isSvg: false,
                    icon: _isSaved![index!] ? Icons.bookmark : Icons.bookmark_border_outlined,
                    pictureIcon: AppImage.all,
                    iconColor: AppColor.blue,
                  ),
                  const ShowRatingWidget(
                    rating: '5',
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
            fgColor: AppColor.black,
            onTap: () {
              debugPrint("Bottom Sheet");
              _showBottomSheet();
            },
            btnText: AppString.invest,
          )
        ],
      ),
    );
  }

// bottom sheet

  void _showBottomSheet() {
    debugPrint("bottom sheet");
    UtilsMethod().showBottomSheet(
        context: context,
        child: Wrap(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: CommonOutlinedButton(
                    btnText: AppString.investWithSip,
                    onTap: () {
                      debugPrint("SIP");
                      setState(() {
                        isSipSelected = true;
                      });
                      Get.back(closeOverlays: true);
                      // Get.toNamed(
                      //   AppRoute.orderPlacementScreen,
                      //   arguments: OrderPlacementScreenArgs(isSip: isSipSelected),
                      // );
                    },
                  ),
                ),
                const SizedBox(width: AppDimens.appHPadding),
                Expanded(
                  child: CommonOutlinedButton(
                    btnText: AppString.lumpSum,
                    onTap: () {
                      debugPrint("Lumpsum");
                      setState(() {
                        isSipSelected = false;
                      });
                      Get.back(closeOverlays: true);
                      // Get.toNamed(
                      //   AppRoute.orderPlacementScreen,
                      //   arguments: OrderPlacementScreenArgs(isSip: isSipSelected),
                      // );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimens.appVPadding),
            AutoSizeText(
              AppString.sipDesc,
              style: AppTextStyles.regular13(),
            )
          ],
        ));
  }
}