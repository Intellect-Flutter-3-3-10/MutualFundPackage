import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intellect_mutual_fund/my_app_exports.dart';

import '../../res/res.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Function()? leadingAction;
  final bool automaticallyImplyLeading;
  final bool isBackButton;

  final List<Widget>? action;

  const CommonAppBar({
    super.key,
    this.title = AppString.mutualFunds,
    this.leadingAction,
    this.action,
    this.automaticallyImplyLeading = true,
    this.isBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: isBackButton
          ? GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios),
            )
          : SizedBox.shrink(),
      elevation: 0,
      title: AutoSizeText(
        title!,
        style: AppTextStyles.regular20(),
        maxLines: 1,
      ),
      actions: action,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
