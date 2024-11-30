import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../my_app_exports.dart';

class MyPortFolioScreen extends StatefulWidget {
  const MyPortFolioScreen({super.key});

  @override
  State<MyPortFolioScreen> createState() => _MyPortFolioScreenState();
}

class _MyPortFolioScreenState extends State<MyPortFolioScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CommonAppBar(
        title: AppString.myPortfolio,
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
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppDimens.appVPadding,
                        horizontal: AppDimens.appHPadding,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _fundStatCard(),
                          const SizedBox(height: AppDimens.appSpacing20),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppDimens.appSpacing20,
                            ),
                            child: Divider(
                              height: 5,
                              color: AppColor.grey300,
                              thickness: 0.8,
                            ),
                          ),
                          const SizedBox(height: AppDimens.appSpacing20),
                          CommonOutLinedContainer(
                            bgColor: AppColor.lightestAmber,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AutoSizeText(
                                  AppString.monthlySip,
                                  style: AppTextStyles.regular15(
                                    color: AppColor.greyLight,
                                  ),
                                  maxLines: 1,
                                ),
                                AutoSizeText(
                                  '${AppString.rupees} 10,000',
                                  style: AppTextStyles.semiBold15(
                                    color: AppColor.black,
                                  ),
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: AppDimens.appSpacing20),
                        ],
                      ),
                    ),
                  ),
                  // Add SliverPersistentHeader for the TabBar
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _SliverTabBarDelegate(
                      TabBar(
                        padding: EdgeInsets.zero,
                        isScrollable: false,
                        indicatorColor: UtilsMethod().getColorBasedOnTheme(context),
                        // labelStyle: AppTextStyles.semiBold15(color: AppColor.greyLight),
                        // unselectedLabelStyle: AppTextStyles.regular15(color: AppColor.greyLight),
                        // labelColor: AppColor.greyLight,
                        enableFeedback: true,
                        tabs: const [
                          Tab(text: "${AppString.investments}(0)"),
                          Tab(text: "${AppString.sips}(1)"),
                        ],
                        controller: _tabController,
                        onTap: (value) {
                          _tabController?.animateTo(
                            _tabController!.index,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        },
                      ),
                    ),
                  ),
                  SliverFillRemaining(
                    child: TabBarView(
                      controller: _tabController,
                      physics: const ScrollPhysics(),
                      children: [
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: AppDimens.appSpacing40,
                              left: AppDimens.appVPadding,
                              right: AppDimens.appVPadding,
                              bottom: AppDimens.appHPadding,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonHeader(
                                  title: AppString.myInvestments,
                                  actionLabel: AppString.sort,
                                  labelColor: AppColor.greyLight,
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
                                    ),
                                  ),
                                  itemCount: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: AppDimens.appSpacing40,
                              left: AppDimens.appVPadding,
                              right: AppDimens.appVPadding,
                              bottom: AppDimens.appHPadding,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonHeader(
                                  title: AppString.mySip,
                                  actionLabel: AppString.sort,
                                  labelColor: AppColor.greyLight,
                                  isTrailingIcon: true,
                                  labelOnTap: () {},
                                ),
                                ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return MyPortFolioSipListCard(
                                      name: "LIC MF infrastructure Fund",
                                      sipAmount: '1000',
                                      month: 'Dec',
                                      date: '12',
                                      onTap: () {},
                                    );
                                  },
                                  separatorBuilder: (context, index) => const Padding(
                                    padding: EdgeInsets.symmetric(vertical: AppDimens.appSpacing10),
                                  ),
                                  itemCount: 20,
                                ),
                              ],
                            ),
                          ),
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
    );
  }

  Widget _fundStatCard() {
    Size size = MediaQuery.of(context).size;
    return CommonOutLinedContainer(
      bgColor: AppColor.lightestAmber,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              TitleAndValueWidget(
                isHorizontal: false,
                crossAxisAlignment: CrossAxisAlignment.start,
                title: AppString.current,
                value: '10,524',
                valueColor: AppColor.black,
              ),
              TitleAndValueWidget(
                isHorizontal: false,
                crossAxisAlignment: CrossAxisAlignment.end,
                title: AppString.invested,
                value: '10,000',
                valueColor: Colors.green,
              ),
            ],
          ),
          const SizedBox(height: AppDimens.appSpacing10),
          FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleAndValueWidget(
                  isHorizontal: true,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  title: AppString.totalReturn,
                  value: '52.4(11.95%)',
                  titleSize: 10,
                  valueSize: 11.5,
                  titleStyle: AppTextStyles.regular13(
                    color: AppColor.black,
                  ),
                  valueStyle: AppTextStyles.semiBold14(color: AppColor.green),
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
                  isLeadingIcon: true,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  title: AppString.oneDayReturn,
                  titleStyle: AppTextStyles.regular13(
                    color: AppColor.black,
                  ),
                  valueStyle: AppTextStyles.semiBold14(color: AppColor.red),
                  value: '100.4(5.9%)',
                  titleSize: 10,
                  valueSize: 11.5,
                  icon: Icons.arrow_downward,
                  iconColor: AppColor.red,
                  iconSize: 18,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimens.appSpacing10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppString.xirr,
                    style: AppTextStyles.regular12(color: AppColor.greyLight),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.info_outline,
                      size: 14,
                      color: AppColor.greyLightest,
                    ),
                  ),
                  const SizedBox(width: AppDimens.appSpacing10),
                  Text(
                    '11.9%',
                    style: AppTextStyles.semiBold12(color: AppColor.greyLight),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    AppImage.stockGraphUp,
                    height: size.height * 0.010,
                    width: size.width * 0.020,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    AppString.portFolioAnalysis,
                    style: AppTextStyles.regular15(
                      color: AppColor.black,
                    ),
                  )
                ],
              ),
            ],
          ),
          // const SizedBox(height: AppDimens.appSpacing10),

          //row end
        ],
      ),
    );
  }

  Widget _fundsCard({int? index}) {
    Size size = MediaQuery.of(context).size;
    return CommonOutLinedContainer(
      borderColor: AppColor.greyLightest,
      bgColor: Theme.of(context).scaffoldBackgroundColor,
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
                        style: AppTextStyles.regular15(),
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
    );
  }
}

/// Sliver SliverPersistentHeaderDelegate
class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverTabBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor, // Optional: Set background color
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
