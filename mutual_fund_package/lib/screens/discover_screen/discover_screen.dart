import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intellect_mutual_fund/my_app_exports.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final CarouselSliderController _carouselSliderController = CarouselSliderController();
  final items = [
    SvgPicture.asset(AppImage.banner1, width: double.infinity),
    SvgPicture.asset(AppImage.banner2, width: double.infinity),
    SvgPicture.asset(AppImage.banner3, width: double.infinity),
  ];

  int currentIndex = 0;

  List<String> bannerImg = [
    AppImage.banner1,
    AppImage.banner2,
    AppImage.banner3,
  ];

  List<String> quickAction = [
    AppImage.all,
    AppImage.largeCap,
    AppImage.midCap,
    AppImage.smallCap,
    AppImage.largeAndMid,
    AppImage.debt,
    AppImage.hybrid,
    AppImage.elss,
  ];

  List<String> label = [
    AppString.all,
    AppString.largeCap,
    AppString.midCap,
    AppString.smallCap,
    AppString.largeAndMid,
    AppString.debt,
    AppString.hybrid,
    AppString.elss,
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CommonAppBar(
        title: AppString.discover,
        action: [
          IconButton(
            onPressed: () {
              Get.toNamed(AppRoute.searchScreen);
            },
            icon: Icon(
              Icons.search,
              color: UtilsMethod().getColorBasedOnTheme(context),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppDimens.appVPadding,
            horizontal: AppDimens.appHPadding,
          ),
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CarouselSlider(
                      carouselController: _carouselSliderController,
                      options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 20 / 6,
                        enlargeCenterPage: true,
                        pageSnapping: true,
                        // height: size.height*0.020,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                      ),
                      items: items,
                    ),
                    // const SizedBox(height: AppDimens.appSpacing10),
                    DotsIndicator(
                      dotsCount: items.length,
                      mainAxisAlignment: MainAxisAlignment.center,
                      position: currentIndex,
                      decorator: DotsDecorator(
                        activeColor: AppColor.blue,
                        size: const Size.square(6.0),
                        activeSize: const Size(25.0, 6.0),
                        spacing: const EdgeInsets.symmetric(horizontal: 2),
                        activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ],
                ),
                CommonHeader(
                  title: AppString.quickActions,
                  labelOnTap: () {
                    Get.toNamed(AppRoute.quickActionScreen);
                  },
                ),
                Container(
                  margin: const EdgeInsets.all(AppDimens.appSpacing10),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 8,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 6 / 6,
                      crossAxisSpacing: AppDimens.appHPadding,
                      mainAxisSpacing: AppDimens.appVPadding,
                    ),
                    itemBuilder: (context, index) {
                      quickAction[index];
                      label[index];
                      return QuickActionCard(
                        // bgColor: UtilsMethod().getColorBasedOnTheme(context),
                        onTap: () {
                          Get.toNamed(
                            AppRoute.quickActionScreen,
                            arguments: QuickActionScreenArgs(tabIndex: index, indexName: ''),
                          );
                        },

                        image: quickAction[index],
                        label: label[index],
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppDimens.appVPadding),
                CommonHeader(
                  title: AppString.bestPerformingFund,
                  labelOnTap: () {
                    Get.toNamed(AppRoute.bestPerformingFundScreen);
                  },
                ),
                SizedBox(
                  height: size.height >= AppDimens.screenLessThan5Inch ? size.height * 0.173 : size.height * 0.198, // for less than 5inch
                  width: size.width,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimens.appSpacing10,
                      ),
                    ),
                    shrinkWrap: true,
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    physics: const ScrollPhysics(),
                    itemBuilder: (context, index) => _bestPerformingFund(size),
                  ),
                ),
                const SizedBox(height: AppDimens.appVPadding),
                CommonHeader(
                  title: AppString.fundByUs,
                  labelOnTap: () {
                    Get.toNamed(AppRoute.fundByUsScreen);
                  },
                ),
                SizedBox(
                  height: size.height >= AppDimens.screenLessThan5Inch ? size.height * 0.192 : size.height * 0.218, // for less than 5inch
                  width: size.width,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimens.appSpacing10,
                      ),
                    ),
                    shrinkWrap: true,
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    physics: const ScrollPhysics(),
                    itemBuilder: (context, index) => _fundByUs(size),
                  ),
                ),
                const SizedBox(height: AppDimens.appVPadding),
                CommonHeader(
                  title: AppString.latestFundRelease,
                  labelOnTap: () {
                    Get.toNamed(AppRoute.latestFundRelease);
                  },
                ),
                SizedBox(
                  height: size.height >= AppDimens.screenLessThan5Inch ? size.height * 0.200 : size.height * 0.230, // for less than 5inch
                  width: size.width,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimens.appSpacing10,
                      ),
                    ),
                    shrinkWrap: true,
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    physics: const ScrollPhysics(),
                    itemBuilder: (context, index) => _latestFuncRelease(size),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// best performing fund widget
  Widget _bestPerformingFund(Size size) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoute.fundDetailScreen);
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
                Container(
                  height: size.height * 0.080, // Use a smaller fraction for smaller devices
                  width: size.width * 0.15,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: UtilsMethod().getColorBasedOnTheme(context).withOpacity(0.5),
                    ),
                    borderRadius: BorderRadius.circular(AppDimens.appRadius6),
                  ),
                ),
                SizedBox(width: size.width * 0.025), // Dynamic spacing based on width
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        'LIC MF Infrastructure Fund',
                        style: AppTextStyles.regular15(
                          color: UtilsMethod().getColorBasedOnTheme(context),
                        ),
                        maxLines: 1, // Limit lines to prevent overflow
                      ),
                      AutoSizeText(
                        '- Growth Plan',
                        style: AppTextStyles.regular13(
                          color: UtilsMethod().getColorBasedOnTheme(context),
                        ),
                        maxLines: 1,
                      ),
                      SizedBox(height: size.height * 0.01), // Proportional spacing
                      Row(
                        children: [
                          const CustomChip(label: 'Equity'),
                          SizedBox(width: size.width * 0.02),
                          const CustomChip(label: 'Mid Cap'),
                        ],
                      ),
                    ],
                  ),
                ),
                const ShowRatingWidget(rating: '5'),
              ],
            ),
            SizedBox(height: size.height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleAndValueWidget(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  title: 'Min Amount',
                  value: '10,000',
                  valueColor: UtilsMethod().getColorBasedOnTheme(context),
                ),
                TitleAndValueWidget(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  title: '1 Y Returns',
                  value: '71.76%',
                  valueColor: Colors.green,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

// fund by Us
  Widget _fundByUs(Size size) {
    // Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoute.fundDetailScreen);
      },
      child: Container(
        width: size.width * 0.92,
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.appSpacing15, vertical: AppDimens.appSpacing15),
        decoration:
            BoxDecoration(border: Border.all(color: AppColor.greyLightest, width: 0.8), borderRadius: BorderRadius.circular(AppDimens.appRadius12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            FittedBox(
              child: Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                          color: UtilsMethod().getColorBasedOnTheme(context),
                        ),
                        maxLines: 1,
                      ),
                      AutoSizeText(
                        'Growth Plan',
                        style: AppTextStyles.regular13(
                          color: UtilsMethod().getColorBasedOnTheme(context),
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: AppDimens.appHPadding,
                  ),
                  const ShowRatingWidget(
                    rating: '5',
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: AppDimens.appSpacing10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              TitleAndValueWidget(
                crossAxisAlignment: CrossAxisAlignment.start,
                title: 'Min Amount',
                value: '10,000',
                valueColor: UtilsMethod().getColorBasedOnTheme(context),
              ),
              const TitleAndValueWidget(
                crossAxisAlignment: CrossAxisAlignment.end,
                title: '1 Y Returns',
                value: '71.76%',
                valueColor: Colors.green,
              ),
              Column(
                children: const [
                  CustomChip(
                    label: 'Equity',
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CustomChip(
                    label: 'Mid Cap',
                  ),
                ],
              ),
            ])
          ],
        ),
      ),
    );
  }

// latest fund release
  Widget _latestFuncRelease(Size size) {
    // Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoute.fundDetailScreen);
      },
      child: Container(
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
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                        color: UtilsMethod().getColorBasedOnTheme(context),
                      ),
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      'Fund - Growth Plan',
                      style: AppTextStyles.regular13(
                        color: UtilsMethod().getColorBasedOnTheme(context),
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
            const SizedBox(
              height: AppDimens.appSpacing10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
              TitleAndValueWidget(
                crossAxisAlignment: CrossAxisAlignment.start,
                title: 'Min Amount',
                value: '10,000',
              ),
              TitleAndValueWidget(
                crossAxisAlignment: CrossAxisAlignment.end,
                title: '1 Y Returns',
                value: '71.76%',
                valueColor: Colors.green,
              ),
            ]),
            const SizedBox(
              height: AppDimens.appSpacing5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(
                  'Launch Data',
                  style: AppTextStyles.regular13(color: AppColor.greyLightest),
                  maxLines: 1,
                ),
                AutoSizeText(
                  '22-10-2020',
                  style: AppTextStyles.semiBold15(
                    color: UtilsMethod().getColorBasedOnTheme(context),
                  ),
                  maxLines: 1,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
