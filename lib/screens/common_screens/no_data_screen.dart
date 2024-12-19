import 'package:flutter/material.dart';
import 'package:intellect_mutual_fund/my_app_exports.dart';

class NoDataScreen extends StatelessWidget {
  final String? title;
  final String? message;

  const NoDataScreen({
    super.key,
    this.title = '',
    this.message = '',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          // SizedBox(
          //   height: 300,
          // ),
          Text(
            title ?? '',
            style: AppTextStyles.semiBold18(),
          ),
          SizedBox(
            height: AppDimens.appSpacing20,
          ),
          Text(
            message ?? 'No Data Available !',
            style: AppTextStyles.semiBold18(),
          ),
        ],
      ),
    );
  }
}
