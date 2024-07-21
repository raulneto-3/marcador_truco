import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../app.dart';
import 'provider.dart';

class TeamColumnWidget extends StatefulWidget {
  const TeamColumnWidget({super.key, required this.team});
  final String team;

  @override
  State<TeamColumnWidget> createState() => _TeamColumnWidgetState();
}

class _TeamColumnWidgetState extends State<TeamColumnWidget> {
  // int _counter = 0;
  int _dragDirection = 0;

  void _increment(int value) {
    setState(() {
      if (Provider.of<TrucoProvider>(context, listen: false).pontos[widget.team] < 12) {
        if (Provider.of<TrucoProvider>(context, listen: false).truco) {
          Provider.of<TrucoProvider>(context, listen: false).pontos[widget.team] += 3;
          Provider.of<TrucoProvider>(context, listen: false).toggleTruco();
        } else {
          Provider.of<TrucoProvider>(context, listen: false).pontos[widget.team] += value;
        }
      }
      // if (_counter < 12) _counter++;
      if (Provider.of<TrucoProvider>(context, listen: false).pontos[widget.team] >= 12) {
        _showAlert(context);
      }
    });
  }

  void _decrement() {
    setState(() {
      if (Provider.of<TrucoProvider>(context, listen: false).pontos[widget.team] > 0) Provider.of<TrucoProvider>(context, listen: false).pontos[widget.team]--;
    });
  }

  InterstitialAd? _interstitialAd;
  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-7119034738636421/8486251602'
      : 'ca-app-pub-7119034738636421/3314643959';

  void _loadAd() {
    InterstitialAd.load(
        adUnitId: _adUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (InterstitialAd ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
                // Called when the ad showed the full screen content.
                onAdShowedFullScreenContent: (ad) {},
                // Called when an impression occurs on the ad.
                onAdImpression: (ad) {},
                // Called when the ad failed to show full screen content.
                onAdFailedToShowFullScreenContent: (ad, err) {
                  ad.dispose();
                },
                // Called when the ad dismissed full screen content.
                onAdDismissedFullScreenContent: (ad) {
                  ad.dispose();
                },
                // Called when a click is recorded for an ad.
                onAdClicked: (ad) {});

            // Keep a reference to the ad so you can show it later.
            _interstitialAd = ad;
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            // ignore: avoid_print
            print('InterstitialAd failed to load: $error');
          },
        ));
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _loadAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      width: MediaQuery.of(context).size.width * 0.4,
      child: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.delta.dy > 0) {
            _dragDirection = -1;
          } else if (details.delta.dy < 0) {
            _dragDirection = 1;
          }
        },
        onVerticalDragEnd: (details) {
          if (_dragDirection > 0) {
            _increment(3);
          } else if (_dragDirection < 0) {
            _decrement();
          }
          _dragDirection = 0;
        },
        onTap: () {
          _increment(1);
        },
        child: Container(
          color: Color.fromRGBO(255, 255, 255, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.03),
                child: Text(
                  widget.team,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(180, 180, 180, 1),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05),
                child: Text(
                  '${Provider.of<TrucoProvider>(context, listen: false).pontos[widget.team]}',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.1,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(180, 180, 180, 1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Game Over'),
              content: Text('You Win. ${widget.team}!'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                )
              ],
            )).then((value) {
                _interstitialAd?.show();
                _loadAd();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const MyApp()));
            });
  }
}
