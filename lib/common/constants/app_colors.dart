import 'dart:ui';

class AppColors {

  static const primary100 = Color(0xff000000);

  static const secondary100 = Color(0xffffffff);

  static const neutral50 = Color(0xfff8f8f8);
  static const neutral100 = Color(0xfff1f1f1);
  static const neutral200 = Color(0xffe1e1e1);
  static const neutral300 = Color(0xffa1a1a1);
  static const neutral400 = Color(0xff6a6a6a);
  static const neutral500 = Color(0xff454545);

  static const success100 = Color(0xffe7f6f0);
  static const success300 = Color(0xffa0dcc2);
  static const success500 = Color(0xff61C49A);

  static const warning100 = Color(0xfffdf9e3);
  static const warning300 = Color(0xfffcf2bc);
  static const warning500 = Color(0xfff5d941);

  static const error100 = Color(0xffffe6e9);
  static const error300 = Color(0xffffc4cb);
  static const error500 = Color(0xfffe566a);

  static const brandColorNeon = Color(0xffdefa70);
  static const brandColorPink = Color(0xfffcbcb6);
  static const brandColorBlue = Color(0xffb1eeeb);
  static const brandColorCream = Color(0xfffaf7f4);

  static const dataPurple01 = Color(0xff26064e);
  static const dataPurple02 = Color(0xff675183);
  static const dataBlue01 = Color(0xff0c75f1);
  static const dataBlue02 = Color(0xff6eaef9);

  static const gradients1 = [
    Color(0xffb9f8e1),
    Color(0xffdbedd7),
    Color(0xfff1e1d7),
    Color(0xffe8f0d6),
    Color(0xff83f8f4),
    Color(0xff7ba3f8),
    Color(0xffc4bae4)
  ];

  static const gradients2 = [
    Color(0xffc4bae4),
    Color(0xffb9f8e1),
    Color(0xff83f8f4),
    Color(0xff7ba3f8),
    Color(0xffc4bae4),
  ];

  static final glassmorphismLight = [
    const Color(0xffffffff).withOpacity(0.855),
    const Color(0xffffffff).withOpacity(0.45),
  ];

  static final glassmorphismDark = [
    const Color(0xff000000).withOpacity(0.63),
    const Color(0xff000000).withOpacity(0.45),
  ];

  static const black2 = Color(0xff222222);
  static const darkBlue = Color(0xff272e79);
  static const gray1 = Color(0xff7a7a7a);
  static const gray4 = Color(0xffababab);
  static const gray5 = Color(0xff3a3a3a);
  static const gray7 = Color(0xffd0d8dd);
  static const gray8 = Color(0xfff5f6f9);
  static const frozen = Color(0xffa8e7f4);
  static const linkBlue = Color(0xff4992a2);

  static const confettiColors = [
    brandColorBlue,
    brandColorNeon,
    brandColorPink,
  ];

  // Snackbar
  static const blackOverlay2 = Color.fromRGBO(0, 0, 0, 0.6);
  static const snackbarShadow = Color.fromRGBO(0, 0, 0, 0.32);

  /// Used for modal bottom sheet's barrier
  static const overlay75 = Color.fromRGBO(0, 0, 0, 0.75);

  // Transaction
  static const transactionYellow = Color(0xfff6d016);

  // Cashback
  static const cashbackRent = dataBlue01;
  static const cashbackUber = primary100;
  static const cashbackOther = success500;
  static const cashbackDoorDash = Color(0xffff2f0a);

  static const cardStatusColor = Color(0xff5260fa);
  static const greenUnderline = Color(0xffbadfe0);
  static const texts = black2;
  static const darkRed = Color(0xffeb4d3d);
  static const gray2light = Color(0x80eaeaea);

  // AddPositionScreen
  static const basketSummaryShadow = Color.fromRGBO(0, 0, 0, 0.1);

  // Sparkline
  static const priceDownColor = Color(0xff52e3c2);
  static const priceUpColor = Color(0xfff27362);
}
