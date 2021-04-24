import 'package:alert/alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/model/news_model.dart';
import 'package:newsapp/page/news_item_techno.dart';
import 'package:newsapp/page/news_item_trend.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String apiUrlTrend = 'https://innocent-dscitb.vercel.app/trend.json';
  String apiUrlTechno = 'https://innocent-dscitb.vercel.app/news.json';

  bool isLoading = true;
  NewsResponse trendResponse, technoResponse;

  var dio = Dio();

  @override
  void initState() {
    super.initState();
    getTrendNews();
    getTechnoNews();
  }

  void getTrendNews() async {
    setLoading(true);

    final response = await dio.get(apiUrlTrend);
    trendResponse = NewsResponse.fromJson(response.data);
    print('Trend API status: ${trendResponse.messege}');

    setLoading(false);
  }

  void getTechnoNews() async {
    setLoading(true);

    final response = await dio.get(apiUrlTechno);
    technoResponse = NewsResponse.fromJson(response.data);
    print('Techno API status: ${technoResponse.messege}');

    setLoading(false);
  }

  void setLoading(bool status) {
    setState(() {
      isLoading = status;
    });
  }

  void _launchInWebViewOrVC(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'MNC News Lite',
          style: GoogleFonts.charm(
            textStyle: TextStyle(color: Colors.black),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () => Alert(message: 'Search Tapped').show(),
          ),
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.black,
            ),
            onPressed: () => Alert(message: 'Notification Tapped').show(),
          )
        ],
      ),
      body: ListView(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 16.0, top: 16.0),
              child: Text(
                "Trending News",
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      fontSize: 21.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 200.0,
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: trendResponse.data.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var item = trendResponse.data[index];
                      return InkWell(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                          child: NewsItemTrend(news: item),
                        ),
                        onTap: () => _launchInWebViewOrVC(item.url),
                      );
                    },
                  ),
          ),
          SizedBox(height: 15.0),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                "Techno News",
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      fontSize: 21.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: technoResponse.data.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (context, index) {
                    var item = technoResponse.data[index];
                    return InkWell(
                      child: Container(
                        width: double.infinity,
                        height: 135.0,
                        margin: EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 8.0),
                        child: NewsItemTechno(news: item),
                      ),
                      onTap: () => _launchInWebViewOrVC(item.url),
                    );
                  },
                )
        ],
      ),
    );
  }
}
