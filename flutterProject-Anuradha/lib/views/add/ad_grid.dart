import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jwel_smart/logic/home_page_queries.dart';
import 'package:jwel_smart/logic/objects/ad.dart';
import 'package:jwel_smart/views/add/ad_view.dart';
import 'package:jwel_smart/views/helpers/app_navigator.dart';
import 'package:jwel_smart/views/helpers/handled_builders.dart';
import 'package:like_button/like_button.dart';
import 'package:jwel_smart/logic/add_ad.dart';
import 'package:jwel_smart/views/helpers/alert.dart';


class AdGrid extends StatelessWidget {
  final List<Ad> ads;
  final bool isMyReservedAds;
  int x;

  AdGrid({Key key, @required this.ads, this.isMyReservedAds = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: ads.length,
      itemBuilder: (context, index) {
        Ad ad = ads[index];

        return Card(
          child: Material(
            child: InkWell(
              onTap: () => AppNavigator.push(
                  context,
                  (_) => AdView(
                        ad: ad,
                        isMyReservedAd: isMyReservedAds,
                      )),
              child: GridTile(
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: ad.imageId == null
                            ? Container(color: Colors.indigo)
                            : HandledFutureBuilder<String>(
                                future: HomePageQueries.getImageUrl(ad),
                                builder: (_, imageUrl) => Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                      Positioned(
                        top: 2,
                        right: 2,
                        child: Chip(
                          backgroundColor: Colors.pink[100],
                          label: Text("LKR ${ad.price.toInt()}",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white)),
                        ),
                      ),
                      /*IconButton(
                      icon: Icon(Icons.message),
                      onPressed: Chat(),
                    )*/
                    ],
                  ),
                  footer: Column(children: <Widget>[
                    Container(
                      height: 28.0,
                      color: Colors.purple,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                        LikeButton(
                          padding: EdgeInsets.only(right: 100.0),
                          size: 10.0,
                          circleColor: CircleColor(
                              start: Color(0xff00ddff),
                              end: Color(0xff0099cc)),
                          bubblesColor: BubblesColor(
                            dotPrimaryColor: Color(0xff33b5e5),
                            dotSecondaryColor: Color(0xff0099cc),
                          ),
                          likeBuilder: (bool isLiked) {
                            return Icon(
                              isLiked
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isLiked ? Colors.red : Colors.grey,
                              size: 15.0,

                            );
                          },
                          likeCount: ad.rate,

                          countBuilder:
                              (int count, bool isLiked, String text) {
                            var color = isLiked
                                ? Colors.black
                                : Colors.black;
                            Widget result;
                            if (count == 0) {
                              result = Text(
                                "Rate",
                                style: TextStyle(
                                    color: color,
                                    fontWeight: FontWeight.bold),
                              );

                             // print(count);
                            } else
                              {result = Text(
                                text,
                                style: TextStyle(
                                    color: color,
                                    fontWeight: FontWeight.bold),

                              );
                              //RateAd.rateAd(ad.id,ad.rate+1,isLiked);
                              }
                            return result;
                          },

                          likeCountPadding: EdgeInsets.only(left: 15.0),
                          onTap: (bool isLiked)
                          {
                            return RateAd.rateAd(ad.id,ad.rate+1,isLiked);
                          },

                        ),
                      ),
                    ),
                    Container(
                        height: 30.0,
                        width: 200.0,
                        color: Colors.purple,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            ad.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ))
                  ])),
            ),
          ),
        );
      },
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    );
  }


}
