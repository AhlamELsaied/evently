/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconGen {
  const $AssetsIconGen();

  /// File path: assets/icon/EG.png
  AssetGenImage get eg => const AssetGenImage('assets/icon/EG.png');

  /// File path: assets/icon/LR.png
  AssetGenImage get lr => const AssetGenImage('assets/icon/LR.png');

  /// File path: assets/icon/Moon.png
  AssetGenImage get moon => const AssetGenImage('assets/icon/Moon.png');

  /// File path: assets/icon/Sun.png
  AssetGenImage get sun => const AssetGenImage('assets/icon/Sun.png');

  /// File path: assets/icon/iconGoogle.png
  AssetGenImage get iconGoogle =>
      const AssetGenImage('assets/icon/iconGoogle.png');

  /// Directory path: assets/icon/icon_bottom
  $AssetsIconIconBottomGen get iconBottom => const $AssetsIconIconBottomGen();

  /// List of all assets
  List<AssetGenImage> get values => [eg, lr, moon, sun, iconGoogle];
}

class $AssetsImageGen {
  const $AssetsImageGen();

  /// File path: assets/image/being-creative.png
  AssetGenImage get beingCreative =>
      const AssetGenImage('assets/image/being-creative.png');

  /// File path: assets/image/darkFirst.png
  AssetGenImage get darkFirst =>
      const AssetGenImage('assets/image/darkFirst.png');

  /// File path: assets/image/firstOnboarding.png
  AssetGenImage get firstOnboarding =>
      const AssetGenImage('assets/image/firstOnboarding.png');

  /// File path: assets/image/forgetscreen.png
  AssetGenImage get forgetscreen =>
      const AssetGenImage('assets/image/forgetscreen.png');

  /// File path: assets/image/hot-trending.png
  AssetGenImage get hotTrending =>
      const AssetGenImage('assets/image/hot-trending.png');

  /// File path: assets/image/hot-trendingDark.png
  AssetGenImage get hotTrendingDark =>
      const AssetGenImage('assets/image/hot-trendingDark.png');

  /// File path: assets/image/manager-desk.png
  AssetGenImage get managerDesk =>
      const AssetGenImage('assets/image/manager-desk.png');

  /// File path: assets/image/thirddark.png
  AssetGenImage get thirddark =>
      const AssetGenImage('assets/image/thirddark.png');

  /// File path: assets/image/wireframe.png
  AssetGenImage get wireframe =>
      const AssetGenImage('assets/image/wireframe.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    beingCreative,
    darkFirst,
    firstOnboarding,
    forgetscreen,
    hotTrending,
    hotTrendingDark,
    managerDesk,
    thirddark,
    wireframe,
  ];
}

class $AssetsLogoGen {
  const $AssetsLogoGen();

  /// File path: assets/logo/Logo.png
  AssetGenImage get logo => const AssetGenImage('assets/logo/Logo.png');

  /// File path: assets/logo/logoRoute.png
  AssetGenImage get logoRoute =>
      const AssetGenImage('assets/logo/logoRoute.png');

  /// File path: assets/logo/logoRow.png
  AssetGenImage get logoRow => const AssetGenImage('assets/logo/logoRow.png');

  /// List of all assets
  List<AssetGenImage> get values => [logo, logoRoute, logoRow];
}

class $AssetsIconIconBottomGen {
  const $AssetsIconIconBottomGen();

  /// File path: assets/icon/icon_bottom/Home.svg
  String get home => 'assets/icon/icon_bottom/Home.svg';

  /// File path: assets/icon/icon_bottom/heart.svg
  String get heart => 'assets/icon/icon_bottom/heart.svg';

  /// File path: assets/icon/icon_bottom/location.svg
  String get location => 'assets/icon/icon_bottom/location.svg';

  /// File path: assets/icon/icon_bottom/person.svg
  String get person => 'assets/icon/icon_bottom/person.svg';

  /// File path: assets/icon/icon_bottom/selectHeart.svg
  String get selectHeart => 'assets/icon/icon_bottom/selectHeart.svg';

  /// File path: assets/icon/icon_bottom/selectHome.svg
  String get selectHome => 'assets/icon/icon_bottom/selectHome.svg';

  /// File path: assets/icon/icon_bottom/selectLocat.svg
  String get selectLocat => 'assets/icon/icon_bottom/selectLocat.svg';

  /// File path: assets/icon/icon_bottom/selectPercon.svg
  String get selectPercon => 'assets/icon/icon_bottom/selectPercon.svg';

  /// List of all assets
  List<String> get values => [
    home,
    heart,
    location,
    person,
    selectHeart,
    selectHome,
    selectLocat,
    selectPercon,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsIconGen icon = $AssetsIconGen();
  static const $AssetsImageGen image = $AssetsImageGen();
  static const $AssetsLogoGen logo = $AssetsLogoGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
