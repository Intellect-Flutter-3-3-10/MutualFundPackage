import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../../my_app_exports.dart';

class LatestFundReleaseScreen extends StatefulWidget {
  const LatestFundReleaseScreen({super.key});

  @override
  State<LatestFundReleaseScreen> createState() => _LatestFundReleaseScreenState();
}

class _LatestFundReleaseScreenState extends State<LatestFundReleaseScreen> {
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
            child: Column(
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
                      return _fundsCard(size);
                    },
                    itemCount: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _fundsCard(Size size) {
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CommonIconButton(
                    onTap: () {},
                    isSvg: false,
                    icon: Icons.bookmark_border_outlined,
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
            onTap: () {
              debugPrint("Bottom Sheet");
              // _showBottomSheet();
            },
            btnText: AppString.invest,
          )
        ],
      ),
    );
  }
}
