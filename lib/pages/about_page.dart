import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("About Page"),
    );
  }
}

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // ScreenUtil.init(context, height: 896, width: 414, allowFontScaling: true);
//     ScreenUtil.init(context);

//     var profileInfo = Expanded(
//       child: Column(
//         children: <Widget>[
//           Container(
//             height: kSpacingUnit.w * 10,
//             width: kSpacingUnit.w * 10,
//             margin: EdgeInsets.only(top: kSpacingUnit.w * 3),
//             child: Stack(
//               children: <Widget>[
//                 CircleAvatar(
//                   radius: kSpacingUnit.w * 5,
//                   backgroundImage: const AssetImage('assets/images/avatar.png'),
//                 ),
//                 Align(
//                   alignment: Alignment.bottomRight,
//                   child: Container(
//                     height: kSpacingUnit.w * 2.5,
//                     width: kSpacingUnit.w * 2.5,
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).colorScheme.secondary,
//                       shape: BoxShape.circle,
//                     ),
//                     child: Center(
//                       heightFactor: kSpacingUnit.w * 1.5,
//                       widthFactor: kSpacingUnit.w * 1.5,
//                       child: Icon(
//                         LineAwesomeIcons.pen,
//                         color: kDarkPrimaryColor,
//                         size: ScreenUtil().setSp(kSpacingUnit.w * 1.5),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: kSpacingUnit.w * 2),
//           Text(
//             'Nicolas Adams',
//             style: kTitleTextStyle,
//           ),
//           SizedBox(height: kSpacingUnit.w * 0.5),
//           Text(
//             'nicolasadams@gmail.com',
//             style: kCaptionTextStyle,
//           ),
//           SizedBox(height: kSpacingUnit.w * 2),
//           Container(
//             height: kSpacingUnit.w * 4,
//             width: kSpacingUnit.w * 20,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
//               color: Theme.of(context).colorScheme.secondary,
//             ),
//             child: Center(
//               child: Text(
//                 'Upgrade to PRO',
//                 style: kButtonTextStyle,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );

//     var themeSwitcher = ThemeSwitcher(
//       builder: (context) {
//         return AnimatedCrossFade(
//           duration: const Duration(milliseconds: 200),
//           crossFadeState:
//               ThemeProvider.of(context).brightness == Brightness.dark
//                   ? CrossFadeState.showFirst
//                   : CrossFadeState.showSecond,
//           firstChild: GestureDetector(
//             onTap: () =>
//                 ThemeSwitcher.of(context).changeTheme(theme: kLightTheme),
//             child: Icon(
//               LineAwesomeIcons.sun,
//               size: ScreenUtil().setSp(kSpacingUnit.w * 3),
//             ),
//           ),
//           secondChild: GestureDetector(
//             onTap: () =>
//                 ThemeSwitcher.of(context).changeTheme(theme: kDarkTheme),
//             child: Icon(
//               LineAwesomeIcons.moon,
//               size: ScreenUtil().setSp(kSpacingUnit.w * 3),
//             ),
//           ),
//         );
//       },
//     );

//     var header = Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         SizedBox(width: kSpacingUnit.w * 3),
//         Icon(
//           LineAwesomeIcons.arrow_left,
//           size: ScreenUtil().setSp(kSpacingUnit.w * 3),
//         ),
//         profileInfo,
//         themeSwitcher,
//         SizedBox(width: kSpacingUnit.w * 3),
//       ],
//     );

//     return ThemeSwitchingArea(
//       child: Builder(
//         builder: (context) {
//           return Scaffold(
//             body: Column(
//               children: <Widget>[
//                 SizedBox(height: kSpacingUnit.w * 5),
//                 header,
//                 Expanded(
//                   child: ListView(
//                     children: const <Widget>[
//                       ProfileListItem(
//                         icon: LineAwesomeIcons.user_shield,
//                         text: 'Privacy',
//                         key: null,
//                       ),
//                       ProfileListItem(
//                         icon: LineAwesomeIcons.history,
//                         text: 'Purchase History',
//                         key: null,
//                       ),
//                       ProfileListItem(
//                         icon: LineAwesomeIcons.question_circle,
//                         text: 'Help & Support',
//                         key: null,
//                       ),
//                       ProfileListItem(
//                         icon: LineAwesomeIcons.cog,
//                         text: 'Settings',
//                         key: null,
//                       ),
//                       ProfileListItem(
//                         icon: LineAwesomeIcons.user_plus,
//                         text: 'Invite a Friend',
//                         key: null,
//                       ),
//                       ProfileListItem(
//                         icon: LineAwesomeIcons.alternate_sign_out,
//                         text: 'Logout',
//                         hasNavigation: false,
//                         key: null,
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
