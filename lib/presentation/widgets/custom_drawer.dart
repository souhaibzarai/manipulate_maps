import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../business_logic/cubit/phone_auth_cubit.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  final _phoneAuthCubit = PhoneAuthCubit();

  /// Builds the header containing the profile image, phone number, and name.
  Widget _buildHeader() {
    return DrawerHeader(
      decoration: const BoxDecoration(
        color: AppColors.headerColor,
      ),
      curve: Curves.fastLinearToSlowEaseIn,
      child: SizedBox(
        height: 400,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'userImg',
              style: TextStyle(
                fontWeight: FontWeight.w100,
                color: AppColors.errorColor,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '+212 000000000',
              style: TextStyle(
                color: AppColors.thirdColor,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Static Data',
              style: TextStyle(
                color: AppColors.thirdColor,
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a list of action tiles.
  Widget _buildActions(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildListTile(
            context,
            icon: Icons.person,
            title: 'My Profile',
            onTap: () => Navigator.pop(context),
          ),
          _buildListTile(
            context,
            icon: Icons.settings,
            title: 'Settings',
            onTap: () => Navigator.pop(context),
          ),
          _buildListTile(
            context,
            icon: Icons.help_outline,
            title: 'Help',
            onTap: () => Navigator.pop(context),
          ),
          _buildListTile(
            context,
            icon: Icons.logout,
            title: 'Logout',
            onTap: () async {
              BlocProvider<PhoneAuthCubit>(
                create: (create) => _phoneAuthCubit,
                child: Container(),
              );
              await _phoneAuthCubit.logOut();
              if (!context.mounted) {
                return;
              }
              Navigator.pushReplacementNamed(
                context,
                authScreen,
              );
            },
          ),
        ],
      ),
    );
  }

  /// A helper method to build individual list tiles.
  Widget _buildListTile(BuildContext context,
      {required IconData icon, required String title, VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

  /// Builds the social media links row using Font Awesome icons.
  Widget _buildSocialMediaLinks() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.facebook),
            onPressed: () {
              // Handle Facebook action.
            },
          ),
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.telegram),
            onPressed: () {
              // Handle Telegram action.
            },
          ),
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.youtube),
            onPressed: () {
              // Handle YouTube action.
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _buildHeader(),
          SizedBox(height: 30),
          _buildActions(context),
          _buildSocialMediaLinks(),
        ],
      ),
    );
  }
}
