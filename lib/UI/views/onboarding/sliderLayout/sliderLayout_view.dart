import 'dart:async';

import 'package:PayMeBack/UI/widgets/slide_dots.dart';
import 'package:PayMeBack/UI/widgets/slide_items/slide_items.dart';
import 'package:PayMeBack/core/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'slider_viewmodel.dart';

class SliderLayoutView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SliderLayoutViewState();
}

class _SliderLayoutViewState extends State<SliderLayoutView> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 2), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SliderViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
                body: Container(
              child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: <Widget>[
                      PageView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: _pageController,
                        onPageChanged: _onPageChanged,
                        itemCount: sliderArrayList.length,
                        itemBuilder: (ctx, i) => SlideItem(i),
                      ),
                      Stack(
                        alignment: AlignmentDirectional.topStart,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding:
                                  EdgeInsets.only(right: 15.0, bottom: 15.0),
                              child: buildNextButton(model),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding:
                                  EdgeInsets.only(left: 15.0, bottom: 15.0),
                              child: _buildSkipButton(model),
                            ),
                          ),
                          Container(
                            alignment: AlignmentDirectional.bottomCenter,
                            margin: EdgeInsets.only(bottom: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                for (int i = 0; i < sliderArrayList.length; i++)
                                  if (i == _currentPage)
                                    SlideDots(true)
                                  else
                                    SlideDots(false)
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
            )),
        viewModelBuilder: () => SliderViewModel());
  }

  Widget _buildSkipButton(model) => FlatButton(
      onPressed: () => model.navigateToLoginScreen(),
      child: Text(Constants.SKIP,
          style: TextStyle(
            fontFamily: Constants.OPEN_SANS,
            fontWeight: FontWeight.w600,
            fontSize: 14.0,
          )));

  Widget buildNextButton(model) => FlatButton(
      onPressed: () {
        if (_currentPage == 3) {
          model.navigateToLoginScreen();
        } else {
          return null;
        }
      },
      child: Text(Constants.NEXT,
          style: TextStyle(
            fontFamily: Constants.OPEN_SANS,
            fontWeight: FontWeight.w600,
            fontSize: 14.0,
          )));

}
