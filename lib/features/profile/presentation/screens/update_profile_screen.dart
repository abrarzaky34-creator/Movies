import 'package:flutter/material.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  int selectedAvatar = 1;

  static const double designWidth = 430;
  static const double designHeight = 932;

  final List<String> avatars = List.generate(
    9,
        (index) => 'assets/profile/avatar_${index + 1}.png',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121312),
      body: Center(
        child: FittedBox(
          fit: BoxFit.contain,
          child: SizedBox(
            width: designWidth,
            height: designHeight,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/profile/background.png',
                    fit: BoxFit.fill,
                  ),
                ),

                // Back Arrow
                Positioned(
                  left: 38,
                  top: 17,
                  width: 25,
                  height: 25,
                  child: GestureDetector(
                    onTap: () => Navigator.maybePop(context),
                    child: Image.asset(
                      'assets/profile/back_arrow.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                // Title
                const Positioned(
                  top: 19,
                  left: 0,
                  right: 0,
                  child: Text(
                    'Pick Avatar',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFFFBB3B),
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                // Main Avatar
                Positioned(
                  left: (designWidth - 157) / 2,
                  top: 55,
                  width: 157,
                  height: 157,
                  child: Image.asset(
                    avatars[selectedAvatar],
                    fit: BoxFit.contain,
                  ),
                ),

                // Name
                Positioned(
                  left: 16,
                  top: 220,
                  width: 398,
                  height: 56,
                  child: _InputBox(
                    icon: 'assets/profile/user_icon.png',
                    textAsset: 'assets/profile/name_text.png',
                  ),
                ),

                // Phone
                Positioned(
                  left: 16,
                  top: 286,
                  width: 398,
                  height: 56,
                  child: _InputBox(
                    icon: 'assets/profile/back_arrow.png',
                    textAsset: 'assets/profile/phone_text.png',
                    usePhoneIcon: true,
                  ),
                ),

                // Reset Password
                Positioned(
                  left: 33,
                  top: 353,
                  width: 141,
                  height: 16,
                  child: Image.asset(
                    'assets/profile/reset_password_text.png',
                    fit: BoxFit.contain,
                  ),
                ),

                // Avatar Panel
                Positioned(
                  left: 16,
                  top: 385,
                  width: 398,
                  height: 389,
                  child: Image.asset(
                    'assets/profile/avatar_panel.png',
                    fit: BoxFit.fill,
                  ),
                ),

                // Avatar Choices
                ..._buildAvatarChoices(),

                // Delete Account
                Positioned(
                  left: 16,
                  top: 790,
                  width: 398,
                  height: 56,
                  child: GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      'assets/profile/delete_button.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),

                // Update Data
                Positioned(
                  left: 16,
                  top: 857,
                  width: 398,
                  height: 56,
                  child: GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      'assets/profile/update_button.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildAvatarChoices() {
    const double startX = 28;
    const double startY = 400;
    const double itemWidth = 108;
    const double itemHeight = 105;
    const double gapX = 21;
    const double gapY = 8;

    final widgets = <Widget>[];

    for (int i = 0; i < avatars.length; i++) {
      final row = i ~/ 3;
      final column = i % 3;

      widgets.add(
        Positioned(
          left: startX + column * (itemWidth + gapX),
          top: startY + row * (itemHeight + gapY),
          width: itemWidth,
          height: itemHeight,
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedAvatar = i;
              });
            },
            child: Image.asset(
              avatars[i],
              fit: BoxFit.contain,
            ),
          ),
        ),
      );
    }

    return widgets;
  }
}

class _InputBox extends StatelessWidget {
  final String icon;
  final String textAsset;
  final bool usePhoneIcon;

  const _InputBox({
    required this.icon,
    required this.textAsset,
    this.usePhoneIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF282A28),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const SizedBox(width: 13),

          if (usePhoneIcon)
            const Icon(
              Icons.phone,
              size: 17,
              color: Color(0xFF777777),
            )
          else
            Image.asset(
              icon,
              width: 16,
              height: 16,
              color: const Color(0xFF777777),
            ),

          const SizedBox(width: 10),

          Image.asset(
            textAsset,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}