import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intellect_mutual_fund/widgets/widgets.dart';

import '../res/res.dart';

class MyPortFolioSipListCard extends StatelessWidget {
  final String? image;
  final String? name;
  final String? sipAmount;
  final String? date;
  final String? month;
  final Function()? onTap;

  const MyPortFolioSipListCard({
    super.key,
    this.image,
    this.name,
    this.sipAmount,
    this.date,
    this.month,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CommonOutLinedContainer(
      bgColor: Theme.of(context).scaffoldBackgroundColor,
      borderColor: AppColor.greyLightest,
      borderRadius: AppDimens.appRadius6,
      vPadding: AppDimens.appSpacing10,
      hPadding: AppDimens.appSpacing10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    height: size.height * 0.050,
                    width: size.width * 0.08,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColor.greyLightest.withOpacity(0.5),
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
                        name ?? 'N/A',
                        style: AppTextStyles.regular15(
                            // color: AppColor.greyLight,
                            ),
                        maxLines: 1,
                      ),
                      Row(
                        children: [
                          AutoSizeText(
                            'Sip Amount ',
                            style: AppTextStyles.regular13(
                                // color: AppColor.greyLightest,
                                ),
                            maxLines: 1,
                          ),
                          AutoSizeText(
                            ' ${AppString.rupees}$sipAmount',
                            style: AppTextStyles.semiBold13(
                                // color: AppColor.greyLight,
                                ),
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                width: 5,
              ),
              CustomDateChip(
                date: date,
                month: month,
              )
            ],
          ),
        ],
      ),
    );
  }
}
