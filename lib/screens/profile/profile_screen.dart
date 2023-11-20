import 'package:flutter/material.dart';
import 'package:softpro_support/config/global/widgets/project_app_bar.dart';
import 'package:softpro_support/config/theme/app_theme.dart';
import 'package:softpro_support/screens/profile/widgets/premium_card.dart';
import 'package:softpro_support/screens/profile/widgets/profile_item.dart';
import 'package:softpro_support/screens/profile/widgets/user_avatar.dart';
import 'package:provider/provider.dart';

import '../../theme_notifier.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Consumer(
      builder: (context, ThemeNotifier themeNotifier, child) => Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size(double.infinity, 56),
          child: ProjectAppBar(
            appBarTitle: 'Profile', isbottomTab: false,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(
                    width: double.infinity,
                  ),
                 const UserAvatar(),
                  const SizedBox(height: 12),
                  Text(
                    'Nima Naderi',
                    style: theme.textTheme.headlineSmall!.copyWith(
                      color: AppDynamicColorBuilder.getGrey900AndWhite(context),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'nima.er.84@gmail.com',
                    style: theme.textTheme.bodyMedium!.copyWith(
                        color:
                            AppDynamicColorBuilder.getGrey900AndWhite(context),
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 24),
                  PremiumCard(
                    themeNotifier: themeNotifier,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 8,
                      itemBuilder: (context, index) => ProfileOptionItem(
                        index: index,
                        themeNotifier: themeNotifier,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


