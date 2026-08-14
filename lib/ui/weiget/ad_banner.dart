import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pic_grid/constants/ad_ids.dart';

class AdBanner extends StatefulWidget {
  const AdBanner({super.key});

  @override
  State<AdBanner> createState() => _AdBannerState();
}

class _AdBannerState extends State<AdBanner> {
  BannerAd? _bannerAd;
  int? _lastWidth;
  int _loadGeneration = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!Platform.isAndroid) return;

    final width = MediaQuery.sizeOf(context).width.truncate();
    if (width > 0 && width != _lastWidth) {
      _lastWidth = width;
      _loadAd(width);
    }
  }

  Future<void> _loadAd(int width) async {
    final generation = ++_loadGeneration;
    final size = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
      width,
    );
    if (!mounted || size == null || generation != _loadGeneration) return;

    await _bannerAd?.dispose();
    if (mounted) setState(() => _bannerAd = null);
    final ad = BannerAd(
      adUnitId: kReleaseMode ? AdIds.androidBanner : AdIds.androidTestBanner,
      request: const AdRequest(),
      size: size,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (!mounted || generation != _loadGeneration) {
            ad.dispose();
            return;
          }
          setState(() => _bannerAd = ad as BannerAd);
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('Banner ad failed to load: $error');
          ad.dispose();
        },
      ),
    );
    await ad.load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ad = _bannerAd;
    if (!Platform.isAndroid || ad == null) return const SizedBox.shrink();

    return ColoredBox(
      color: Colors.black,
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: ad.size.width.toDouble(),
          height: ad.size.height.toDouble(),
          child: AdWidget(ad: ad),
        ),
      ),
    );
  }
}
