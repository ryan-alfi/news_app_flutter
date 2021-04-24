import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/model/news_model.dart';

class NewsItemTechno extends StatelessWidget {
  final News news;

  const NewsItemTechno({Key key, this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: Colors.grey.shade300, width: 1.0),
      ),
      child: Row(
        children: [
          Container(
            width: 90.0,
            height: 135.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              image: DecorationImage(
                image: NetworkImage(news.thumbnail),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    news.summary,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        fontSize: 12.0,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    news.published,
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
