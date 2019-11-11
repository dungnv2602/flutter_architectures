import 'package:flutter/material.dart';
import 'package:flutter_architectures/generated/i18n.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

import 'gradient_button.dart';
import 'home_page.dart';

const backgroundColor = Color(0xFFf2f6fe);
const primaryColor = Color(0xFF6c63ff);
const accentColor = Colors.black54;

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final primaryTextTheme = theme.primaryTextTheme;

    final page1 = buildPageViewModel(
      pageColor: primaryColor,
      svgPath: 'assets/svgs/undraw_books.svg',
      iconPath: 'assets/pngs/undraw_books.png',
      title: S.of(context).titleSplashPage1,
      textTheme: textTheme,
    );

    final page2 = buildPageViewModel(
      pageColor: primaryColor,
      svgPath: 'assets/svgs/undraw_bookshelves.svg',
      iconPath: 'assets/pngs/undraw_bookshelves.png',
      title: S.of(context).titleSplashPage2,
      textTheme: textTheme,
    );

    final page3 = buildPageViewModel(
      pageColor: primaryColor,
      svgPath: 'assets/svgs/book_reading.svg',
      iconPath: 'assets/pngs/book_reading.png',
      title: S.of(context).titleSplashPage3,
      textTheme: textTheme,
    );

    return Scaffold(
      body: Stack(
        children: <Widget>[
          IntroViewsFlutter(
            [page1, page2, page3],
            columnMainAxisAlignment: MainAxisAlignment.start,
            doneText: const Text(''),
            onTapDoneButton: null,
            showBackButton: false,
            showNextButton: false,
            showSkipButton: false,
          ),
          Align(
            alignment: const Alignment(0, 0.7),
            child: RaisedGradientButton(
              height: 60,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              gradient: LinearGradient(
                colors: const [
                  Colors.white,
                  Colors.white,
                ],
              ),
              shadowColor: primaryColor,
              child: Text(S.of(context).connectSplashButton,
                  style: primaryTextTheme.title.copyWith(color: primaryColor)),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage())),
            ),
          ),
        ],
      ),
    );
  }
}

PageViewModel buildPageViewModel({
  Color pageColor,
  String svgPath,
  String iconPath,
  String title,
  TextTheme textTheme,
}) {
  return PageViewModel(
    mainImage: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          svgPath,
          fit: BoxFit.cover,
        ),
      ),
    ),
    pageColor: pageColor,
    bubbleBackgroundColor: Colors.white,
    title: const Text(''),
    body: Text(title, style: textTheme.title.copyWith(color: Colors.white)),
    titleTextStyle: const TextStyle(fontSize: 0),
    bodyTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
  );
}
