import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testing/core/constants/constants.dart';
import 'package:testing/core/constants/images.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  double _baseHalfHeight = 100;
  double _left = 25;
  double _opac = 1;

  bool _isTop = false;
  bool _showText = true;

  final _ls = [
    [AppImages.astroImage, 'Amala', 200.0],
    [AppImages.astro2Image, 'Egusi', 500.0],
    [AppImages.byeImage, 'Afang', 500.0],
    [AppImages.cardImage, 'Rice', 100.0],
    [AppImages.egusiImage, 'Egusi', 200.0],
    [AppImages.kidImage, 'Vegetable', 100.0],
    [AppImages.iImage, 'Oil', 500.0],
    [AppImages.runImage, 'Okro', 700.0],
    [AppImages.summerImage, 'Bread', 200.0],
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppImages.backgroundImage), fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: _baseHalfHeight < (_height * .5)
                    ? (_height * .5)
                    : _baseHalfHeight > (_height * .9)
                        ? (_height * .9)
                        : _baseHalfHeight,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: GestureDetector(
                          onVerticalDragUpdate: (i) {
                            setState(() {
                              if ((_height - (i.globalPosition.dy) >
                                  _baseHalfHeight)) {
                                if (_left <= -30) {
                                  _left = -50;
                                } else {
                                  _left = _left - 1;
                                }
                                if (_baseHalfHeight > (_height * .69)) {
                                  _opac = 0;
                                } else {
                                  if (_opac - .01 < 1) {
                                    _opac = _opac - .01;
                                  }
                                }
                              } else {
                                if (_left <= 25) {
                                  if (_left >= 10) {
                                    _left = 20;
                                  } else {
                                    _left = _left + 1;
                                  }
                                  if (_baseHalfHeight < (_height * .51)) {
                                    _opac = 1;
                                  } else {
                                    if (_opac + .01 > 0) {
                                      _opac = _opac + .01;
                                    }
                                  }
                                }
                              }

                              _baseHalfHeight = _height - (i.globalPosition.dy);

                              if (_baseHalfHeight > (_height * .9)) {
                                _isTop = true;
                              } else {
                                _isTop = false;
                              }
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            height: 7,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade500,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'All Foods',
                          style: testStyle.copyWith(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            GridView.builder(
                              padding: EdgeInsets.zero,
                              physics: const ScrollPhysics(),
                              itemCount: _ls.length,
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                              itemBuilder: (_, index) => ItemCards(
                                image: _ls[index][0] as String,
                                text: _ls[index][1] as String,
                                price: _ls[index][2] as double,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: _isTop
                                  ? GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                const SearchScreen(),
                                          ),
                                        );
                                      },
                                      child: Transform.rotate(
                                        angle: math.pi - 45,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.all(20),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 1)),
                                            child: Transform.rotate(
                                              angle: math.pi + 45,
                                              child: SvgPicture.asset(
                                                AppIcons.searchIcon,
                                                height: 30,
                                              ),
                                            ),
                                          ),
                                          padding: const EdgeInsets.all(15),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 50,
              left: _left,
              child: AnimatedOpacity(
                opacity: _opac > 1
                    ? 1
                    : _opac < 0
                        ? 0
                        : _opac,
                duration: const Duration(milliseconds: 400),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: SvgPicture.asset(
                    AppIcons.cameraIcon,
                    height: 50,
                  ),
                ),
              ),
            ),
            _baseHalfHeight <= (_height * .65)
                ? Positioned(
                    top: 150,
                    left: 20,
                    child: SizedBox(
                      width: _width / 2,
                      child: Text(
                        "Find Your Chow Now",
                        style: testStyle.copyWith(
                            fontWeight: FontWeight.w700, fontSize: 40),
                      ),
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}

class ItemCards extends StatelessWidget {
  const ItemCards({Key? key, this.text, required this.image, this.price})
      : super(key: key);
  final String image;
  final String? text;
  final double? price;

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 30,
      width: 30,
      child: Column(
        children: [
          Expanded(flex: 2, child: Image.asset(image)),
          SizedBox(
            height: _height * .015,
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  text ?? '',
                  style: testStyle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'N${price?.toInt()}',
                      style: testStyle.copyWith(color: Colors.red),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'chows',
                      style: testStyle.copyWith(color: Colors.grey),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withOpacity(.5), width: .5),
      ),
    );
  }
}

class SearchCards extends StatelessWidget {
  const SearchCards({Key? key, this.text, required this.image, this.price})
      : super(key: key);
  final String image;
  final String? text;
  final double? price;

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 10, right: 10, bottom: 10),
      child: Row(
        children: [
          Expanded(
              child: Image.asset(
            image,
            height: 100,
          )),
          const SizedBox(
            width: 3,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text ?? '',
                  style: testStyle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'N${price?.toInt()}',
                      style: testStyle.copyWith(color: Colors.red),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'chows',
                      style: testStyle.copyWith(color: Colors.grey),
                    ),
                  ],
                )
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right,
            size: 50,
            color: Colors.purple,
          )
        ],
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
    );
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _ls = [
    [AppImages.astroImage, 'Amala', 200.0],
    [AppImages.astro2Image, 'Egusi', 500.0],
    [AppImages.byeImage, 'Afang', 500.0],
    [AppImages.cardImage, 'Rice', 100.0],
    [AppImages.egusiImage, 'Egusi', 200.0],
    [AppImages.kidImage, 'Vegetable', 100.0],
    [AppImages.iImage, 'Oil', 500.0],
    [AppImages.runImage, 'Okro', 700.0],
    [AppImages.summerImage, 'Bread', 200.0],
  ];

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.backgroundImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20, left: 20, right: 20, bottom: 10),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search,
                          color: Colors.grey,
                          size: 30,
                        ),
                        Expanded(
                            child: TextFormField(
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            hintText: 'Search for stuffs',
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            focusedBorder:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            enabledBorder:
                                OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                        )),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.cancel,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 2,
                    color: Colors.black,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Wrap(
                      children: const [
                        SearchCard(),
                        SearchCard(),
                        SearchCard(),
                        SearchCard(),
                        SearchCard(),
                        SearchCard(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Text(
                      "Results",
                      style: testStyle.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 20),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: _ls.length,
                        itemBuilder: (_, i) {
                          return SearchCards(
                            image: _ls[i][0] as String,
                            text: _ls[i][1] as String,
                            price: _ls[i][2] as double,
                          );
                        }),
                  )
                ],
              ),
              width: double.infinity,
              height: _height * .9,
            ),
          )
        ],
      ),
    ));
  }
}

class SearchCard extends StatelessWidget {
  const SearchCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Traditional",
            style: testStyle.copyWith(fontWeight: FontWeight.w200),
          ),
          const SizedBox(
            width: 4,
          ),
          const Icon(
            Icons.cancel,
            color: Colors.white,
            size: 20,
          )
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: const EdgeInsets.only(bottom: 5, right: 5),
      decoration: BoxDecoration(
        color: const Color(0xffEFCAF2),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
