import 'package:flutter/material.dart';
import 'package:flutter_jsp/provide/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import './details_page/details_top_area.dart';
import './details_page/details_explain.dart';
import './details_page/details_tabbar.dart';
import './details_page/details_web.dart';
import './details_page/details_bottom.dart';

class DetailsPage extends StatelessWidget {
  final String goddsId;

  DetailsPage(this.goddsId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('商品详细页'),
      ),
      body: FutureBuilder(
        future: _getBackInfo(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: ScreenUtil().setSp(80)),
                  child: ListView(
                    children: <Widget>[
                      DetailsTapArea(),
                      DetailsExplain(),
                      DetailsTabbar(),
                      DetailsWeb(),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: DetailsBottom(),
                ),
              ],
            );
          } else {
            return Text('加载中');
          }
        },
      ),
    );
  }

  Future _getBackInfo(BuildContext context) async {
    await Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goddsId);
    return '完成加载';
  }
}
