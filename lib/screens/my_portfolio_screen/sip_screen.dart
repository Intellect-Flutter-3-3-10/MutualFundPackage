import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../my_app_exports.dart';

class SipScreen extends StatefulWidget {
  const SipScreen({super.key});

  @override
  State<SipScreen> createState() => _SipScreenState();
}

class _SipScreenState extends State<SipScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
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
              title: AppString.mySip,
              actionLabel: "Sort",
              labelColor: AppColor.greyLight,
              isTrailingIcon: true,
              labelOnTap: () {},
            ),
            ListView.separated(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return MyPortFolioSipListCard(
                  name: "LIC MF infrastructure Fund",
                  sipAmount: '1000',
                  month: 'Dec',
                  date: '12',
                  onTap: () {
                    // Get.toNamed(AppRoute.fundDetailScreen);
                  },
                );
              },
              separatorBuilder: (context, index) => const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: AppDimens.appSpacing10,
                ),
              ),
              itemCount: 20,
            ),
          ],
        ),
      ),
    );
  }
}
